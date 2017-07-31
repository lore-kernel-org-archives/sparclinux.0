From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 31 Jul 2017 21:48:07 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <CADxRZqzkUqWsHgw8eNHF4E_wi5a6d=hJnmEtm5omsw42tHAw+Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <22906.17109.563338.559874@gargle.gargle.HOWL> <20170727.221009.2117810548718510128.davem@davemloft.net>
 <22906.63899.54749.700924@gargle.gargle.HOWL> <CADxRZqzcDswmJA=nESkkqS7PFym4NGFxAXTUrFybzvx9ALdNfw@mail.gmail.com>
 <22908.31076.708982.410201@gargle.gargle.HOWL> <22911.25997.495345.538443@gargle.gargle.HOWL>
In-Reply-To: <22911.25997.495345.538443@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpelinux@gmail.com>
Cc: David Miller <davem@davemloft.net>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Mon, Jul 31, 2017 at 8:14 PM, Mikael Pettersson <mikpelinux@gmail.com> wrote:
> Mikael Pettersson writes:
>  > Anatoly Pugachev writes:
>  >  > On Fri, Jul 28, 2017 at 11:45 AM, Mikael Pettersson
>  >  > <mikpelinux@gmail.com> wrote:
>  >  > > It's an rpmbuild --rebuild of Fedora's strace-4.18-1.fc24.src.rpm, but according to the
>  >  > > build log the following should do it:
>  >  > >
>  >  > > export CFLAGS='-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -grecord-gcc-switches  -m32 -mcpu=ultrasparc'
>  >  > > ./configure --build=sparcv9-unknown-linux-gnu --host=sparcv9-unknown-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/u
>  >  > > sr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib --libexecdir=/usr/libexec --local
>  >  > > statedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info
>  >  > > make -j2
>  >  > > make -j2 -k check VERBOSE=1
>  >  >
>  >  > cant' reproduce it here on debian sparc64 LDOM:
>  >
>  > DaveM was also unable to reproduce it.
>  >
>  > I'll be investigating a possible kernel miscompile next.
>
> I don't think it's a miscompile.
>
> First I recompiled 4.13-rc2 with each of gcc-7, gcc-6, and gcc-5, each
> bootstrapped and regtested from the head of the respective FSF GCC branch:
> no change, kernel 4.11 works while kernels >= 4.12 OOPS.  So a miscompile
> seems unlikely.
>
> Then I ran a git bisect between v4.11 (good) and v4.12 (bad), booting
> each kernel and trying the problematic strace test binaries.  That
> identified the following as the first bad commit:
>
> commit 31af2f36d50e3b9b2fb7f17aa430c11c91f946c4
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Tue Mar 21 17:04:45 2017 -0400
>
>     sparc: switch to RAW_COPY_USER
>
>     ... and drop zeroing in sparc32.
>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> That touches the CPU model specific assembly code in arch/sparc/lib/ for
> copy_{to,from}_user and changes how it's wired into the rest of the kernel.
> There's different code for different UltraSPARC and Niagara generations,
> so if there is a bug in e.g. the USIII code, you won't see it on Niagara.

Just to let you know, just reproduced this OOPS on my v215 debian sparc64:

Aug 01 00:34:56 v215 kernel: capability: warning: `caps' uses
deprecated v2 capabilities in a way that may be insecure
Aug 01 00:34:56 v215 kernel: capability: warning: `caps' uses 32-bit
capabilities (legacy support in use)
Aug 01 00:35:00 v215 kernel: Netfilter messages via NETLINK v0.30.
Aug 01 00:35:00 v215 kernel: Initializing XFRM netlink socket
Aug 01 00:35:09 v215 kernel: mmap: remap_file_page (1155) uses
deprecated remap_file_pages() syscall. See
Documentation/vm/remap_file_pages.txt.
Aug 01 00:35:10 v215 kernel: Unable to handle kernel NULL pointer dereference
Aug 01 00:35:10 v215 kernel: tsk->{mm,active_mm}->context = 0000000000000de6
Aug 01 00:35:10 v215 kernel: tsk->{mm,active_mm}->pgd = fff000123d478000
Aug 01 00:35:10 v215 kernel:               \|/ ____ \|/
                                           "@'/ .. \`@"
                                           /_| \__/ |_\
                                              \__U_/
Aug 01 00:35:11 v215 kernel: sched_xetattr(1527): Oops [#1]
Aug 01 00:35:11 v215 kernel: CPU: 1 PID: 1527 Comm: sched_xetattr Not
tainted 4.12.0 #365
Aug 01 00:35:11 v215 kernel: task: fff0001231d41340 task.stack: fff000123dfc4000
Aug 01 00:35:11 v215 kernel: TSTATE: 0000004411001604 TPC:
0000000000a121fc TNPC: 0000000000a12210 Y: 00000000    Not tainted
Aug 01 00:35:11 v215 kernel: TPC: <__bzero+0x20/0xc0>
Aug 01 00:35:11 v215 kernel: g0: fff000123dfc7d20 g1: 0000000000000000
g2: 0000003000000000 g3: 0000000000000000
Aug 01 00:35:11 v215 kernel: g4: fff0001231d41340 g5: fff000123ed08000
g6: fff000123dfc4000 g7: 0000000000000030
Aug 01 00:35:11 v215 kernel: o0: 0000000000000030 o1: fff000123dfc7e70
o2: 0000000000000000 o3: 0000000000000030
Aug 01 00:35:11 v215 kernel: o4: fff000123dfc7e70 o5: 000000000000000a
sp: fff000123dfc75c1 ret_pc: 000000000049b294
Aug 01 00:35:11 v215 kernel: RPC: <SyS_sched_setattr+0x174/0x1a0>
Aug 01 00:35:11 v215 kernel: l0: 0000000000000000 l1: 0000000000000000
l2: 0000000000000000 l3: 0000000000000000
Aug 01 00:35:11 v215 kernel: l4: 0000000000000000 l5: 0000000000000000
l6: 0000000000000000 l7: 00000000f7d58000
Aug 01 00:35:12 v215 kernel: i0: 0000000000000000 i1: 00000000f7bc5ffc
i2: 0000000000000000 i3: fff000123dfc7e70
Aug 01 00:35:12 v215 kernel: i4: 0000000000000000 i5: fff000123dfc7e70
i6: fff000123dfc76a1 i7: 00000000004061b4
Aug 01 00:35:12 v215 kernel: I7: <linux_sparc_syscall32+0x34/0x60>
Aug 01 00:35:12 v215 kernel: Call Trace:
Aug 01 00:35:12 v215 kernel:  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
Aug 01 00:35:12 v215 kernel: Disabling lock debugging due to kernel taint
Aug 01 00:35:12 v215 kernel: Caller[00000000004061b4]:
linux_sparc_syscall32+0x34/0x60
Aug 01 00:35:12 v215 kernel: Caller[000000007000117c]: 0x7000117c
Aug 01 00:35:12 v215 kernel: Instruction DUMP:
Aug 01 00:35:12 v215 kernel:  c56a2000
Aug 01 00:35:12 v215 kernel:  808a2003
Aug 01 00:35:12 v215 kernel:  02480006
Aug 01 00:35:12 v215 kernel: <d42a2000>
Aug 01 00:35:12 v215 kernel:  90022001
Aug 01 00:35:12 v215 kernel:  808a2003
Aug 01 00:35:12 v215 kernel:  1247fffd
Aug 01 00:35:12 v215 kernel:  92226001
Aug 01 00:35:12 v215 kernel:  808a2007
Aug 01 00:35:12 v215 kernel:
Aug 01 00:35:13 v215 kernel: Unable to handle kernel NULL pointer dereference
Aug 01 00:35:13 v215 kernel: tsk->{mm,active_mm}->context = 00000000000012cb
Aug 01 00:35:14 v215 kernel: tsk->{mm,active_mm}->pgd = fff0001230a12000
Aug 01 00:35:14 v215 kernel:               \|/ ____ \|/
                                           "@'/ .. \`@"
                                           /_| \__/ |_\
                                              \__U_/
Aug 01 00:35:14 v215 kernel: sched_xetattr(2216): Oops [#2]
Aug 01 00:35:14 v215 kernel: CPU: 0 PID: 2216 Comm: sched_xetattr
Tainted: G      D         4.12.0 #365
Aug 01 00:35:14 v215 kernel: task: fff0001231d41340 task.stack: fff0001232754000
Aug 01 00:35:14 v215 kernel: TSTATE: 0000004411001601 TPC:
0000000000a121fc TNPC: 0000000000a12210 Y: 00000000    Tainted: G
D
Aug 01 00:35:14 v215 kernel: TPC: <__bzero+0x20/0xc0>
Aug 01 00:35:14 v215 kernel: g0: fff0001232757d20 g1: 0000000000000000
g2: 0000003000000000 g3: 0000000000000000
Aug 01 00:35:14 v215 kernel: g4: fff0001231d41340 g5: fff000123eb08000
g6: fff0001232754000 g7: 0000000000000030
Aug 01 00:35:14 v215 kernel: o0: 0000000000000030 o1: fff0001232757e70
o2: 0000000000000000 o3: 0000000000000030
Aug 01 00:35:14 v215 kernel: o4: fff0001232757e70 o5: 000000000000000a
sp: fff00012327575c1 ret_pc: 000000000049b294
Aug 01 00:35:14 v215 kernel: RPC: <SyS_sched_setattr+0x174/0x1a0>
Aug 01 00:35:14 v215 kernel: l0: 0000000000000000 l1: 0000000000000000
l2: 0000000000000000 l3: 0000000000000000
Aug 01 00:35:14 v215 kernel: l4: 0000000000000000 l5: 0000000000000000
l6: 0000000000000000 l7: 00000000f7cdc000
Aug 01 00:35:14 v215 kernel: i0: 0000000000000000 i1: 00000000f7b49ffc
i2: 0000000000000000 i3: fff0001232757e70
Aug 01 00:35:15 v215 kernel: i4: 0000000000000000 i5: fff0001232757e70
i6: fff00012327576a1 i7: 00000000004061b4
Aug 01 00:35:15 v215 kernel: I7: <linux_sparc_syscall32+0x34/0x60>
Aug 01 00:35:15 v215 kernel: Call Trace:
Aug 01 00:35:15 v215 kernel:  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
Aug 01 00:35:15 v215 kernel: Caller[00000000004061b4]:
linux_sparc_syscall32+0x34/0x60
Aug 01 00:35:15 v215 kernel: Caller[000000007000117c]: 0x7000117c
Aug 01 00:35:15 v215 kernel: Instruction DUMP:
Aug 01 00:35:15 v215 kernel:  c56a2000
Aug 01 00:35:15 v215 kernel:  808a2003
Aug 01 00:35:15 v215 kernel:  02480006
Aug 01 00:35:15 v215 kernel: <d42a2000>
Aug 01 00:35:15 v215 kernel:  90022001
Aug 01 00:35:15 v215 kernel:  808a2003
Aug 01 00:35:15 v215 kernel:  1247fffd
Aug 01 00:35:15 v215 kernel:  92226001
Aug 01 00:35:15 v215 kernel:  808a2007
Aug 01 00:35:15 v215 kernel:
Aug 01 00:35:16 v215 kernel: ------------[ cut here ]------------
Aug 01 00:35:16 v215 kernel: WARNING: CPU: 0 PID: 2900 at
arch/sparc/kernel/sys_sparc32.c:150
compat_SyS_sparc_sigaction+0x54/0x80
Aug 01 00:35:16 v215 kernel: Modules linked in: xfrm_user xfrm_algo
tcp_diag inet_diag af_packet_diag netlink_diag unix_diag nfnetlink
ohci_pci ata_generic tg3 ohci_hcd ehci_pci ptp ehci_hcd pps_core
libphy usbcore pata_ali libata sg flash jitterentropy_rng ip_tables
x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto raid10 raid456
libcrc32c crc32c_generic async_raid6_recov async_memcpy async_pq
raid6_pq async_xor xor async_tx raid1 raid0 multipath linear md_mod
dm_mod dax sd_mod mptsas scsi_transport_sas mptscsih scsi_mod mptbase
Aug 01 00:35:17 v215 kernel: CPU: 0 PID: 2900 Comm: sigaction Tainted:
G      D         4.12.0 #365
Aug 01 00:35:17 v215 kernel: Call Trace:
Aug 01 00:35:17 v215 kernel:  [000000000046b900] __warn+0xc0/0xe0
Aug 01 00:35:17 v215 kernel:  [000000000046b9e0] warn_slowpath_null+0x20/0x40
Aug 01 00:35:17 v215 kernel:  [000000000044b614]
compat_SyS_sparc_sigaction+0x54/0x80
Aug 01 00:35:17 v215 kernel:  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
Aug 01 00:35:17 v215 kernel: ---[ end trace 0413ef9096de5564 ]---
Aug 01 00:35:41 v215 kernel: Unable to handle kernel NULL pointer dereference
Aug 01 00:35:41 v215 kernel: tsk->{mm,active_mm}->context = 00000000000015f9
Aug 01 00:35:41 v215 kernel: tsk->{mm,active_mm}->pgd = fff0001230ab6000
Aug 01 00:35:41 v215 kernel:               \|/ ____ \|/
                                           "@'/ .. \`@"
                                           /_| \__/ |_\
                                              \__U_/
Aug 01 00:35:42 v215 kernel: poll(11551): Oops [#3]
Aug 01 00:35:42 v215 kernel: CPU: 1 PID: 11551 Comm: poll Tainted: G
   D W       4.12.0 #365
Aug 01 00:35:42 v215 kernel: task: fff000123c9113a0 task.stack: fff0001232e7c000
Aug 01 00:35:42 v215 kernel: TSTATE: 0000004411001603 TPC:
0000000000a121fc TNPC: 0000000000a12210 Y: 00000000    Tainted: G
D W
Aug 01 00:35:42 v215 kernel: TPC: <__bzero+0x20/0xc0>
Aug 01 00:35:42 v215 kernel: g0: fff000123cfce548 g1: 0000000000000000
g2: 0000000000000000 g3: 0000000000000000
Aug 01 00:35:42 v215 kernel: g4: fff000123c9113a0 g5: fff000123ed08000
g6: fff0001232e7c000 g7: 0000000000000008
Aug 01 00:35:42 v215 kernel: o0: 000000000000000c o1: fff0001232e7fa80
o2: 0000000000000000 o3: 000000000000000c
Aug 01 00:35:42 v215 kernel: o4: fff0001232e7fa7c o5: 00000000000000fb
sp: fff0001232e7f1a1 ret_pc: 0000000000630ad4
Aug 01 00:35:42 v215 kernel: RPC: <do_sys_poll+0xd4/0x460>
Aug 01 00:35:42 v215 kernel: l0: 0000000000000002 l1: 00000000014000c0
l2: 00000000000003fe l3: 000fffedcd180590
Aug 01 00:35:43 v215 kernel: l4: fff0001232e7fa7c l5: 00000000f78346f4
l6: 0000000000000002 l7: 00000000f7968000
Aug 01 00:35:43 v215 kernel: i0: 00000000f77e1ff8 i1: 0000000000000002
i2: fff0001232e7fe90 i3: fff0001232e7fa70
Aug 01 00:35:43 v215 kernel: i4: 0000000000000002 i5: 00000000f77e1ff8
i6: fff0001232e7f5e1 i7: 00000000006315d8
Aug 01 00:35:43 v215 kernel: I7: <SyS_poll+0x78/0x100>
Aug 01 00:35:43 v215 kernel: Call Trace:
Aug 01 00:35:43 v215 kernel:  [00000000006315d8] SyS_poll+0x78/0x100
Aug 01 00:35:43 v215 kernel:  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
Aug 01 00:35:43 v215 kernel: Caller[00000000006315d8]: SyS_poll+0x78/0x100
Aug 01 00:35:43 v215 kernel: Caller[00000000004061b4]:
linux_sparc_syscall32+0x34/0x60
Aug 01 00:35:43 v215 kernel: Caller[0000000070000ba8]: 0x70000ba8
Aug 01 00:35:43 v215 kernel: Instruction DUMP:
Aug 01 00:35:43 v215 kernel:  c56a2000
Aug 01 00:35:43 v215 kernel:  808a2003
Aug 01 00:35:44 v215 kernel:  02480006
Aug 01 00:35:44 v215 kernel: <d42a2000>
Aug 01 00:35:44 v215 kernel:  90022001
Aug 01 00:35:44 v215 kernel:  808a2003
Aug 01 00:35:44 v215 kernel:  1247fffd
Aug 01 00:35:44 v215 kernel:  92226001
Aug 01 00:35:44 v215 kernel:  808a2007
Aug 01 00:35:44 v215 kernel:
Aug 01 00:35:55 v215 kernel: pc[12811]: segfault at 70000974 ip
0000000070000974 (rpc 000000007000096c) sp 00000000ffa69488 error
30001 in pc[70010000+2000]

...

======================================
Testsuite summary for strace 4.18.0.134.805d
======================================
# TOTAL: 443
# PASS:  387
# SKIP:  39
# XFAIL: 0
# FAIL:  17
# XPASS: 0
# ERROR: 0
======================================
See tests/test-suite.log
