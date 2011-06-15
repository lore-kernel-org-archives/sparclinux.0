From: Daniel Smolik <marvin@mydatex.cz>
Date: Wed, 15 Jun 2011 23:10:07 +0000
Subject: 2.6.39.1 on E450
Message-Id: <4DF93BCF.9010805@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have compile this kernel with the same config as 2.6.36 which work.

udev[292]: starting version 164
/pci@1f,4000/ebus@1/flashprom@10,0: OBP Flash, RD 1fff0000000[100000] WR 1fff0000000[100000]
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 000000000000025a
tsk->{mm,active_mm}->pgd = fffff8003e1ea000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
cdrom_id(397): Oops [#1]
TSTATE: 0000004411001605 TPC: 000000000053a138 TNPC: 000000000053a13c Y: 00000000    Not tainted
TPC: <blkdev_get+0x2ac/0x328>
g0: 0000000000000000 g1: 000000000097e300 g2: fffff80000004cf0 g3: 0000000000000009
g4: fffff8000414d080 g5: fffff800009ec000 g6: fffff8003dd40000 g7: 00000000009c8560
o0: fffff80000004ce8 o1: fffff8003e826748 o2: 0000000000000000 o3: 0000000000552470
o4: 0000000000000003 o5: fffff80001406b70 sp: fffff8003dd43161 ret_pc: 000000000053a124
RPC: <blkdev_get+0x298/0x328>
l0: fffff8003e826700 l1: ffffffffffffff83 l2: fffff8003e826718 l3: 0000000000000000
l4: fffff8003eb512c8 l5: 0000000000480f14 l6: 000000000053889c l7: fffff8003e826748
i0: fffff8003e826700 i1: 000000000000009d i2: fffff8003ce01680 i3: fffff8003f010120
i4: 0000000000000000 i5: fffff8003f010120 i6: fffff8003dd43241 i7: 000000000050cbcc
I7: <__dentry_open+0x1bc/0x300>
Call Trace:
  [000000000050cbcc] __dentry_open+0x1bc/0x300
  [000000000051990c] do_last+0x79c/0x8e4
  [000000000051a718] path_openat+0x90/0x360
  [000000000051aab0] do_filp_open+0x20/0x78
  [000000000050c920] do_sys_open+0x110/0x1b4
  [0000000000406114] linux_sparc_syscall32+0x34/0x40
Disabling lock debugging due to kernel taint
Caller[000000000050cbcc]: __dentry_open+0x1bc/0x300
Caller[000000000051990c]: do_last+0x79c/0x8e4
Caller[000000000051a718]: path_openat+0x90/0x360
Caller[000000000051aab0]: do_filp_open+0x20/0x78
Caller[000000000050c920]: do_sys_open+0x110/0x1b4
Caller[0000000000406114]: linux_sparc_syscall32+0x34/0x40
Caller[00000000f7744ba8]: 0xf7744ba8
Instruction DUMP: 030025f8  82106300  c0284000 <c404e220> 80a00011  82603fff  8530a008  80888001  0248000b


How can I help ?

Regards
	Dan






-- 
Mydatex s r.o.
http://www.mydatex.cz
email: smolik@mydatex.cz
mob: 604200362
tel: 226210085
