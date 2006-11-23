From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 23 Nov 2006 13:35:11 +0000
Subject: Sparc32 SMP
Message-Id: <4565A38F.10101@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607130208320.4657-300000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607130208320.4657-300000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

	Hello Bob,

	I'm testing some configurations with 2.6.18.2 linux kernel. This kernel=20
boots wihtout any trouble and I believe that all troubles we have seen=20
are fixed.

	With SuperSparc-II, kernel seems to be stable, but I'm not able to=20
untar a linux kernel without receive "t=E2che interrompue" (unterrupted=20
task) or an Oops :

Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 00005058
tsk->{mm,active_mm}->pgd =3D fc12d000
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
tar(13387): Oops [#1]
PSR: 400000c2 PC: f008bd8c NPC: f008bd90 Y: 00000000    Not tainted
PC: <pipe_readv+0xac/0x440>
%G: 00001000 fbbfea14  0000003c 00000030  fbbfea00 73635f6c  f93be000=20
00000000
%O: f0a0d900 f0a0d900  fcffb000 63616368  6536345f 70616765  f93bfd88=20
f008c030
RPC: <pipe_readv+0x350/0x440>
%L: 00000000 00000000  fbbfea50 fbbfea00  00000000 fcffc000  00000001=20
00000001
%I: f93bfe60 00000003  f93bfe60 00001800  fcffb000 00000000  f93bfe00=20
f008c140
Caller[f008c140]: pipe_read+0x20/0x28
Caller[f007dee8]: vfs_read+0xa0/0x16c
Caller[f007eb38]: sys_read+0x38/0x64
Caller[f0015a3c]: syscall_is_too_hard+0x3c/0x40
Caller[0003df90]: 0x3df98
Instruction DUMP: 1a800003  fa04a00c  a810001b <c207600c> 90100013=20
9fc04000  92
100012  80a22000  128000b9
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 0000506a
tsk->{mm,active_mm}->pgd =3D fc13c800
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
tar(13402): Oops [#2]
PSR: 400000c6 PC: f008bd8c NPC: f008bd90 Y: 00000000    Not tainted
PC: <pipe_readv+0xac/0x440>
%G: 00002800 fb478e14  00000104 000000d0  fb478e00 09307866  f882c000=20
00000000
%O: f0a4bf00 f0a4bf00  fcfe1000 30306632  30312c30 78613830  f882dd88=20
f008c030
RPC: <pipe_readv+0x350/0x440>
%L: 00000000 00000000  fb478f18 fb478e00  00000000 fcfe2000  00000001=20
00000001
%I: f882de60 0000000d  f882de60 00002000  fcfe1000 00000000  f882de00=20
f008c140
Caller[f008c140]: pipe_read+0x20/0x28
Caller[f007dee8]: vfs_read+0xa0/0x16c
Caller[f007eb38]: sys_read+0x38/0x64
Caller[f0015a3c]: syscall_is_too_hard+0x3c/0x40
Caller[0003df90]: 0x3df98
Instruction DUMP: 1a800003  fa04a00c  a810001b <c207600c> 90100013=20
9fc04000  92
100012  80a22000  128000b9

	I think that the trouble I have seen with HyperSPARC comes from the=20
same mistake. Any idea ?

	Regards,

	JKB
