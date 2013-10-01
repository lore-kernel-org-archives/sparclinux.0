From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Tue, 01 Oct 2013 23:08:08 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <524B55D8.5020203@oracle.com>
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
Run a java load with hugepages and we see following error. (will try 
without these patches shortly)

BUG: soft lockup - CPU#28 stuck for 22s! [java:23678]
Modules linked in: ext4(F) jbd2(F) mbcache(F) dm_round_robin(F) 
scsi_dh_emc(F) usb_storage(F) sr_mod(F) cdrom(F) sd_mod(F) 
megaraid_sas(F) ixgbe(F) igb(F) hwmon(F) i2c_algo_bit(F) i2c_core(F) 
ptp(F) pps_core(F) lpfc(F) scsi_transport_fc(F) scsi_tgt(F) 
crc_t10dif(F) crct10dif_common(F) mpt2sas(F) scsi_transport_sas(F) 
raid_class(F) camellia_sparc64(F) sha256_sparc64(F) aes_sparc64(F) 
sha512_sparc64(F) crc32c_sparc64(F) des_sparc64(F) des_generic(F) 
dm_multipath(F) sunvnet(F) sunvdc(F) dm_mirror(F) dm_region_hash(F) 
dm_log(F) dm_mod(F) be2iscsi(F) bnx2i(F) cnic(F) uio(F) ipv6(F) 
cxgb4i(F) cxgb4(F) cxgb3i(F) libcxgbi(F) cxgb3(F) mdio(F) 
libiscsi_tcp(F) qla4xxx(F) iscsi_boot_sysfs(F) libiscsi(F) 
scsi_transport_iscsi(F)
CPU: 28 PID: 23678 Comm: java Tainted: GF 3.12.0-16mainline.sparc64 #1
task: ffff800fc71c28e0 ti: ffff800e48290000 task.ti: ffff800e48290000
TSTATE: 0000004411001604 TPC: 000000000043eb10 TNPC: 000000000043eb14 Y: 
00000000    Tainted: GF
TPC: <xcall_deliver+0x110/0x140>
g0: 00000000004209d0 g1: 0000000000000000 g2: 000000000000007f g3: 
0000000000000001
g4: ffff800fc71c28e0 g5: ffff800fde52c000 g6: ffff800e48290000 g7: 
0000000000000006
o0: 0000000000c9bd40 o1: 000000000000003f o2: 0000000000000040 o3: 
000000000000003e
o4: 000000000000007e o5: 0000000000002710 sp: ffff800e48292a21 ret_pc: 
000000000043eb20
RPC: <xcall_deliver+0x120/0x140>
l0: 000000000000003f l1: 0000000000b8290c l2: 000000000000001c l3: 
000000000093db10
l4: ffff8000207d8040 l5: 0000000000c9bd40 l6: 0000000000000000 l7: 
0000000000000008
i0: 0000038800456034 i1: fffffc0448050000 i2: 0000000000000000 i3: 
ffff800025a35470
i4: 0000000000000000 i5: 000050d808df29c7 i6: ffff800e48292ad1 i7: 
000000000043fca4
I7: <smp_flush_tlb_page+0x44/0xc0>
Call Trace:
  [000000000043fca4] smp_flush_tlb_page+0x44/0xc0
  [0000000000456758] tlb_batch_add+0x178/0x1c0
  [0000000000458ccc] huge_ptep_get_and_clear+0x8c/0xc0
  [0000000000570654] __unmap_hugepage_range+0x134/0x280
  [000000000057153c] __unmap_hugepage_range_final+0x1c/0x40
  [000000000055771c] unmap_single_vma+0x9c/0xc0
  [0000000000557768] unmap_vmas+0x28/0x60
  [000000000055a0c8] exit_mmap+0x88/0x160
  [0000000000465014] mmput+0x54/0xe0
  [000000000046841c] exit_mm+0x13c/0x1a0
  [0000000000469ab0] do_exit+0x130/0x440
  [0000000000469df0] do_group_exit+0x30/0xc0
  [000000000047ab70] get_signal_to_deliver+0x1f0/0x4c0
  [000000000042d674] do_signal+0x54/0x540
  [000000000042dba8] do_notify_resume+0x48/0x80
  [0000000000404b04] __handle_signal+0xc/0x2c



And in few minutes :

SUN4V-DTLB: Error at TPC[fffffc01009e9af4], tl 1
SUN4V-DTLB: TPC<0xfffffc01009e9af4>
SUN4V-DTLB: O7[fffffc01093839d0]
SUN4V-DTLB: O7<0xfffffc01093839d0>
SUN4V-DTLB: vaddr[fffffc01000bc000] ctx[1c6c] pte[9a000000000f0610] error[2]

Machine hard hung.

Thanks,
-Guru
