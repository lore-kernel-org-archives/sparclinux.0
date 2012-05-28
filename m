From: Marcel van Nies <morcles@gmail.com>
Date: Mon, 28 May 2012 13:59:26 +0000
Subject: sparc32: some more testing
Message-Id: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I tried today's sparc.git on a number of systems:

UP kernel:
IPX : not supported (as expected)
SS5 with MicroSPARC-II 110MHz : works
SS5 with TurboSPARC 170MHz : works
SS20 with SuperSPARC-II 75MHz : boots, but various binaries either
BUG, give "Illegal instruction", receive signal 4, ...
SS20 with HyperSPARC 125MHz : boots, INIT segfaults

SMP kernel:
SS20 with dual SuperSPARC-II 75MHz :  boots, loading INIT is
slooooooow ... takes like 1 minute or so ... finally system freezes
SS20 with quad HyperSPARC 125MHz : boots, INIT segfaults

M

== IPX =
SPARCstation IPX, No Keyboard
ROM Rev. 2.9, 64 MB memory installed, Serial #2361201.
Ethernet address 8:0:20:16:17:18, Host ID: 57161718.

ok boot net
Boot device: /sbus/le@0,c00000   File and args:
364a00
Sparc-Linux sun4/sun4c or MMU-less not supported

Program terminated
ok

== SS5 MicroSPARC-II =
cat /proc/cpuinfo
cpu             : Fujitsu  MB86904
fpu             : Lsi Logic/Meiko L64804 or compatible
promlib         : Version 3 Revision 2
prom            : 2.24
type            : sun4m
ncpus probed    : 1
ncpus active    : 1
CPU0Bogo        : 108.03
CPU0ClkTck      : 0
MMU type        : Fujitsu Swift
contexts        : 256
nocache total   : 2252800
nocache used    : 217088

uname -a
Linux micro 3.4.0-08241-gd4511e6 #3 Mon May 28 10:56:20 CEST 2012
sparc sun4m Fujitsu MB86904 GNU/Linux

== SS5 TurboSPARC =
cat /proc/cpuinfo
cpu             : Fujitsu TurboSparc MB86907
fpu             : No FPU
promlib         : Version 3 Revision 2
prom            : 2.29
type            : sun4m
ncpus probed    : 1
ncpus active    : 1
CPU0Bogo        : 166.91
CPU0ClkTck      : 0
MMU type        : Fujitsu TurboSparc
contexts        : 256
nocache total   : 2252800
nocache used    : 231168

uname -a
Linux turbo 3.4.0-08241-gd4511e6 #3 Mon May 28 10:56:20 CEST 2012
sparc sun4m Fujitsu TurboSparc MB86907 GNU/Linux

== SS20 SuperSPARC-II =Various binaries either BUG, give "Illegal instruction", receive signal 4, ...
Some examples (all binaries work fine on 2.6.x):

# ntpd
BUG: Bad page map in process ntpd  pte:01bd92bc pmd:0003f301
addr:5039b000 vm_flags:08000070 anon_vma:  (null) mapping:fb813848 index:9
vma->vm_ops->fault: filemap_fault+0x8/0x3d8
vma->vm_file->f_op->mmap: generic_file_mmap+0x8/0x6c
[f007b64c : unmap_vmas+0x3c/0x5c ]
[f0080e50 : exit_mmap+0xac/0x15c ]
[f001f8dc : mmput+0x2c/0xd4 ]
[f0024470 : exit_mm+0xd4/0x118 ]
[f0025f6c : do_exit+0x500/0x790 ]
[f0026444 : do_group_exit+0x28/0xb0 ]
[f0030768 : get_signal_to_deliver+0x198/0x4e4 ]
[f000ba40 : do_signal+0x44/0x768 ]
[f000c49c : do_notify_resume+0x2c/0x3c ]
[f00099bc : signal_p+0x14/0x24 ]
[50282ab8 : 0x50282ab8 ]
swap_free: Bad swap file entry a8000dec
BUG: Bad page map in process ntpd  pte:01bd95bc pmd:0003f301
addr:5039c000 vm_flags:08000070 anon_vma:  (null) mapping:fb813848 index:a
vma->vm_ops->fault: filemap_fault+0x8/0x3d8
vma->vm_file->f_op->mmap: generic_file_mmap+0x8/0x6c
[f007b64c : unmap_vmas+0x3c/0x5c ]
[f0080e50 : exit_mmap+0xac/0x15c ]
f001f8dc : mmput+0x2c/0xd4 ]
[f0024470 : exit_mm+0xd4/0x118 ]
[f0025f6c : do_exit+0x500/0x790 ]
[f0026444 : do_group_exit+0x28/0xb0 ]
[f0030768 : get_signal_to_deliver+0x198/0x4e4 ]
[f000ba40 : do_signal+0x44/0x768 ]
[f000c49c : do_notify_resume+0x2c/0x3c ]
[f00099bc : signal_p+0x14/0x24 ]
[50282ab8 : 0x50282ab8 ]
BUG: Bad rss-counter state mm:fbeca480 idx:0 val:2
BUG: Bad rss-counter state mm:fbeca480 idx:2 val:-2

# ps
Signal 4 (ILL) caught by ps (procps version 3.2.7).

# /usr/sbin/sshd
Illegal instruction

== SS20 HyperSPARC =INIT segfaults, both UP & SMP:

UP
Freeing unused kernel memory: 128k freed
init[1]: segfault at 0 ip 5000dac8 (rpc f0008c6c) sp ef8728a0 error
30001 in ld-2.3.5.so[50000000+1a000]
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[f0026444 : do_group_exit+0x28/0xb0 ]
[f0030768 : get_signal_to_deliver+0x198/0x4e4 ]
[f000ba40 : do_signal+0x44/0x768 ]
[f000c49c : do_notify_resume+0x2c/0x3c ]
[f00099bc : signal_p+0x14/0x24 ]
[f0008c6c : srmmu_fault+0x58/0x68 ]
Press Stop-A (L1-A) to return to the boot prom

SMP
Freeing unused kernel memory: 156k freed
init[1]: segfault at 0 ip 5000dac8 (rpc f000bf68) sp efac38a0 error
30001 in ld-2.3.5.so[50000000+1a000]
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[f002b2a4 : do_group_exit+0x28/0xbc ]
[f00360c8 : get_signal_to_deliver+0x1a8/0x51c ]
[f000eef4 : do_signal+0x44/0x768 ]
[f000f950 : do_notify_resume+0x2c/0x3c ]
[f000ccdc : signal_p+0x14/0x24 ]
[f000bf68 : srmmu_fault+0x58/0x68 ]
Press Stop-A (L1-A) to return to the boot prom
