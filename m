From: Patrick Finnegan <pat@computer-refuge.org>
Date: Wed, 02 Dec 2009 16:05:03 +0000
Subject: BBC I2C doesn't work on V880
Message-Id: <200912021105.03604.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Going through the remaining problems I'm having with my V880, it looks 
like the SPARC bbc i2c driver won't load.  This is with Linus's git 
tree from a few days ago.  When I do a "modprobe bbc", I get this:

[ 3735.308284] i2c-0: Regs at 000007fc7e00002e, 2 devices, own a0, clock 10.
[ 3735.388677] bbc_i2c: probe of f00bd100 failed with error -22
[ 3735.456691] i2c-0: Regs at 000007fc7e50002e, 8 devices, own a0, clock 10.
[ 3735.537696] bbc_i2c: probe of f00cd000 failed with error -22

And, when I try to rmmod bbc, I get a kernel NULL pointer bug:

[ 3878.082842] Unable to handle kernel NULL pointer dereference                 
[ 3878.149656] tsk->{mm,active_mm}->context = 00000000000008f9
[ 3878.216303] tsk->{mm,active_mm}->pgd = fffff8d0fd78e000
[ 3878.278804]               \|/ ____ \|/
[ 3878.278808]               "@'/ .. \`@"
[ 3878.278813]               /_| \__/ |_\
[ 3878.278817]                  \__U_/
[ 3878.454861] rmmod(2401): Oops [#1]
[ 3878.495484] TSTATE: 0000000011001601 TPC: 00000000101f45f4 TNPC: 00000000101f463c Y: 00000000    
Not tainted
[ 3878.613208] TPC: <bbc_envctrl_cleanup+0x34/0xfc [bbc]>
[ 3878.674650] g0: fffff8c004701b20 g1: 0000000000400400 g2: 000000000088b000 g3: 
000000000000000b
[ 3878.778825] g4: fffff8d0fb25e6c0 g5: fffff8c003b34000 g6: fffff8d0fb6e4000 g7: 
000000000000002c
[ 3878.882985] o0: 0000000000000000 o1: fffff8d0fe2c5260 o2: 0000000000000001 o3: 
fffff8d0fe2c5260
[ 3878.987153] o4: 0000000000000000 o5: 0000000000000000 sp: fffff8d0fb6e7101 ret_pc: 
0000000000550410
[ 3879.095513] RPC: <release_sysfs_dirent+0xc8/0xe4>
[ 3879.151849] l0: 0000000000000000 l1: fffff8d0fe2c5260 l2: fffff8c0ffb91208 l3: 
0000000000100100
[ 3879.255911] l4: 0000000000200200 l5: 0000000000000000 l6: fffff8c004701b20 l7: 
0000000000000000
[ 3879.360087] i0: fffff8c0ffb911c0 i1: fffff8d0fab5edb0 i2: 0000000000000001 i3: 
fffff8d0fe2c5260
[ 3879.464249] i4: 0000000000000001 i5: fffff8d0fbe5cae8 i6: fffff8d0fb6e71c1 i7: 
00000000101f5328
[ 3879.568419] I7: <bbc_i2c_remove+0xc/0x5c [bbc]>
[ 3879.622590] Disabling lock debugging due to kernel taint
[ 3879.686132] Caller[00000000101f5328]: bbc_i2c_remove+0xc/0x5c [bbc]
[ 3879.761137] Caller[00000000006939dc]: of_platform_device_remove+0x1c/0x2c
[ 3879.842394] Caller[0000000000607200]: __device_release_driver+0x6c/0xac
[ 3879.921562] Caller[00000000006072c0]: driver_detach+0x80/0xb4
[ 3879.990303] Caller[0000000000606438]: bus_remove_driver+0x98/0xd0
[ 3880.063228] Caller[0000000000490368]: SyS_delete_module+0x1c0/0x234
[ 3880.138230] Caller[0000000000406214]: linux_sparc_syscall32+0x34/0x40
[ 3880.215314] Caller[000000000001154c]: 0x1154c
[ 3880.267386] Instruction DUMP: a9307001  a7307002  10680013 <e25c0000> c25c0000  c2708000  
c4706008  c45c2018  c25c2010


I still have the prtconf output available up at:

http://ned.cc.purdue.edu/prtconf-v880

Any suggestions?

Thanks,

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
