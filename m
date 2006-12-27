From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Wed, 27 Dec 2006 13:19:19 +0000
Subject: Re: nfs and sparc64
Message-Id: <459272D7.6040102@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <458878BC.3040106@systella.fr>
In-Reply-To: <458878BC.3040106@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Wed, 20 Dec 2006 00:41:48 +0100
>=20
>> 	U60 runs debian/etch, nfs-kernel-server, and client I use for tests is =

>> a i386 (K6-3/400) that runs debian/etch too. I have tested different=20
>> memory configuration and the oops always occurs at the same instruction.
>>
>> 	Any idea ?
>=20
> Any chance you can test a gcc-4.0.x compiled kernel?
> This might be a miscompile.

	Some news... I have rebuilt a 2.6.19.1 kernel with gcc-3.4 (version gcc=20
3.4.6 (Debian 3.4.6-4)). I obtain a similar Oops :

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ip_tables: (C) 2000-2006 Netfilter Core Team
Kernel unaligned access at TPC[60c0c4] sock_setsockopt+0x2c/0x740
Kernel unaligned access at TPC[60c0c4] sock_setsockopt+0x2c/0x740
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 0000000000001194
tsk->{mm,active_mm}->pgd =3D fffff8008db44000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
nfsd(3547): Oops [#1]
TSTATE: 0000004480009602 TPC: 000000000048a984 TNPC: 000000000048a988 Y:=20
00000000    Not tainted
TPC: <put_page+0xc/0x100>
g0: fffff800adffcae0 g1: 0000000000000003 g2: 0000000000020000 g3:=20
0000000000000000
g4: fffff800afbc0d40 g5: fffff8001ffa9bc0 g6: fffff800a2df4000 g7:=20
0000000000000003
o0: 0000000000000006 o1: fffff80020083620 o2: 0000000000000040 o3:=20
0008000002000000
o4: fffff800200597a8 o5: fffff800200597d0 sp: fffff800a2df6e51 ret_pc:=20
000000000048ac5c
RPC: <activate_page+0x84/0xe0>
l0: 0000000000705b00 l1: 0000000000705e60 l2: fffff80020083648 l3:=20
0000000000000000
l4: 00000000007c1800 l5: fffff8002b36c000 l6: 0000000000705c40 l7:=20
0000000000705c50
i0: 0000000000000000 i1: fffff80020083628 i2: fffff800a2df78a0 i3:=20
0000000000000000
i4: 0000000000000007 i5: fffff8008335cb08 i6: fffff800a2df6f11 i7:=20
00000000101ce430
I7: <nfsd_read_actor+0xb8/0x100 [nfsd]>
Caller[00000000101ce430]: nfsd_read_actor+0xb8/0x100 [nfsd]
Caller[0000000000483438]: do_generic_mapping_read+0x360/0x500
Caller[0000000000483894]: generic_file_sendfile+0x3c/0x60
Caller[00000000101ce8c4]: nfsd_vfs_read+0x44c/0x480 [nfsd]
Caller[00000000101cff34]: nfsd_read+0x9c/0xc0 [nfsd]
Caller[00000000101d6eb4]: nfsd3_proc_read+0x9c/0x120 [nfsd]
Caller[00000000101caae8]: nfsd_dispatch+0x90/0x220 [nfsd]
Caller[0000000010188410]: svc_process+0x318/0x760 [sunrpc]
Caller[00000000101ca8d4]: nfsd+0x17c/0x300 [nfsd]
Caller[0000000000418990]: kernel_thread+0x38/0x60
Caller[00000000101879e0]: __svc_create_thread+0x168/0x220 [sunrpc]
Instruction DUMP: 01000000  01000000  9de3bf40 <c25e0000> a0100018=20
90102001  8330700e  80886001  12600034

My /etc/exports file is :
/export/home=20
192.168.0.0/255.255.255.0(rw,root_squash,secure,async,map_identity,subtree_=
check)

	Regards,

	JKB
