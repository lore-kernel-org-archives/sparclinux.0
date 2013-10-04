From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Fri, 04 Oct 2013 02:07:11 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <524E22CF.6090102@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/30/2013 09:31 AM, David Miller wrote:
> This is a respin of the original page_offset and 64-bit page
> table changes with some minor changes and a bug fix:
>
> 1) Bob's ACKs for the first 6 patches added.
>
> 2) Don't use "UL" postfix for shift counts, there is code that
>     wants those to be "int", particularly printfs in mm/mm_init.c
>     that use the "%d" format specifier for SECTIONS_SHIFT.
>
> 3) Adjust VA_HOLE defines to match what the new 3-level page
>     tables can actually provide.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> --
On a t4-1 machine with 64gb RAM , run following testcase as

./a.out 10000

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

int main(int ac, char **av) {
     long int n,m,i;
     char *buf;

     if(ac < 2) {
         printf("Usage: %s <alloc_size_MB>\n",av[0]);
         exit(1);
     }
     sscanf(av[1],"%ld",&n);
     m=n*1024*1024;
     printf("Allocating %ld bytes (%d MB), please wait...\n",m,n);
     buf=malloc(n*1024*1024);
       for(i=0;i<m;*(buf+i++)=1)
                 ;
     printf("Sleeping ...\n");
     sleep(36000);
}


And run echo 1000000 > /proc/sys/vm/nr_hugepages couple of times. 
Machine becomes unusuable.
This includes "fix generic hugetlb pte check return type." patch as 
well.Oom killers and then lockups.
Will try wothout patches very soon.

Full message: http://pastebin.com/VW0Uxpqd



BUG: soft lockup - CPU#15 stuck for 22s! [abrt-action-sav:3155]
Modules linked in: ext4 jbd2 mbcache usb_storage sr_mod cdrom sd_mod 
megaraid_sas ixgbe igb hwmon i2c_algo_bit i2c_core ptp pps_core lpfc 
scsi_transport_fc scsi_tgt crc_t10dif crct10dif_common mpt2sas 
scsi_transport_sas raid_class des_sparc64 des_generic sha512_sparc64 
aes_sparc64 sha256_sparc64 crc32c_sparc64 camellia_sparc64 sunvnet 
sunvdc dm_mirror dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio 
ipv6 cxgb4i cxgb4 cxgb3i libcxgbi cxgb3 mdio libiscsi_tcp qla4xxx 
iscsi_boot_sysfs libiscsi scsi_transport_iscsi
CPU: 15 PID: 3155 Comm: abrt-action-sav Not tainted 
3.12.0-16mainline3.1.sparc64 #1
task: ffff800fcc66e620 ti: ffff800fcb46c000 task.ti: ffff800fcb46c000
TSTATE: 0000004411001606 TPC: 000000000052e7f0 TNPC: 000000000052e7f4 Y: 
00000000    Not tainted
TPC: <oom_kill_process+0x150/0x360>
g0: 0000000000b838e8 g1: ffff800fc5c06108 g2: 0000000000000000 g3: 
ffff800fde82ff8c
g4: ffff800fcc66e620 g5: ffff800fde45c000 g6: ffff800fcb46c000 g7: 
0000000000000720
o0: 0000000000b68000 o1: 0000000000ac56f0 o2: 0000000000000a7d o3: 
ffff800fc7f310a0
o4: 0000000000000000 o5: 0000000000000fd3 sp: ffff800fcb46ee51 ret_pc: 
000000000052e750
RPC: <oom_kill_process+0xb0/0x360>
l0: 0000000000000000 l1: 0000000000000000 l2: ffff800fc7f30c20 l3: 
ffff800fc5c05d80
l4: 0000000000b68000 l5: ffff800fff9dfad8 l6: 0000000000000034 l7: 
0000000001425e80
i0: ffff800fc7f30c20 i1: ffff800fc5c06078 i2: ffff800fc5c05d70 i3: 
ffff800fcb46f708
i4: 00000000007df02e i5: 0000000000000000 i6: ffff800fcb46ef11 i7: 
000000000052ec5c
I7: <out_of_memory+0x25c/0x2c0>
Call Trace:
  [000000000052ec5c] out_of_memory+0x25c/0x2c0
  [0000000000534830] __alloc_pages_nodemask+0x9d0/0xaa0
  [0000000000574e70] alloc_pages_vma+0x70/0x180
  [0000000000552cd4] __do_fault+0x294/0x520
  [00000000005543b8] handle_pte_fault+0xb8/0x240
  [0000000000554ca4] __handle_mm_fault+0xa4/0x140
  [0000000000554de4] handle_mm_fault+0xa4/0x180
  [0000000000936954] do_sparc64_fault+0x3f4/0x7c0
  [0000000000407a58] sparc64_realfault_common+0x10/0x20
BUG: NMI Watchdog detected LOCKUP on CPU19, ip 00934fc8, registers:
CPU: 19 PID: 3087 Comm: login Not tainted 3.12.0-16mainline3.1.sparc64 #1
task: ffff800fc8ffa120 ti: ffff800fcda10000 task.ti: ffff800fcda10000
TSTATE: 0000000011e01604 TPC: 0000000000934fc8 TNPC: 0000000000934fc0 Y: 
00000000    Not tainted
TPC: <_raw_spin_trylock_bh+0xc8/0x100>
g0: 0000000000040000 g1: 0000000080000000 g2: 0000000000000001 g3: 
0000000080000001
g4: ffff800fc8ffa120 g5: ffff800fde49c000 g6: ffff800fcda10000 g7: 
000000000000aaf2
o0: 00000000524e1b0c o1: 000000000501b316 o2: 0000000000000000 o3: 
0000000000000000
o4: 0000000000000000 o5: 0000000000000000 sp: ffff800fcda13541 ret_pc: 
00000000004e8064
RPC: <__audit_syscall_entry+0xa4/0x120>
l0: ffff800fcde31c00 l1: 0000000000000000 l2: 0000000000000000 l3: 
ffff800fcb022378
l4: 000000008c3439ca l5: 000007feff9a5298 l6: 000007feff9a5280 l7: 
fffffc01001254c8
i0: 0000000000b68000 i1: 0000000000000000 i2: 0000000000b9cbc8 i3: 
0000000000000000
i4: fffffffffffffff8 i5: 0000000000000000 i6: ffff800fcda135f1 i7: 
000000000047cd10
I7: <SyS_setpgid+0x30/0x180>
Call Trace:
  [000000000047cd10] SyS_setpgid+0x30/0x180
  [00000000004061d4] linux_sparc_syscall+0x34/0x44
CPU: 19 PID: 3087 Comm: login Not tainted 3.12.0-16mainline3.1.sparc64 #1
Call Trace:
  [000000000043dd10] die_nmi.clone.0+0x90/0x120
  [00000000009355a4] perfctr_irq+0x224/0x260
  [00000000004209f4] tl0_irq15+0x14/0x20
  [0000000000934fc8] _raw_spin_trylock_bh+0xc8/0x100
  [000000000047cd10] SyS_setpgid+0x30/0x180
  [00000000004061d4] linux_sparc_syscall+0x34/0x44

INFO: rcu_sched self-detected stall on CPU { 15} INFO: rcu_sched 
detected stalls on CPUs/tasks: { 15} (detected by 21, t002 jiffies, 
g55, c54, q8)
   CPU[  0]: TSTATE[0000000080001605] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/0:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[  1]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/1:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[  2]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/2:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[  3]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/3:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[  4]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/4:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[  5]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/5:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[  6]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/6:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[  7]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/7:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[  8]: TSTATE[0000004480001605] TPC[00000000006a5390] 
TNPC[00000000006a5394] TASK[swapper/8:0]
              TPC[atomic_add+0x10/0x54] 
O7[rcu_eqs_enter_common+0x28/0xe0] I7[rcu_idle_enter+0x64/0xe0] 
RPC[cpu_idle_loop+0x134/0x280]
   CPU[  9]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/9:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 10]: TSTATE[0000004480001605] TPC[00000000006a54e0] 
TNPC[00000000006a54e4] TASK[swapper/10:0]
              TPC[atomic64_add+0x10/0x54] 
O7[__rb_reserve_next+0xc8/0x140] I7[rb_reserve_next_event+0xbc/0x220] 
RPC[ring_buffer_lock_reserve+0xd8/0x140]
   CPU[ 11]: TSTATE[0000000080001600] TPC[000000000042fcc0] 
TNPC[000000000042fcc4] TASK[swapper/11:0]
              TPC[stick_get_tick+0x0/0x20] O7[sched_clock+0x10/0x40] 
I7[trace_clock_local+0x4/0x60] RPC[rb_reserve_next_event+0x78/0x220]
   CPU[ 12]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/12:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 13]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/13:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 14]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/14:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 15]: TSTATE[0000001180001606] TPC[00000000004064ac] 
TNPC[00000000004064b0] TASK[abrt-action-sav:3155]
              TPC[sun4v_con_write+0xc/0x18] 
O7[sunhv_console_write_paged+0x130/0x1c0] 
I7[call_console_drivers.clone.1+0xe4/0x140] 
RPC[console_cont_flush.clone.0+0xc0/0x180]
   CPU[ 16]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/16:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 17]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/17:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 18]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/18:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 19]: TSTATE[0000004411001603] TPC[0000000000934fc8] 
TNPC[0000000000934fc0] TASK[login:3087]
              TPC[_raw_spin_trylock_bh+0xc8/0x100] 
O7[proc_clear_tty+0x34/0x60] I7[forget_original_parent+0x1c/0x1c0] 
RPC[exit_notify+0xc/0x160]
   CPU[ 20]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/20:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
* CPU[ 21]: TSTATE[0000000080001604] TPC[000000000042d5fc] 
TNPC[000000000042d600] TASK[swapper/21:0]
              TPC[arch_cpu_idle+0x7c/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 22]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/22:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 23]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/23:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 24]: TSTATE[0000004411001606] TPC[0000000000934f38] 
TNPC[0000000000934f3c] TASK[a.out:3145]
              TPC[_raw_spin_trylock_bh+0x38/0x100] 
O7[put_super+0x18/0x40] I7[grab_super_passive+0xc/0xa0] 
RPC[super_cache_count+0x10/0xc0]
   CPU[ 25]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/25:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 26]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/26:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 27]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/27:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 28]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/28:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 29]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/29:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 30]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/30:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 31]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/31:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 32]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/32:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 33]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/33:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 34]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/34:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 35]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/35:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 36]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/36:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 37]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/37:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 38]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/38:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 39]: TSTATE[0000004411001602] TPC[0000000000934f34] 
TNPC[0000000000934f38] TASK[auditd:2657]
              TPC[_raw_spin_trylock_bh+0x34/0x100] 
O7[put_super+0x18/0x40] I7[grab_super_passive+0xc/0xa0] 
RPC[super_cache_count+0x10/0xc0]
   CPU[ 40]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/40:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 41]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/41:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 42]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/42:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 43]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/43:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 44]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/44:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 45]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/45:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 46]: TSTATE[0000004480001604] TPC[000000000042d5a4] 
TNPC[000000000042d5a8] TASK[swapper/46:0]
              TPC[arch_cpu_idle+0x24/0xa0] O7[rcu_idle_enter+0x64/0xe0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 47]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/47:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 48]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/48:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 49]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/49:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 50]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/50:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 51]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/51:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 52]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/52:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 53]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/53:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 54]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/54:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 55]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/55:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 56]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/56:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 57]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/57:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 58]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/58:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 59]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/59:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 60]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/60:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 61]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/61:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 62]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/62:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]
   CPU[ 63]: TSTATE[0000000080001604] TPC[000000000042d5f8] 
TNPC[000000000042d5fc] TASK[swapper/63:0]
              TPC[arch_cpu_idle+0x78/0xa0] O7[arch_cpu_idle+0x64/0xa0] 
I7[cpu_idle_loop+0x13c/0x280] RPC[cpu_startup_entry+0x20/0x40]


