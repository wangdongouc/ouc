/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the Institute nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE INSTITUTE AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * This file is part of the Contiki operating system.
 *
 */

#include "contiki.h"
#include "lib/random.h"
#include "sys/ctimer.h"
#include "net/ip/uip.h"
#include "net/ipv6/uip-ds6.h"
#include "net/ip/uip-udp-packet.h"
#include "sys/ctimer.h"
#ifdef WITH_COMPOWER
#include "powertrace.h"
#endif
#include <stdio.h> /* For printf() */
#include <stdint.h>
#include <string.h>

#include "dev/serial-line.h"
#include "net/ipv6/uip-ds6-route.h"

#define UDP_CLIENT_PORT 4321
#define UDP_SERVER_PORT 1234

#define UDP_EXAMPLE_ID  110

#define DEBUG DEBUG_FULL
#include "net/ip/uip-debug.h"

#ifndef PERIOD
#define PERIOD 3
#endif

#define START_INTERVAL		(15 * CLOCK_SECOND)
#define SEND_INTERVAL		(PERIOD * CLOCK_SECOND)
#define SEND_TIME		(random_rand() % (SEND_INTERVAL))
#define MAX_PAYLOAD_LEN		30


static struct uip_udp_conn *client_conn;
static uip_ipaddr_t server_ipaddr;

/*---------------------------------------------------------------------------*/
PROCESS(udp_client_process, "UDP client process");
AUTOSTART_PROCESSES(&udp_client_process);
/*---------------------------------------------------------------------------*/
static int seq_id;
static int reply;
char* lip;

static void
tcpip_handler(void)
{
  char *str;
  int i;
  int len=0;
  char buf[128];
  if(uip_newdata()) {
    str = uip_appdata;
    str[uip_datalen()] = '\0';
    reply++;
    printf("DATA recv '%s' (s:%d, r:%d) \r\n", str, seq_id, reply);
    if(str[0] == 'r' && str[1] == 'o' && str[2] == 'u' && str[3] == 't' && str[4] == 'e') 
    {
        uip_ds6_route_t *r;
        uip_ipaddr_t *nexthop;
        uip_ds6_defrt_t *defrt;
        uip_ipaddr_t *ipaddr;
        defrt = NULL;
        if((ipaddr = uip_ds6_defrt_choose()) != NULL)
        {
          defrt = uip_ds6_defrt_lookup(ipaddr);
        }
        if(defrt != NULL) 
        {
          PRINTF("DefRT: :: -> %02d", defrt->ipaddr.u8[15]);
          PRINTF(" lt:%lu inf:%d\r\n", stimer_remaining(&defrt->lifetime),defrt->isinfinite);
          len+=sprintf(&buf[len],"DefRT: :: -> %02d  lt:%lu inf:%d",  defrt->ipaddr.u8[15], stimer_remaining(&defrt->lifetime), defrt->isinfinite);
          
        } else 
        {
          PRINTF("DefRT: :: -> NULL\r\n");
        }

        for(r = uip_ds6_route_head();
            r != NULL;
            r = uip_ds6_route_next(r)) 
        {
          nexthop = uip_ds6_route_nexthop(r);
          PRINTF("Route: %02d -> %02d", r->ipaddr.u8[15], nexthop->u8[15]);
	  	
          /* PRINT6ADDR(&r->ipaddr); */
          /* PRINTF(" -> "); */
          /* PRINT6ADDR(nexthop); */
          PRINTF(" lt:%lu\r\n", r->state.lifetime);
        }     
        
	uip_udp_packet_sendto(client_conn, buf, len, &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));	
        printf("Send data \'%s\'to server\r\n", buf);
    }
    if(str[0] == 'r' && str[1] == 'e' && str[2] == 's' && str[3] == 'e' && str[4] == 't') 
    {
       uip_udp_packet_sendto(client_conn, str, 5, &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));	
       printf("reset\r\n");
    }
    if(str[0] == 's' && str[1] == 't' && str[2] == 'a' && str[3] == 'r' && str[4] == 't') 
    {
       uip_udp_packet_sendto(client_conn, str, 5, &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));	
       printf("start\r\n");
    }
  }
}
/*---------------------------------------------------------------------------*/
static void
send_packet(void *ptr)
{ 
  int i;
  char buf[128];
  int len=0;
#ifdef SERVER_REPLY
  uint8_t num_used = 0;
  uip_ds6_nbr_t *nbr;

  nbr = nbr_table_head(ds6_neighbors);
  while(nbr != NULL) {
    nbr = nbr_table_next(ds6_neighbors, nbr);
    num_used++;
  }

  if(seq_id > 0) {
    ANNOTATE("#A r=%d/%d,color=%s,n=%d %d\r\n", reply, seq_id,
             reply == seq_id ? "GREEN" : "RED", uip_ds6_route_num_routes(), num_used);
  }
#endif /* SERVER_REPLY */

  seq_id++;
  PRINTF("DATA send to ");
  for(i=0;i<sizeof(server_ipaddr.u8);i=i+2)
  { 
     PRINTF("%02X%02X:",server_ipaddr.u8[i],server_ipaddr.u8[i+1]);
  }
  PRINTF("'Hello %d'\r\n",seq_id);
  len=0;
  for(i=0;i<16;i=i+2)
  { 
    len+=sprintf(&buf[len],"%X%X:",lip[i],lip[i+1]);
  }
  buf[len-1]='|';
  len+=sprintf(&buf[len], "Hello %d", seq_id);
  uip_udp_packet_sendto(client_conn, buf, len, &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));
}
/*---------------------------------------------------------------------------*/
static void
print_local_addresses(void)
{
  int i;
  uint8_t state;

  PRINTF("Client IPv6 addresses: ");
  for(i = 0; i < UIP_DS6_ADDR_NB; i++) {
    state = uip_ds6_if.addr_list[i].state;
    if(uip_ds6_if.addr_list[i].isused &&
       (state == ADDR_TENTATIVE || state == ADDR_PREFERRED)) {
      PRINT6ADDR(&uip_ds6_if.addr_list[i].ipaddr);
      lip=uip_ds6_if.addr_list[i].ipaddr.u8;
      //PRINTF("%2h",&uip_ds6_if.addr_list[i].ipaddr);
      PRINTF("\r\n");
      /* hack to make address "final" */
      if (state == ADDR_TENTATIVE) {
	uip_ds6_if.addr_list[i].state = ADDR_PREFERRED;
      }
    }
  }
}
/*---------------------------------------------------------------------------*/
static void
set_global_address(void)
{
  uip_ipaddr_t ipaddr;

  uip_ip6addr(&ipaddr, UIP_DS6_DEFAULT_PREFIX, 0, 0, 0, 0, 0, 0, 1);
  //uip_ip6addr(&ipaddr,  0xbbbb, 0, 0, 0, 0, 0, 0, 1);
  uip_ds6_set_addr_iid(&ipaddr, &uip_lladdr);
  uip_ds6_addr_add(&ipaddr, 0, ADDR_AUTOCONF);

/* The choice of server address determines its 6LoWPAN header compression.
 * (Our address will be compressed Mode 3 since it is derived from our
 * link-local address)
 * Obviously the choice made here must also be selected in udp-server.c.
 *
 * For correct Wireshark decoding using a sniffer, add the /64 prefix to the
 * 6LowPAN protocol preferences,
 * e.g. set Context 0 to fd00::. At present Wireshark copies Context/128 and
 * then overwrites it.
 * (Setting Context 0 to fd00::1111:2222:3333:4444 will report a 16 bit
 * compressed address of fd00::1111:22ff:fe33:xxxx)
 *
 * Note the IPCMV6 checksum verification depends on the correct uncompressed
 * addresses.
 */
 
//#if 0
/* Mode 1 - 64 bits inline */
 //  uip_ip6addr(&server_ipaddr, UIP_DS6_DEFAULT_PREFIX, 0xbbbb, 0, 0, 0, 0, 0, 1);
  uip_ip6addr(&server_ipaddr,  0x2001, 0x0da8, 0x0270, 0x2021, 0x0, 0x0, 0x0, 0x00cb);
//#elif 1
/* Mode 2 - 16 bits inline */
//  uip_ip6addr(&server_ipaddr, UIP_DS6_DEFAULT_PREFIX, 0, 0, 0, 0, 0x00ff, 0xfe00, 1);
//#else
/* Mode 3 - derived from server link-local (MAC) address */
//  uip_ip6addr(&server_ipaddr, UIP_DS6_DEFAULT_PREFIX, 0, 0, 0, 0x0250, 0xc2ff, 0xfea8, 0xcd1a); //redbee-econotag
//#endif

}
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(udp_client_process, ev, data)
{
  static struct etimer periodic;
  static struct ctimer backoff_timer;
#if WITH_COMPOWER
  static int print = 0;
#endif
  int i;
  int len;
  char buf[128];
  PROCESS_BEGIN();

  PROCESS_PAUSE();

  set_global_address();
  cc26xx_uart_set_input(serial_line_input_byte);
  PRINTF("UDP client process started nbr:%d routes:%d\r\n",
         NBR_TABLE_CONF_MAX_NEIGHBORS, UIP_CONF_MAX_ROUTES);

  print_local_addresses();

  /* new connection with remote host */
  client_conn = udp_new(NULL, UIP_HTONS(UDP_SERVER_PORT), NULL); 
  if(client_conn == NULL) {
    PRINTF("No UDP connection available, exiting the process!\r\n");
    PROCESS_EXIT();
  }
  udp_bind(client_conn, UIP_HTONS(UDP_CLIENT_PORT)); 

  PRINTF("Created a connection with the server ");
  //PRINT6ADDR(&client_conn->ripaddr);
  PRINT6ADDR(&server_ipaddr);
  PRINTF(" local/remote port %u/%u\r\n",
	UIP_HTONS(client_conn->lport), UIP_HTONS(client_conn->rport));

#if WITH_COMPOWER
  powertrace_sniff(POWERTRACE_ON);
#endif

  etimer_set(&periodic, SEND_INTERVAL);
  while(1) {
    PROCESS_YIELD();
    if(ev == tcpip_event) 
    {
      tcpip_handler();
    }

    if(ev == serial_line_event_message && data != NULL) 
    {
      char *str;
      str = data;
      if(str[0] == 'r' && str[1] == 'o' && str[2] == 'u' && str[3] == 't' && str[4] == 'e') 
      {
        uip_ds6_route_t *r;
        uip_ipaddr_t *nexthop;
        uip_ds6_defrt_t *defrt;
        uip_ipaddr_t *ipaddr;
        defrt = NULL;
        if((ipaddr = uip_ds6_defrt_choose()) != NULL)
        {
          defrt = uip_ds6_defrt_lookup(ipaddr);
        }
        if(defrt != NULL) 
        {
          PRINTF("DefRT: :: -> %02d", defrt->ipaddr.u8[15]);
          PRINTF(" lt:%lu inf:%d\r\n", stimer_remaining(&defrt->lifetime),
                 defrt->isinfinite);
        } else 
        {
          PRINTF("DefRT: :: -> NULL\r\n");
        }

        for(r = uip_ds6_route_head();
            r != NULL;
            r = uip_ds6_route_next(r)) 
        {
          nexthop = uip_ds6_route_nexthop(r);
          PRINTF("Route: %02d -> %02d", r->ipaddr.u8[15], nexthop->u8[15]);
          /* PRINT6ADDR(&r->ipaddr); */
          /* PRINTF(" -> "); */
          /* PRINT6ADDR(nexthop); */
          PRINTF(" lt:%lu\r\n", r->state.lifetime);
        }
      }
      else
      {
        len=0;
        for(i=0;i<16;i=i+2)
        { 
          len+=sprintf(&buf[len],"%02X%02X:",lip[i],lip[i+1]);
        }
        buf[len-1]='|';
        memcpy(&buf[len],data,strlen(data));
	uip_udp_packet_sendto(client_conn, buf, strlen(data)+len, &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));	
        // uip_udp_packet_sendto(client_conn, data, strlen(data), &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));
         printf("Send data \'%s\'to server\r\n", data);
      }
    }

    if(etimer_expired(&periodic)) {
      etimer_reset(&periodic);
      ctimer_set(&backoff_timer, SEND_TIME, send_packet, NULL);

#if WITH_COMPOWER
      if (print == 0) {
	powertrace_print("#P");
      }
      if (++print == 3) {
	print = 0;
      }
#endif

    }
  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
