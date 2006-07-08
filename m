From: Bob Breuer <breuerr@mc.net>
Date: Sat, 08 Jul 2006 19:29:07 +0000
Subject: Re: Sparc driver changes afoot for 2.6.18
Message-Id: <44B00783.3040701@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060624.001552.92583040.davem@davemloft.net>
In-Reply-To: <20060624.001552.92583040.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I just got around to testing these changes on sparc32 with 2.6.18-rc1,
and it dies early on.


BUG: warning at /usr/src/linux-2.6-git/lib/kref.c:32/kref_get()
[f01058c4 : get_bus+0x1c/0x40 ]
[f0105f7c : bus_add_driver+0xc/0x13c ]
[f0106fa8 : driver_register+0xb0/0xb8 ]
[f01e2358 : unpack_to_rootfs+0x434/0x958 ]
[f01dae2c : _etext+0x5b78c/0x5c958 ]
[f01da790 : _etext+0x5b0f0/0x5c958 ]
[00000000 : 0x8 ]
BUG: warning at /usr/src/linux-2.6-git/lib/kref.c:32/kref_get()
[f00cb870 : kobject_init+0x40/0x68 ]
[f00cbc28 : kobject_register+0x18/0x44 ]
[f0105fc4 : bus_add_driver+0x54/0x13c ]
[f0106fa8 : driver_register+0xb0/0xb8 ]
[f01e2358 : unpack_to_rootfs+0x434/0x958 ]
[f01dae2c : _etext+0x5b78c/0x5c958 ]
[f01da790 : _etext+0x5b0f0/0x5c958 ]
[00000000 : 0x8 ]
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
PSR: 1e001fc1 PC: f00cbb6c NPC: f00cbb70 Y: 00000000    Not tainted
PC: <kobject_add+0x138/0x1dc>
%G: 0000000a f01ad054  f01acaf4 00000000  f0030b90 f01ad400  f000e000
0000000
%O: f01ad05c 00000001  00000035 ffffffff  0000000a fffffff8  f000fd20
f00cbbd0
RPC: <kobject_add+0x19c/0x1dc>
%L: f01acad8 f01acaf0  f01ad05c f01b2400  f01acadc 00000000  00000003
00000000
%I: f01acad8 000000d0  f0185dba f000fe40  00000001 0000022e  f000fd88
f00cbc30
Caller[f00cbc30]: kobject_register+0x20/0x44
Caller[f0105fc4]: bus_add_driver+0x54/0x13c
Caller[f0106fa8]: driver_register+0xb0/0xb8
Caller[f01e2358]: unpack_to_rootfs+0x434/0x958
Caller[f01dae2c]: _etext+0x5b78c/0x5c958
Caller[f01da790]: _etext+0x5b0f0/0x5c958
Caller[00000000]: 0x8
Instruction DUMP: c6006004  c224201c  c4206004 <c420c000> 10bfffc6
c620a004  80a26000  b0102000  22bfffdd
Kernel panic - not syncing: Attempted to kill the idle task!
 <0>Press Stop-A (L1-A) to return to the boot prom


The last part from ksymoops:

>>PC;  f00cbb6c <kobject_add+130/1dc>   <==Trace; f00cbc30 <kobject_register+18/44>
Trace; f0105fc4 <bus_add_driver+4c/13c>
Trace; f0106fa8 <driver_register+a8/b8>
Trace; f01e2358 <sbus_time_init+38/1b4>
Trace; f01dae2c <start_kernel+154/2b8>
Trace; f01da790 <sun4c_continue_boot+314/324>
Trace; 00000000 Before first symbol
Code;  f00cbb60 <kobject_add+124/1dc>
00000000 <_PC>:
Code;  f00cbb60 <kobject_add+124/1dc>
   0:   c6 00 60 04       ld  [ %g1 + 4 ], %g3
Code;  f00cbb64 <kobject_add+128/1dc>
   4:   c2 24 20 1c       st  %g1, [ %l0 + 0x1c ]
Code;  f00cbb68 <kobject_add+12c/1dc>
   8:   c4 20 60 04       st  %g2, [ %g1 + 4 ]
Code;  f00cbb6c <kobject_add+130/1dc>   <==   c:   c4 20 c0 00       st  %g2, [ %g3 ]   <==Code;  f00cbb70 <kobject_add+134/1dc>
  10:   10 bf ff c6       b  ffffff28 <_PC+0xffffff28>
Code;  f00cbb74 <kobject_add+138/1dc>
  14:   c6 20 a0 04       st  %g3, [ %g2 + 4 ]
Code;  f00cbb78 <kobject_add+13c/1dc>
  18:   80 a2 60 00       cmp  %o1, 0
Code;  f00cbb7c <kobject_add+140/1dc>
  1c:   b0 10 20 00       clr  %i0
Code;  f00cbb80 <kobject_add+144/1dc>
  20:   22 bf ff dd       be,a   ffffff94 <_PC+0xffffff94>


I'll keep looking at it and try to figure out where the NULL pointer
came from.

Bob
