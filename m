From: Aaron Wirtz <awirtz@novapointe.com>
Date: Tue, 16 Mar 2004 20:10:00 +0000
Subject: Oops in 2.4.x SunFire V100
Message-Id: <200403161210.00075.awirtz@novapointe.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've seen this several times now, running different revisions of the 2.4 
kernel.  Judging by the stack trace I might guess that this has something to 
do with an error in the Tulip driver, which I would be inclined to believe 
considering this machine has an odd onboard Davicom chipset that has some 
other problems as well. (If it loses link for >2 seconds, it requires power 
cycle before working again)  If you think I should, I could try logging all 
packets going to that interface (logged at the gateway of course) to try to 
find the one that causes the crash (if it is indeed triggered by a particular 
data sequence), but it may be another month or two before the next oops shows 
up.  This oops happens very seldom (once every month or two)
Thanks for your help.

-Aaron

Here is the kysmoops info from the latest crash (this time on 2.4.24, with no 
external modules loaded.  Ksymoops only says 2.4.20 because that is what the 
machine reverted to on reboot after 2.4.24 crashed.  The vmlinux and oops 
file are from 2.4.24):

ksymoops 2.4.9 on sparc64 2.4.20.  Options used
     -v ./vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m ./System.map (specified)

Unable to handle kernel paging request in mna handler<1> at virtual address 
3048796472617499
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops
TSTATE: 0000009980f09603 TPC: 0000000000460484 TNPC: 0000000000460488 Y: 
00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 000000000000000f g1: fffff8004559ee40 g2: fffff8004559ee40 g3: 
fffff8004559ee40
g4: fffff80000000000 g5: 0000000000000080 g6: 0000000000414000 g7: 
0000000000678000
o0: fffff8005ec6ae60 o1: 0000000000000000 o2: 000000000058e460 o3: 
0000000000000000
o4: 0000048169e7d43f o5: fffff8004559e640 sp: 0000000000416751 ret_pc: 
000000000058e298
l0: fffff800636316c8 l1: fffff800575e8bc8 l2: 0000000000713800 l3: 
000000000000209c
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000713800 l7: 
0000000000000008
i0: 3048796472617469 i1: 0000000000000000 i2: 000000000a000003 i3: 
0000000000000011
i4: 0000000000636c00 i5: 0000000000000000 i6: 0000000000416811 i7: 
00000000005778f4
Caller[00000000005778f4]
Caller[0000000000577948]
Caller[000000000057c824]
Caller[000000000052eeec]
Caller[000000000052f9bc]
Caller[000000000041cce4]
Caller[00000000004088d4]
Caller[000000000058e298]
Caller[000000000058e52c]
Caller[000000000058cfb8]
Caller[000000000058d40c]
Caller[000000000057cbf0]
Caller[000000000057cd94]
Caller[000000000057cef8]
Caller[0000000000447564]
Caller[000000000040eb40]
Caller[00000000004183c4]
Caller[0000000000658640]
Caller[0000000000404638]
Caller[0000000000000000]
Instruction DUMP: 01000000  01000000  9de3bf40 <c25e2030> 90102001  8338700e  
82086001  80a06000  12480009


>>PC;  00460484 <__free_pages+4/60>   <==
>>g6; 00414000 <init_task_union+0/4000>
>>g7; 00678000 <__init_end+0/0>
>>o2; 0058e460 <ip_defrag+40/1c0>
>>sp; 00416751 <init_task_union+2751/4000>
>>ret_pc; 0058e298 <ip_frag_reasm+258/3e0>
>>l2; 00713800 <ip_frag_nqueues+0/0>
>>l6; 00713800 <ip_frag_nqueues+0/0>
>>i4; 00636c00 <rtc_fops+10/90>
>>i6; 00416811 <init_task_union+2811/4000>
>>i7; 005778f4 <skb_release_data+74/c0>

Trace; 005778f4 <skb_release_data+74/c0>
Trace; 00577948 <kfree_skbmem+8/80>
Trace; 0057c824 <netif_rx+e4/1e0>
Trace; 0052eeec <tulip_rx+30c/4c0>
Trace; 0052f9bc <tulip_interrupt+91c/9a0>
Trace; 0041cce4 <handler_irq+1a4/220>
Trace; 004088d4 <tl0_irq5+34/40>
Trace; 0058e298 <ip_frag_reasm+258/3e0>
Trace; 0058e52c <ip_defrag+10c/1c0>
Trace; 0058cfb8 <ip_local_deliver+178/1c0>
Trace; 0058d40c <ip_rcv+40c/4e0>
Trace; 0057cbf0 <netif_receive_skb+f0/220>
Trace; 0057cd94 <process_backlog+74/160>
Trace; 0057cef8 <net_rx_action+78/160>
Trace; 00447564 <do_softirq+e4/100>
Trace; 0040eb40 <__handle_softirq+0/10>
Trace; 004183c4 <cpu_idle+44/60>
Trace; 00658640 <start_kernel+160/180>
Trace; 00404638 <tlb_fixup_done+54/5c>
Trace; 00000000 Before first symbol

Code;  00460478 <get_zeroed_page+38/40>
00000000 <_PC>:
Code;  00460478 <get_zeroed_page+38/40>
   0:   01 00 00 00       nop
Code;  0046047c <get_zeroed_page+3c/40>
   4:   01 00 00 00       nop
Code;  00460480 <__free_pages+0/60>
   8:   9d e3 bf 40       save  %sp, -192, %sp
Code;  00460484 <__free_pages+4/60>   <==   c:   c2 5e 20 30       unknown   <==Code;  00460488 <__free_pages+8/60>
  10:   90 10 20 01       mov  1, %o0
Code;  0046048c <__free_pages+c/60>
  14:   83 38 70 0e       unknown
Code;  00460490 <__free_pages+10/60>
  18:   82 08 60 01       and  %g1, 1, %g1
Code;  00460494 <__free_pages+14/60>
  1c:   80 a0 60 00       cmp  %g1, 0
Code;  00460498 <__free_pages+18/60>
  20:   12 48 00 09       unknown

Kernel panic: Aiee, killing interrupt handler!
