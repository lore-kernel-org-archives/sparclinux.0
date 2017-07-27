From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Thu, 27 Jul 2017 19:45:25 +0000
Subject: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <22906.17109.563338.559874@gargle.gargle.HOWL>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Attempting to build strace-4.18 as sparcv9 code and run its test suite
on a sparc64 machine (Sun Blade 2500 w/ 2 x USIIIi in my case) fails
reliably in three test cases (sched.gen, sched_xetattr.gen, and poll)
because two test binaries (sched_xetattr and poll) OOPS the kernel and
get killed.  Sample dmesg from 4.13-rc2:

[42912.270398] Unable to handle kernel NULL pointer dereference
[42912.327717] tsk->{mm,active_mm}->context = 000000000000136a
[42912.383789] tsk->{mm,active_mm}->pgd = fff0000227db4000
[42912.435247]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[42912.559982] sched_xetattr(21866): Oops [#1]
[42912.597773] CPU: 0 PID: 21866 Comm: sched_xetattr Not tainted 4.13.0-rc2 #1
[42912.672138] task: fff0000229a5c380 task.stack: fff0000227dec000
[42912.732876] TSTATE: 0000004411001603 TPC: 00000000007570fc TNPC: 0000000000757110 Y: 00000000    Not tainted
[42912.845079] TPC: <__bzero+0x20/0xc0>
[42912.874870] g0: 0000000000000000 g1: 0000000000000000 g2: 0000003000000000 g3: 00000000008ca100
[42912.972120] g4: fff0000229a5c380 g5: fff000023ef44000 g6: fff0000227dec000 g7: 0000000000000030
[42913.069446] o0: 0000000000000030 o1: fff0000227defe70 o2: 0000000000000000 o3: 0000000000000030
[42913.166765] o4: fff0000227defe70 o5: 0000000000000000 sp: fff0000227def5c1 ret_pc: 0000000000474fa4
[42913.268664] RPC: <SyS_sched_setattr+0xb0/0x150>
[42913.311046] l0: 00000000f7b6caa8 l1: 00000000cccccccd l2: 00000000ffc2e7d4 l3: 00000000f7b6c888
[42913.408293] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 00000000f7ba2000
[42913.505627] i0: 0000000000000000 i1: 00000000f79f1ffc i2: 0000000000000000 i3: 0000000000000000
[42913.602940] i4: fff0000227defe70 i5: fff0000227defe70 i6: fff0000227def6a1 i7: 00000000004061b4
[42913.700268] I7: <linux_sparc_syscall32+0x34/0x60>
[42913.744966] Call Trace:
[42913.759938]  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
[42913.820656] Disabling lock debugging due to kernel taint
[42913.873374] Caller[00000000004061b4]: linux_sparc_syscall32+0x34/0x60
[42913.940953] Caller[0000000000010ed0]: 0x10ed0
[42913.981081] Instruction DUMP:
[42913.981085]  c56a2000 
[42914.002817]  808a2003 
[42914.016643]  02480006 
[42914.030363] <d42a2000>
[42914.044094]  90022001 
[42914.057816]  808a2003 
[42914.071539]  1247fffd 
[42914.085269]  92226001 
[42914.098992]  808a2007 

[42914.471525] Unable to handle kernel NULL pointer dereference
[42914.528830] tsk->{mm,active_mm}->context = 00000000000017cd
[42914.584862] tsk->{mm,active_mm}->pgd = fff0000227b78000
[42914.636319]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[42914.761013] sched_xetattr(22483): Oops [#2]
[42914.798837] CPU: 0 PID: 22483 Comm: sched_xetattr Tainted: G      D         4.13.0-rc2 #1
[42914.889222] task: fff000123c73bc00 task.stack: fff0001238998000
[42914.949915] TSTATE: 0000004411001603 TPC: 00000000007570fc TNPC: 0000000000757110 Y: 00000000    Tainted: G      D        
[42915.078076] TPC: <__bzero+0x20/0xc0>
[42915.107875] g0: 0000000000000000 g1: 0000000000000000 g2: 0000003000000000 g3: 00000000008ca100
[42915.205205] g4: fff000123c73bc00 g5: fff000023ef44000 g6: fff0001238998000 g7: 0000000000000030
[42915.302532] o0: 0000000000000030 o1: fff000123899be70 o2: 0000000000000000 o3: 0000000000000030
[42915.399851] o4: fff000123899be70 o5: 0000000000000000 sp: fff000123899b5c1 ret_pc: 0000000000474fa4
[42915.501731] RPC: <SyS_sched_setattr+0xb0/0x150>
[42915.544033] l0: 00000000f784caa8 l1: 00000000cccccccd l2: 00000000ff91c7d4 l3: 00000000f784c888
[42915.641289] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 00000000f7882000
[42915.738582] i0: 0000000000000000 i1: 00000000f76d1ffc i2: 0000000000000000 i3: 0000000000000000
[42915.835827] i4: fff000123899be70 i5: fff000123899be70 i6: fff000123899b6a1 i7: 00000000004061b4
[42915.933160] I7: <linux_sparc_syscall32+0x34/0x60>
[42915.977822] Call Trace:
[42915.992698]  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
[42916.053335] Caller[00000000004061b4]: linux_sparc_syscall32+0x34/0x60
[42916.120934] Caller[0000000000010ed0]: 0x10ed0
[42916.161052] Instruction DUMP:
[42916.161056]  c56a2000 
[42916.182878]  808a2003 
[42916.196607]  02480006 
[42916.210330] <d42a2000>
[42916.224052]  90022001 
[42916.237781]  808a2003 
[42916.251502]  1247fffd 
[42916.265224]  92226001 
[42916.278955]  808a2007 

[42918.071476] ------------[ cut here ]------------
[42918.115146] WARNING: CPU: 0 PID: 23177 at arch/sparc/kernel/sys_sparc32.c:150 compat_SyS_sparc_sigaction+0x34/0x4c
[42918.234167] Modules linked in: af_packet ipv6 hid_generic tg3 hwmon i2c_ali1535 ohci_pci ptp ohci_hcd evdev i2c_core pps_core flash sr_mod cdrom pata_ali libata
[42918.405845] CPU: 0 PID: 23177 Comm: sigaction Tainted: G      D         4.13.0-rc2 #1
[42918.491645] Call Trace:
[42918.506518]  [0000000000455b18] __warn+0xb4/0xc4
[42918.549976]  [00000000004449e4] compat_SyS_sparc_sigaction+0x34/0x4c
[42918.616319]  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
[42918.677014] ---[ end trace 4800f70b0fef934e ]---
[42947.617187] Unable to handle kernel NULL pointer dereference
[42947.674440] tsk->{mm,active_mm}->context = 00000000000018d3
[42947.730560] tsk->{mm,active_mm}->pgd = fff0000202a04000
[42947.782020]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[42947.906726] poll(31644): Oops [#3]
[42947.934244] CPU: 0 PID: 31644 Comm: poll Tainted: G      D W       4.13.0-rc2 #1
[42948.014399] task: fff000023c68cb00 task.stack: fff0000227adc000
[42948.075064] TSTATE: 0000004411001601 TPC: 00000000007570fc TNPC: 0000000000757110 Y: 00000000    Tainted: G      D W      
[42948.203275] TPC: <__bzero+0x20/0xc0>
[42948.233069] g0: fff000123c5a8828 g1: 0000000000000000 g2: 0000000000000000 g3: 00000000008ca100
[42948.330322] g4: fff000023c68cb00 g5: fff000023ef44000 g6: fff0000227adc000 g7: 0000000000000008
[42948.427651] o0: 000000000000000c o1: fff0000227adfa80 o2: 0000000000000000 o3: 000000000000000c
[42948.524959] o4: fff0000227adfa7c o5: 00000000000000fb sp: fff0000227adf181 ret_pc: 0000000000516ee0
[42948.626876] RPC: <do_sys_poll+0x80/0x3c0>
[42948.662408] l0: 0000000000000002 l1: 00000000014000c0 l2: 00000000000003fe l3: fff0000227adfa7c
[42948.759738] l4: 0000000000000000 l5: 0000000000000000 l6: 000000000000006d l7: ffffffffffffffea
[42948.857064] i0: 00000000f7dbdff8 i1: 0000000000000002 i2: fff0000227adfe90 i3: fff0000227adfa70
[42948.954389] i4: 000ffffdd8520590 i5: fff0000227adfa70 i6: fff0000227adf5e1 i7: 00000000005177f8
[42949.051703] I7: <SyS_poll+0x74/0xd0>
[42949.081507] Call Trace:
[42949.096407]  [00000000005177f8] SyS_poll+0x74/0xd0
[42949.142242]  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
[42949.202876] Caller[00000000005177f8]: SyS_poll+0x74/0xd0
[42949.255596] Caller[00000000004061b4]: linux_sparc_syscall32+0x34/0x60
[42949.323177] Caller[0000000000010a20]: 0x10a20
[42949.363284] Instruction DUMP:
[42949.363288]  c56a2000 
[42949.385037]  808a2003 
[42949.398841]  02480006 
[42949.412564] <d42a2000>
[42949.426287]  90022001 
[42949.440034]  808a2003 
[42949.453739]  1247fffd 
[42949.467465]  92226001 
[42949.481188]  808a2007 

[42965.393520] pc[534]: segfault at 1085c ip 000000000001085c (rpc 0000000000010854) sp 00000000ffba8da8 error 30001 in pc[20000+2000]

This occurs reliably with the 4.13-rc2, 4.13-rc1, and 4.12.0 kernels.
With 4.11.0 and older kernels the binaries get some EFAULTs but they
survive that, and there are also no OOPSes.

/Mikael
