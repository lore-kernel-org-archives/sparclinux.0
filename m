From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 05 Apr 2004 15:34:14 +0000
Subject: Oops when booting 2.6.5
Message-Id: <20040405153414.GC1430@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

I compiled the kernel with Debian's GCC-3.3 package. When booting the
2.6.5-rc kernels there was no oops. The oops occur when the initscripts
are trying to active swap with 'swapon -a'.

Art Haas

ksymoops 2.4.9 on sparc 2.6.5.  Options used
     -v /opt/build/linus-2.5/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5/ (default)
     -m /boot/System.map-2.6.5 (default)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr  5 09:38:22 sundebian kernel:               \|/ ____ \|/
Apr  5 09:38:22 sundebian kernel:               "@'/ ,. \`@"
Apr  5 09:38:22 sundebian kernel:               /_| \__/ |_\
Apr  5 09:38:22 sundebian kernel:                  \__U_/
Apr  5 09:38:22 sundebian kernel: swapon(40): Kernel bad trap [#1]
Apr  5 09:38:22 sundebian kernel: PSR: 400000c5 PC: f00656f8 NPC: f00656fc Y: 00000000    Not tainted
Apr  5 09:38:22 sundebian kernel: PC: <sys_swapon+0x88/0x758>
Apr  5 09:38:22 sundebian kernel: Caller[f0012a00]: syscall_is_too_hard+0x34/0x40
Apr  5 09:38:22 sundebian kernel: Caller[00010d3c]: 0x10d3c
Apr  5 09:38:22 sundebian kernel: Instruction DUMP: a2046048  82102040  8088607c <93d02005> 80a4201f  1880005b  b0103fff  c204a3fc  80a40001 


>>PC;  f00656f8 <sys_swapon+88/758>   <==
Trace; f0012a00 <syscall_is_too_hard+34/40>
Trace; 00010d3c Before first symbol

Code;  f00656ec <sys_swapon+7c/758>
00000000 <_PC>:
Code;  f00656ec <sys_swapon+7c/758>
   0:   a2 04 60 48       add  %l1, 0x48, %l1
Code;  f00656f0 <sys_swapon+80/758>
   4:   82 10 20 40       mov  0x40, %g1
Code;  f00656f4 <sys_swapon+84/758>
   8:   80 88 60 7c       btst  0x7c, %g1
Code;  f00656f8 <sys_swapon+88/758>   <==   c:   93 d0 20 05       tne  5   <==Code;  f00656fc <sys_swapon+8c/758>
  10:   80 a4 20 1f       cmp  %l0, 0x1f
Code;  f0065700 <sys_swapon+90/758>
  14:   18 80 00 5b       bgu  180 <_PC+0x180>
Code;  f0065704 <sys_swapon+94/758>
  18:   b0 10 3f ff       mov  -1, %i0
Code;  f0065708 <sys_swapon+98/758>
  1c:   c2 04 a3 fc       ld  [ %l2 + 0x3fc ], %g1
Code;  f006570c <sys_swapon+9c/758>
  20:   80 a4 00 01       cmp  %l0, %g1

Apr  5 09:38:22 sundebian kernel:               \|/ ____ \|/
Apr  5 09:38:22 sundebian kernel:               "@'/ ,. \`@"
Apr  5 09:38:22 sundebian kernel:               /_| \__/ |_\
Apr  5 09:38:22 sundebian kernel:                  \__U_/
Apr  5 09:38:22 sundebian kernel: swapon(111): Kernel bad trap [#2]
Apr  5 09:38:22 sundebian kernel: PSR: 400000c7 PC: f00656f8 NPC: f00656fc Y: 00000000    Not tainted
Apr  5 09:38:22 sundebian kernel: PC: <sys_swapon+0x88/0x758>
Apr  5 09:38:22 sundebian kernel: Caller[f0012a00]: syscall_is_too_hard+0x34/0x40
Apr  5 09:38:22 sundebian kernel: Caller[00010d3c]: 0x10d3c
Apr  5 09:38:22 sundebian kernel: Instruction DUMP: a2046048  82102040  8088607c <93d02005> 80a4201f  1880005b  b0103fff  c204a3fc  80a40001 


>>PC;  f00656f8 <sys_swapon+88/758>   <==
Trace; f0012a00 <syscall_is_too_hard+34/40>
Trace; 00010d3c Before first symbol

Code;  f00656ec <sys_swapon+7c/758>
00000000 <_PC>:
Code;  f00656ec <sys_swapon+7c/758>
   0:   a2 04 60 48       add  %l1, 0x48, %l1
Code;  f00656f0 <sys_swapon+80/758>
   4:   82 10 20 40       mov  0x40, %g1
Code;  f00656f4 <sys_swapon+84/758>
   8:   80 88 60 7c       btst  0x7c, %g1
Code;  f00656f8 <sys_swapon+88/758>   <==   c:   93 d0 20 05       tne  5   <==Code;  f00656fc <sys_swapon+8c/758>
  10:   80 a4 20 1f       cmp  %l0, 0x1f
Code;  f0065700 <sys_swapon+90/758>
  14:   18 80 00 5b       bgu  180 <_PC+0x180>
Code;  f0065704 <sys_swapon+94/758>
  18:   b0 10 3f ff       mov  -1, %i0
Code;  f0065708 <sys_swapon+98/758>
  1c:   c2 04 a3 fc       ld  [ %l2 + 0x3fc ], %g1
Code;  f006570c <sys_swapon+9c/758>
  20:   80 a4 00 01       cmp  %l0, %g1


1 error issued.  Results may not be reliable.
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
