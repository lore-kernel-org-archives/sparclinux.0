From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 24 Oct 2009 15:18:03 +0000
Subject: Re: temperature & fan-control modprobe Oops
Message-Id: <1256397483.5117.28.camel@deblnxsrv254.opensoftwarenetwork.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2009-10-24 at 17:06 +0200, Frans van Berckel wrote:

Hmmm unloading bbc looks even better!

Thanks,

Frans van Berckel

Oct 24 17:09:15  [ 3028.673489] Unable to handle kernel NULL pointer
dereference
Oct 24 17:09:15  [ 3028.676334] tsk->{mm,active_mm}->context 0000000000000cc3
Oct 24 17:09:15  [ 3028.679201] tsk->{mm,active_mm}->pgd fffff8007c1c0000
Oct 24 17:09:15  [ 3028.681982]               \|/ ____ \|/
Oct 24 17:09:15  [ 3028.681986]               "@'/ .. \`@"
Oct 24 17:09:15  [ 3028.681990]               /_| \__/ |_\
Oct 24 17:09:15  [ 3028.681993]                  \__U_/
Oct 24 17:09:15  [ 3028.692891] modprobe(2361): Oops [#1]
Oct 24 17:09:15  [ 3028.695567] TSTATE: 0000004411009605 TPC:
00000000005bc144 TNPC: 00000000005bc148 Y: 00000001    Not tainted
Oct 24 17:09:15  [ 3028.698262] TPC: <atomic_add+0x4/0x48>
Oct 24 17:09:15  [ 3028.700897] g0: 00000000001200d2 g1:
0000000000000001 g2: 0000000000000002 g3: 0000000000000002
Oct 24 17:09:15  [ 3028.703671] g4: fffff8007b033840 g5:
fffff8007defc000 g6: fffff8007b9e4000 g7: 0000000000000000
Oct 24 17:09:15  [ 3028.706442] o0: 0000000000000001 o1:
0000000000000010 o2: 0000000000000001 o3: 00000000005462f4
Oct 24 17:09:15  [ 3028.709187] o4: 0000000000000080 o5:
0000000000000019 sp: fffff8007b9e7041 ret_pc: 000000000047e5bc
Oct 24 17:09:15  [ 3028.712008] RPC: <kthread_stop+0x1c/0xa0>
Oct 24 17:09:15  [ 3028.714739] l0: 0000000000000010 l1:
000000000094a000 l2: 000000000087a400 l3: fffff8007e8004e0
Oct 24 17:09:15  [ 3028.717547] l4: 000002b3226d7400 l5:
0000000000000000 l6: 000002b3226d7400 l7: 000002b322306ef2
Oct 24 17:09:15  [ 3028.720341] i0: 0000000000000000 i1:
0000000000980a38 i2: 0000000000000001 i3: fffff8007d8d0280
Oct 24 17:09:15  [ 3028.723162] i4: 0000000000000000 i5:
7fffffffffffffff i6: fffff8007b9e7101 i7: 00000000102ea68c
Oct 24 17:09:15  [ 3028.725939] I7: <bbc_envctrl_cleanup+0xc/0x120
[bbc]>
Oct 24 17:09:15  [ 3028.728651] Caller[00000000102ea68c]:
bbc_envctrl_cleanup+0xc/0x120 [bbc]
Oct 24 17:09:15  [ 3028.731467] Caller[00000000102eb580]: bbc_i2c_remove
+0x8/0x58 [bbc]
Oct 24 17:09:15  [ 3028.734235] Caller[000000000069b6fc]:
of_platform_device_remove+0x1c/0x40
Oct 24 17:09:15  [ 3028.736960] Caller[0000000000638910]:
__device_release_driver+0x70/0xc0
Oct 24 17:09:15  [ 3028.739751] Caller[0000000000638a14]: driver_detach
+0xb4/0xe0
Oct 24 17:09:15  [ 3028.742516] Caller[0000000000637bc8]:
bus_remove_driver+0x88/0xc0
Oct 24 17:09:15  [ 3028.745234] Caller[00000000004921bc]:
SyS_delete_module+0x19c/0x280
Oct 24 17:09:15  [ 3028.748015] Caller[0000000000406214]:
linux_sparc_syscall32+0x34/0x40
Oct 24 17:09:15  [ 3028.750756] Caller[0000000000013258]: 0x13258
Oct 24 17:09:15  [ 3028.753485] Instruction DUMP: 01000000  01000000
94102001 <c2024000> 8e004008  cfe25001  80a04007  12400004  01000000 


