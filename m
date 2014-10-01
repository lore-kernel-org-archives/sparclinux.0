From: Bob Picco <bob.picco@oracle.com>
Date: Wed, 01 Oct 2014 21:51:09 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141001215109.GM24131@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Wed Oct 01 2014, 04:44:55PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Wed, 01 Oct 2014 16:42:01 -0400 (EDT)
> 
> > From: Bob Picco <bpicco@meloft.net>
> > Date: Wed, 1 Oct 2014 10:29:00 -0400
> > 
> >> [root@ca-qasparc24 ~]# Unable to handle kernel NULL pointer dereference
> >> BUG: Bad page map in process cc1  pte:9800003fdd860690 pmd:183f3f4b6000
> >> page:000600007fbb0c00 count:107055216 mapcount:-524287 mapping:          (null) index:0xfff8000107659c00
> >> page flags: 0x6c4b6e00004f56(error|referenced|dirty|active|owner_priv_1|arch_1|reserved|private|head)
> >> page dumped because: bad pte
> > 
> > The first thing I notice is that the count, mapcount, and flags are all garbage.
> > 
> > But not just random garbage, all of the non-zero bytes in the page
> > flags are in visible the ASCII character range.
> > 
> > 0x6c = 'l'
> > 0x4b = 'K'
> > 0x6e = 'n'
> > 0x4f = 'O'
> > 0x56 = 'V'
> > 
> > Anyways, just FYI...
> 
> Also, Bob, that "Unable to handle kernel NULL pointer dereference"
> should have placed a good register dump and backtrace into the kernel
> logs, maybe you can provide that as well.
I'll let you examine this one closely. I was examining code and what was
observed on Sunday and not inspected closely.

On T4-2 I'm obtaining a solid baseline. sparc.git !THP and !HUGEPAGES
with spec-jbb. It appears good.

On T5-8 I did build sparc.git but not with as massive parallel make -j10.

Please let me know should you want more or whether this is worthless.

BUG: Bad page map in process cc1  pte:9800003fdd860690 pmd:183f3f4b6000
page:000600007fbb0c00 count:107055216 mapcount:-524287 mapping:          (null) index:0xfff8000107659c00
page flags: 0x6c4b6e00004f56(error|referenced|dirty|active|owner_priv_1|arch_1|reserved|private|head)
page dumped because: bad pte
addr:0000000000124000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:12
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 497 PID: 19886 Comm: cc1 Tainted: G             L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
 [000000000046a750] do_exit+0x130/0x440
 [000000000046aa90] do_group_exit+0x30/0xc0
 [000000000046ab3c] SyS_exit_group+0x1c/0x40
 [0000000000406234] linux_sparc_syscall+0x34/0x44
Disabling lock debugging due to kernel taint
BUG: Bad page map in process cc1  pte:9800003fdd860690 pmd:183f3c6e4000
page:000600007fbb0c00 count:107055215 mapcount:-524288 mapping:          (null) index:0xfff8000107659c00
page flags: 0x6c4b6e00004f56(error|referenced|dirty|active|owner_priv_1|arch_1|reserved|private|head)
page dumped because: bad pte
addr:0000000000124000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:12
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 442 PID: 19996 Comm: cc1 Tainted: G    B        L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
Unable to handle kernel NULL pointer dereference
 [000000000046a750] do_exit+0x130/0x440
tsk->{mm,active_mm}->context = 00000000000017c4
tsk->{mm,active_mm}->pgd = fff8003e95b7e000
 [000000000046aa90] do_group_exit+0x30/0xc0
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
 [000000000046ab3c] SyS_exit_group+0x1c/0x40
cc1(20076): Oops [#1]
 [0000000000406234] linux_sparc_syscall+0x34/0x44
CPU: 105 PID: 20076 Comm: cc1 Tainted: G    B        L 3.17.0-rc7 #1
task: fff8003f07de88a0 ti: fff8003e95c88000 task.ti: fff8003e95c88000
TSTATE: 0000000011e01602 TPC: 000000000058ea2c TNPC: 000000000058ea30 Y: fcdcf300    Tainted: G    B        L
TPC: <kfree+0x8c/0x2a0>
g0: fff8003fddef7888 g1: 0006000000000000 g2: 00000000000003c8 g3: 0000000000be6800
g4: fff8003f07de88a0 g5: fff8003f5c98e000 g6: fff8003e95c88000 g7: 0000000000d62000
o0: 0000000000000000 o1: 0000000000000081 o2: 0000000000000020 o3: 0000000000000000
o4: 0000000000008000 o5: 0000000000000008 sp: fff8003e95c8aff1 ret_pc: 000000000063e4cc
RPC: <security_inode_permission+0x2c/0x40>
l0: 0000000000000000 l1: fff8003f0852f220 l2: 0000000000000000 l3: 0000000000643408
l4: 0000000000000014 l5: 00000000009fd430 l6: fff8003e95c88000 l7: 00000000005a1860
i0: fff8003f0852f220 i1: 0000000000000081 i2: 0000000000000010 i3: 0000000014fed5a6
i4: 0000000000666100 i5: 0000000000000078 i6: fff8003e95c8b0c1 i7: 0000000000643030
I7: <selinux_file_free_security+0x10/0x20>
Call Trace:
 [0000000000643030] selinux_file_free_security+0x10/0x20
 [000000000063c2b8] security_file_free+0x18/0x40
 [00000000005a55c8] put_filp+0x28/0x60
 [00000000005b336c] path_openat+0xec/0x4c0
 [00000000005b3868] do_filp_open+0x28/0xa0
 [00000000005a1728] do_sys_open+0x148/0x240
 [00000000005a1884] SyS_open+0x24/0x40
 [0000000000406234] linux_sparc_syscall+0x34/0x44
Caller[0000000000643030]: selinux_file_free_security+0x10/0x20
Caller[000000000063c2b8]: security_file_free+0x18/0x40
Caller[00000000005a55c8]: put_filp+0x28/0x60
Caller[00000000005b336c]: path_openat+0xec/0x4c0
Caller[00000000005b3868]: do_filp_open+0x28/0xa0
Caller[00000000005a1728]: do_sys_open+0x148/0x240
Caller[00000000005a1884]: SyS_open+0x24/0x40
Caller[0000000000406234]: linux_sparc_syscall+0x34/0x44
Caller[0000000000659d38]: constraint_expr_eval+0x658/0x6a0
Instruction DUMP: 84048002  80a36001  04400015 <e658a008> c459e2b8  a207a7e7  c658e198  84260002  f077a7f7 
BUG: Bad page map in process cc1  pte:9800003fdd860690 pmd:3e95b92000
page:000600007fbb0c00 count:107055215 mapcount:-524289 mapping:          (null) index:0xfff8000107659c00
page flags: 0x6c4b6e00004f56(error|referenced|dirty|active|owner_priv_1|arch_1|reserved|private|head)
page dumped because: bad pte
addr:0000000000124000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:12
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 105 PID: 20076 Comm: cc1 Tainted: G    B D      L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
 [000000000046a750] do_exit+0x130/0x440
 [0000000000428500] die_if_kernel+0x1a0/0x340
 [000000000097f498] unhandled_fault+0x78/0xe0
 [000000000097f528] do_kernel_fault+0x28/0x100
 [000000000097f820] do_sparc64_fault+0x220/0x7a0
 [0000000000407b8c] sparc64_realfault_common+0x10/0x20
 [000000000058ea2c] kfree+0x8c/0x2a0
 [0000000000643030] selinux_file_free_security+0x10/0x20
BUG: Bad page map in process cc1  pte:9800003f0a92c690 pmd:3e95b92000
page:000600007e152580 count:0 mapcount:-1 mapping:          (null) index:0x0
page flags: 0x0()
page dumped because: bad pte
addr:0000000000126000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:13
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 105 PID: 20076 Comm: cc1 Tainted: G    B D      L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
 [000000000046a750] do_exit+0x130/0x440
 [0000000000428500] die_if_kernel+0x1a0/0x340
 [000000000097f498] unhandled_fault+0x78/0xe0
 [000000000097f528] do_kernel_fault+0x28/0x100
 [000000000097f820] do_sparc64_fault+0x220/0x7a0
 [0000000000407b8c] sparc64_realfault_common+0x10/0x20
 [000000000058ea2c] kfree+0x8c/0x2a0
 [0000000000643030] selinux_file_free_security+0x10/0x20
BUG: Bad page map in process cc1  pte:9800003f0c4d8690 pmd:3e95b92000
page:000600007e189b00 count:0 mapcount:-1 mapping:          (null) index:0x0
page flags: 0x0()
page dumped because: bad pte
addr:0000000000128000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:14
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 105 PID: 20076 Comm: cc1 Tainted: G    B D      L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
 [000000000046a750] do_exit+0x130/0x440
 [0000000000428500] die_if_kernel+0x1a0/0x340
 [000000000097f498] unhandled_fault+0x78/0xe0
 [000000000097f528] do_kernel_fault+0x28/0x100
 [000000000097f820] do_sparc64_fault+0x220/0x7a0
 [0000000000407b8c] sparc64_realfault_common+0x10/0x20
 [000000000058ea2c] kfree+0x8c/0x2a0
 [0000000000643030] selinux_file_free_security+0x10/0x20
BUG: Bad page map in process cc1  pte:9800003f0d876690 pmd:3e95b92000
page:000600007e1b0ec0 count:0 mapcount:-1 mapping:fff800010722cf60 index:0x0
page flags: 0x0()
page dumped because: bad pte
addr:000000000027a000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:bd
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 105 PID: 20076 Comm: cc1 Tainted: G    B D      L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
 [000000000046a750] do_exit+0x130/0x440
 [0000000000428500] die_if_kernel+0x1a0/0x340
 [000000000097f498] unhandled_fault+0x78/0xe0
 [000000000097f528] do_kernel_fault+0x28/0x100
 [000000000097f820] do_sparc64_fault+0x220/0x7a0
 [0000000000407b8c] sparc64_realfault_common+0x10/0x20
 [000000000058ea2c] kfree+0x8c/0x2a0
 [0000000000643030] selinux_file_free_security+0x10/0x20
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000001835
tsk->{mm,active_mm}->pgd = fff8003e95bf0000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
cc1(20161): Oops [#2]
CPU: 3 PID: 20161 Comm: cc1 Tainted: G    B D      L 3.17.0-rc7 #1
task: fff8003e95e19d20 ti: fff8003e95e1c000 task.ti: fff8003e95e1c000
TSTATE: 0000000011e01602 TPC: 000000000058ea2c TNPC: 000000000058ea30 Y: fcdcf300    Tainted: G    B D      L
TPC: <kfree+0x8c/0x2a0>
g0: fff8003fddef7888 g1: 0006000000000000 g2: 0000000000000098 g3: 0000000000be6800
g4: fff8003e95e19d20 g5: fff8003f5c32e000 g6: fff8003e95e1c000 g7: 0000000000d62000
o0: 0000000000000000 o1: 0000000000000081 o2: 0000000000000020 o3: 0000000000000000
o4: 0000000000008000 o5: 0000000000000008 sp: fff8003e95e1eff1 ret_pc: 000000000063e4cc
RPC: <security_inode_permission+0x2c/0x40>
l0: 0000000000000000 l1: fff8003f0f5887e0 l2: 0000000000000000 l3: 0000000000643408
l4: 0000000000000014 l5: 00000000009e3e40 l6: fff8003e95e1c000 l7: 00000000005a1860
i0: fff8003f0f5887e0 i1: 0000000000000081 i2: 0000000000000010 i3: 000000007b401fe7
i4: 0000000000b9f723 i5: 0000000000000078 i6: fff8003e95e1f0c1 i7: 0000000000643030
I7: <selinux_file_free_security+0x10/0x20>
Call Trace:
 [0000000000643030] selinux_file_free_security+0x10/0x20
 [000000000063c2b8] security_file_free+0x18/0x40
 [00000000005a55c8] put_filp+0x28/0x60
 [00000000005b336c] path_openat+0xec/0x4c0
 [00000000005b3868] do_filp_open+0x28/0xa0
 [00000000005a1728] do_sys_open+0x148/0x240
 [00000000005a1884] SyS_open+0x24/0x40
 [0000000000406234] linux_sparc_syscall+0x34/0x44
Caller[0000000000643030]: selinux_file_free_security+0x10/0x20
Caller[000000000063c2b8]: security_file_free+0x18/0x40
Caller[00000000005a55c8]: put_filp+0x28/0x60
Caller[00000000005b336c]: path_openat+0xec/0x4c0
Caller[00000000005b3868]: do_filp_open+0x28/0xa0
Caller[00000000005a1728]: do_sys_open+0x148/0x240
Caller[00000000005a1884]: SyS_open+0x24/0x40
Caller[0000000000406234]: linux_sparc_syscall+0x34/0x44
Caller[0000000000659d38]: constraint_expr_eval+0x658/0x6a0
Instruction DUMP: 84048002  80a36001  04400015 <e658a008> c459e2b8  a207a7e7  c658e198  84260002  f077a7f7 
BUG: Bad page map in process cc1  pte:9800003fdd860690 pmd:3e95e48000
page:000600007fbb0c00 count:107055215 mapcount:-524290 mapping:          (null) index:0xfff8000107659c00
page flags: 0x6c4b6e00004f56(error|referenced|dirty|active|owner_priv_1|arch_1|reserved|private|head)
page dumped because: bad pte
addr:0000000000124000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:12
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 3 PID: 20161 Comm: cc1 Tainted: G    B D      L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
 [000000000046a750] do_exit+0x130/0x440
 [0000000000428500] die_if_kernel+0x1a0/0x340
 [000000000097f498] unhandled_fault+0x78/0xe0
 [000000000097f528] do_kernel_fault+0x28/0x100
 [000000000097f820] do_sparc64_fault+0x220/0x7a0
 [0000000000407b8c] sparc64_realfault_common+0x10/0x20
 [000000000058ea2c] kfree+0x8c/0x2a0
 [0000000000643030] selinux_file_free_security+0x10/0x20
BUG: Bad page map in process cc1  pte:9800003f0a92c690 pmd:3e95e48000
page:000600007e152580 count:0 mapcount:-2 mapping:          (null) index:0x0
page flags: 0x4(referenced)
page dumped because: bad pte
addr:0000000000126000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:13
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 3 PID: 20161 Comm: cc1 Tainted: G    B D      L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
 [000000000046a750] do_exit+0x130/0x440
 [0000000000428500] die_if_kernel+0x1a0/0x340
 [000000000097f498] unhandled_fault+0x78/0xe0
 [000000000097f528] do_kernel_fault+0x28/0x100
 [000000000097f820] do_sparc64_fault+0x220/0x7a0
 [0000000000407b8c] sparc64_realfault_common+0x10/0x20
 [000000000058ea2c] kfree+0x8c/0x2a0
 [0000000000643030] selinux_file_free_security+0x10/0x20
BUG: Bad page map in process cc1  pte:9800003f0ccc6690 pmd:3e95e48000


