From: lists@naasa.net
Date: Sun, 25 Apr 2004 19:26:45 +0000
Subject: swapon(131): Kernel bad trap
Message-Id: <200404252126.45047.lists@naasa.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi!

New Kernel, new problems...

              \|/ ____ \|/
              "@'/ ,. \@"
              /_| \__/ |_\
                 \__U_/
swapon(131): Kernel bad trap [#2]
PSR: 040000c7 PC: f0061df4 NPC: f0061df8 Y: 00000000    Not tainted
PC: <sys_swapon+0x8c/0x79c>
%G: 00001000 00000040  fffffeff f073edb8  00022200 00000000  f5ca2000
50015638
%O: ffffffff 00021c68  50105ab0 00000004  50019778 00000314  f5ca3ee0
5000c858
RPC: <0x5000c858>
%L: 00000000 f01fafc0  f01fac00 00000000  00000000 00000000  00000000
00000000
%I: ffffffff 00000000  efffecc8 80808080  00000000 f01fac00  f5ca3f50
f00129c0
Caller[f00129c0]: syscall_is_too_hard+0x34/0x40
Caller[00010d3c]: 0x10d3c
Instruction DUMP: 82102040  8088607c  b0103fff <93d02005> 80a4201f  1880005c
c204a3bc  80a40001  0a800005

I'musing a patched 2.6.5 (srmmu patch) kernel. The swap partition works=20
without any problems with a 2.6.4er kernel...

regards,
J=F6rg
