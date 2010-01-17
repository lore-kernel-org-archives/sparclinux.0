From: Patrick Finnegan <pat@computer-refuge.org>
Date: Sun, 17 Jan 2010 03:08:40 +0000
Subject: Re: BBC I2C doesn't work on V880
Message-Id: <201001162208.40413.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200912021105.03604.pat@computer-refuge.org>
In-Reply-To: <200912021105.03604.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 04 January 2010, David Miller wrote:
> From: Patrick Finnegan <pat@computer-refuge.org>
> Date: Wed, 2 Dec 2009 11:05:03 -0500
> 
> > Going through the remaining problems I'm having with my V880, it
> > looks like the SPARC bbc i2c driver won't load.  This is with
> > Linus's git tree from a few days ago.  When I do a "modprobe bbc",
> > I get this:
> >
> > [ 3735.308284] i2c-0: Regs at 000007fc7e00002e, 2 devices, own a0,
> > clock 10. [ 3735.388677] bbc_i2c: probe of f00bd100 failed with
> > error -22 [ 3735.456691] i2c-0: Regs at 000007fc7e50002e, 8
> > devices, own a0, clock 10. [ 3735.537696] bbc_i2c: probe of
> > f00cd000 failed with error -22
> >
> > And, when I try to rmmod bbc, I get a kernel NULL pointer bug:
> >
> > [ 3878.082842] Unable to handle kernel NULL pointer dereference
> 
> Ok, the following patch should fix the crash.
> 
> But I can't see why kthread_run() should fail and that's the
> only patch I can see which can return -EINVAL during the
> probe.
> 
> Can you do me a favor after you make sure rmmod no longer causes
> a crash?

Ok, I tried this, and it doesn't seem to help.

I still get a kernel BUG, this is the new traceback:

[ 1207.699972] Unable to handle kernel NULL pointer dereference
[ 1207.766801] tsk->{mm,active_mm}->context = 0000000000000dad         
[ 1207.833455] tsk->{mm,active_mm}->pgd = fffff8d0ddc4c000             
[ 1207.895951]               \|/ ____ \|/                              
[ 1207.895956]               "@'/ .. \`@"                              
[ 1207.895960]               /_| \__/ |_\                              
[ 1207.895965]                  \__U_/                                 
[ 1208.072016] rmmod(8911): Oops [#1]                                  
[ 1208.112628] TSTATE: 0000000011001602 TPC: 00000000101e65dc TNPC: 
00000000101e6624 Y: 00000000    Not tainted                                                 
[ 1208.230347] TPC: <destroy_all_temps+0x1c/0x78 [bbc]>                         
[ 1208.289715] g0: fffff8d0f823c000 g1: 0000000000400400 g2: 
000000000088b000 g3: 000000000000002d                                                              
[ 1208.393892] g4: fffff8d0faa5b360 g5: fffff8a007b34000 g6: 
fffff8d0f823c000 g7: 000000000000002f                                                              
[ 1208.498050] o0: 0000000000000001 o1: 0000000000000007 o2: 
0000000000001b2d o3: 0000000000000080                                                              
[ 1208.602231] o4: fffff8d0fe0571a8 o5: fffff8d0f9d833c8 sp: 
fffff8d0f823f041 ret_pc: 000000000050f4dc                                                          
[ 1208.710583] RPC: <__iget+0x18/0x80>                                          
[ 1208.752225] l0: 0000000000000000 l1: fffff8d0fe058000 l2: 
0000000000100100 l3: 0000000000200200                                                              
[ 1208.856394] l4: 0000000000000000 l5: 0000000000000000 l6: 
fffff8a008400010 l7: 0000000000000000                                                              
[ 1208.960564] i0: fffff8d0fb1c4b08 i1: fffff8d0fe4f5240 i2: 
0000000000000001 i3: fffff8d0fe4f5240
[ 1209.064743] i4: fffff8d0fe4b2ea8 i5: 000000081d56b2ee i6: 
fffff8d0f823f101 i7: 00000000101e66cc
[ 1209.168906] I7: <bbc_envctrl_cleanup+0x1c/0x30 [bbc]>
[ 1209.229321] Disabling lock debugging due to kernel taint
[ 1209.292868] Caller[00000000101e66cc]: bbc_envctrl_cleanup+0x1c/0x30 
[bbc]
[ 1209.374133] Caller[00000000101e7360]: bbc_i2c_remove+0xc/0x5c [bbc]
[ 1209.449127] Caller[0000000000693c8c]: 
of_platform_device_remove+0x1c/0x2c
[ 1209.530386] Caller[0000000000607418]: 
__device_release_driver+0x6c/0xac
[ 1209.609545] Caller[00000000006074d8]: driver_detach+0x80/0xb4
[ 1209.678304] Caller[0000000000606650]: bus_remove_driver+0x98/0xd0
[ 1209.751215] Caller[0000000000490458]: SyS_delete_module+0x1c0/0x234
[ 1209.826220] Caller[0000000000406214]: linux_sparc_syscall32+0x34/0x40
[ 1209.903298] Caller[000000000001154c]: 0x1154c
[ 1209.955386] Instruction DUMP: a7307001  a5307002  10680013 <e25c0000> 
c25c0000  c4706008  c2708000  c45c2018  c25c2010

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
