From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Thu, 22 Jan 2009 21:11:29 +0000
Subject: Re: [sparc] ext3 corruption on latest mainline
Message-Id: <200901222211.29730.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <200901201917.12141.m.kozlowski@tuxland.pl>
In-Reply-To: <200901201917.12141.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> > > > > I ended up with corrupted ext3 (see sparc.jpg) and working now to=
 restore it.
> > > >=20
> > > > Up and running again. I managed to get some more info from yesterda=
y crash from syslog:
> > >=20
> > > I've seen similar corruptions with an Intel SSD drive on an MPT Fusion
> > > SAS interface, which also goes through scsi like your sym case here.
> > >=20
> > > But I'm pretty sure I also saw them with 2.6.28, were you able to run
> > > 2.6.28 cleanly?
> >=20
> > The thing is the last time I run this sparc was somewhere in 2.6.27~2.6=
.28 window.
> > I didn't see anything like it at that time. I'll give a try to 2.6.28 b=
ut it might
> > be hard to trigger it as I don't know what exactly caused it. Also yest=
erday
> > the very same kernel (f3b8436a) worked under I/O load for hours just fi=
ne.
> > I'll leave it with 2.6.28 on it busy for a few days and see what happen=
s.
>=20
> This is vanilla 2.6.28 and it shows memory corruption problems as well.
> After a few hours I got these:
>=20
> (see my comments at the end of mail)
>=20
> Jan 22 15:49:27 localhost kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> Jan 22 15:49:27 localhost kernel: BUG tsb_16KB: Object padding overwritten
> Jan 22 15:49:27 localhost kernel: ---------------------------------------=
--------------------------------------
> Jan 22 15:49:27 localhost kernel:=20
> Jan 22 15:49:27 localhost kernel: INFO: 0xfffff800bdb7fcc0-0xfffff800bdb7=
fcff. First byte 0x0 instead of 0x5a
> Jan 22 15:49:27 localhost kernel: INFO: Allocated in tsb_grow+0x88/0x440 =
age=19349783 cpu=3D0 pid212
> Jan 22 15:49:27 localhost kernel: INFO: Freed in tsb_grow+0x2f0/0x440 age=
=19810433 cpu=3D0 pid(23
> Jan 22 15:49:27 localhost kernel: INFO: Slab 0x0000000202392680 objects=
=3D1 used=3D1 fp=3D0x0000000000000000 flags=3D0x2083
> Jan 22 15:49:27 localhost kernel: INFO: Object 0xfffff800bdb78000 @offset=
=3D0 fp=3D0x0000000000000000
> Jan 22 15:49:27 localhost kernel:=20
> Jan 22 15:49:27 localhost kernel:   Object 0xfffff800bdb78000:  00 00 40 =
00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b ..@.....kkkkkkkk
[...]
> Jan 22 15:49:28 localhost kernel:  Padding 0xfffff800bdb7fff0:  5a 5a 5a =
5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a ZZZZZZZZZZZZZZZZ
> Jan 22 15:49:28 localhost kernel: Call Trace:
> Jan 22 15:49:28 localhost kernel:  [00000000004bde04] print_trailer+0xc4/=
0x160
> Jan 22 15:49:28 localhost kernel:  [00000000004be4a8] check_bytes_and_rep=
ort+0xa8/0xe0
> Jan 22 15:49:28 localhost kernel:  [00000000004be6e0] check_object+0x200/=
0x260
> Jan 22 15:49:28 localhost kernel:  [00000000004bee0c] __slab_free+0x2ac/0=
x440
> Jan 22 15:49:28 localhost kernel:  [00000000004c1ce8] kmem_cache_free+0x8=
8/0xe0
> Jan 22 15:49:28 localhost kernel:  [00000000004448e0] destroy_context+0x2=
0/0xa0
> Jan 22 15:49:28 localhost kernel:  [000000000045a260] __mmdrop+0x80/0xc0
> Jan 22 15:49:28 localhost kernel:  [00000000004552e8] finish_task_switch+=
0x88/0xc0
> Jan 22 15:49:28 localhost kernel:  [00000000006bf874] switch_to_pc+0x88/0=
x4d4
> Jan 22 15:49:28 localhost kernel:  [00000000006c11a4] schedule_hrtimeout_=
range+0xc4/0xe0
> Jan 22 15:49:28 localhost kernel:  [00000000004d3338] do_select+0x3b8/0x4=
c0
> Jan 22 15:49:28 localhost kernel:  [00000000004fb300] compat_core_sys_sel=
ect+0x160/0x200
> Jan 22 15:49:28 localhost kernel:  [00000000004fce60] compat_sys_select+0=
x20/0x100
> Jan 22 15:49:28 localhost kernel:  [0000000000406254] linux_sparc_syscall=
32+0x34/0x40
> Jan 22 15:49:28 localhost kernel: FIX tsb_16KB: Restoring 0xfffff800bdb7f=
cc0-0xfffff800bdb7fcff=3D0x5a
> Jan 22 15:49:28 localhost kernel:=20
> Jan 22 15:55:40 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:02:21 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:09:02 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:15:43 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:22:24 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:29:05 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:35:46 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:42:27 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:45:40 localhost rc-scripts: WARNING:  sshd has already been sta=
rted.
> Jan 22 16:48:50 localhost kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> Jan 22 16:48:50 localhost kernel: BUG kmalloc-64: Redzone overwritten
> Jan 22 16:48:50 localhost kernel: ---------------------------------------=
--------------------------------------
> Jan 22 16:48:50 localhost kernel:=20
> Jan 22 16:48:50 localhost kernel: INFO: 0xfffff800bdd526a0-0xfffff800bdd5=
26a7. First byte 0x0 instead of 0xbb
> Jan 22 16:48:50 localhost kernel: INFO: Freed in free_rb_tree_fname+0x48/=
0xc0 age=104208 cpu=3D0 pidV36
> Jan 22 16:48:50 localhost kernel: INFO: Slab 0x0000000202397f60 objects` =
usedY fp=3D0xfffff800bdd52660 flags=3D0x00c3
> Jan 22 16:48:50 localhost kernel: INFO: Object 0xfffff800bdd52660 @offset=
=1632 fp=3D0x0000000000000000
> Jan 22 16:48:50 localhost kernel:=20
> Jan 22 16:48:50 localhost kernel: Bytes b4 0xfffff800bdd52650:  00 00 00 =
00 00 00 00 00 5a 5a 5a 5a 5a 5a 5a 5a ........ZZZZZZZZ
> Jan 22 16:48:50 localhost kernel:   Object 0xfffff800bdd52660:  6b 6b 6b =
6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b kkkkkkkkkkkkkkkk
> Jan 22 16:48:50 localhost kernel:   Object 0xfffff800bdd52670:  6b 6b 6b =
6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b kkkkkkkkkkkkkkkk
> Jan 22 16:48:50 localhost kernel:   Object 0xfffff800bdd52680:  00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> Jan 22 16:48:50 localhost kernel:   Object 0xfffff800bdd52690:  00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> Jan 22 16:48:50 localhost kernel:  Redzone 0xfffff800bdd526a0:  00 00 00 =
00 00 00 00 00                         ........       =20
> Jan 22 16:48:50 localhost kernel:  Padding 0xfffff800bdd526e0:  5a 5a 5a =
5a 5a 5a 5a 5a                         ZZZZZZZZ       =20
> Jan 22 16:48:50 localhost kernel: Call Trace:
> Jan 22 16:48:50 localhost kernel:  [00000000004bde04] print_trailer+0xc4/=
0x160
> Jan 22 16:48:50 localhost kernel:  [00000000004be4a8] check_bytes_and_rep=
ort+0xa8/0xe0
> Jan 22 16:48:50 localhost kernel:  [00000000004be528] check_object+0x48/0=
x260
> Jan 22 16:48:50 localhost kernel:  [00000000004bfadc] __slab_alloc+0x59c/=
0x720
> Jan 22 16:48:50 localhost kernel:  [00000000004bfef4] __kmalloc+0xf4/0x120
> Jan 22 16:48:50 localhost kernel:  [0000000000519258] ext3_htree_store_di=
rent+0x18/0x160
> Jan 22 16:48:50 localhost kernel:  [00000000005232d0] htree_dirblock_to_t=
ree+0x170/0x1e0
> Jan 22 16:48:50 localhost kernel:  [0000000000523394] ext3_htree_fill_tre=
e+0x54/0x260
> Jan 22 16:48:50 localhost kernel:  [0000000000519900] ext3_readdir+0x560/=
0x660
> Jan 22 16:48:50 localhost kernel:  [00000000004d22f8] vfs_readdir+0x78/0x=
c0
> Jan 22 16:48:50 localhost kernel:  [00000000004d2370] sys_getdents64+0x30=
/0xa0
> Jan 22 16:48:50 localhost kernel:  [0000000000406254] linux_sparc_syscall=
32+0x34/0x40
> Jan 22 16:48:50 localhost kernel: FIX kmalloc-64: Restoring 0xfffff800bdd=
526a0-0xfffff800bdd526a7=3D0xbb
> Jan 22 16:48:50 localhost kernel:=20
> Jan 22 16:48:50 localhost kernel: FIX kmalloc-64: Marking all objects used
> Jan 22 16:49:09 localhost init: Id "s0" respawning too fast: disabled for=
 5 minutes
> Jan 22 16:49:14 localhost kernel: SysRq : Emergency Sync
> Jan 22 16:49:14 localhost kernel: Emergency Sync complete
>=20
> I left the box doing some compilation etc. Somewhere around 16:45 I could=
n't log into it via ssh so I logged into
> the box on a few terminals, started typing something and the terminals st=
arted freezing one after another. At the
> end the buzzer was making constant sound and then the keyboard stopped wo=
rking - at that point I considered the
> box dead so I restared it manually. I'll push it some more to see if/what=
 else pops out.

Another one:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DBUG nfs_inode_cache: Redzone overwri=
tten
---------------------------------------------------------------------------=
--

INFO: 0xfffff800affe7b78-0xfffff800affe7b7f. First byte 0x30 instead of 0xcc
INFO: Allocated in nfs_alloc_inode+0x10/0x40 age=11324173 cpu=3D0 pidD71
INFO: Slab 0x00000002020ffa00 objects" used" fp=3D0x0000000000000000 flags=
=3D0x2083
INFO: Object 0xfffff800affe7620 @offset0240 fp=3D0x0000000000000000

Bytes b4 0xfffff800affe7610:  00 00 00 00 00 00 00 00 5a 5a 5a 5a 5a 5a 5a =
5a ........ZZZZZZZZ
  Object 0xfffff800affe7620:  00 00 00 00 01 f4 c4 89 00 24 01 00 07 01 9a =
44 .....=F4=C4..$.....D
  Object 0xfffff800affe7630:  6b 01 00 00 00 00 58 c4 5a 3f 85 9e 41 3f ae =
b8 k.....X=C4Z?..A?=AE=B8
  Object 0xfffff800affe7640:  1d 46 52 42 55 be 89 c4 f4 01 b8 cd d9 ad 5a =
5a .FRBU=BE.=C4=F4.=B8=CD=D9=ADZZ
  Object 0xfffff800affe7650:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a =
5a ZZZZZZZZZZZZZZZZ
  Object 0xfffff800affe7660:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a =
5a ZZZZZZZZZZZZZZZZ
  Object 0xfffff800affe7670:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a =
5a ZZZZZZZZZZZZZZZZ
  Object 0xfffff800affe7680:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a =
5a ZZZZZZZZZZZZZZZZ
  Object 0xfffff800affe7690:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a =
5a ZZZZZZZZZZZZZZZZ
  Object 0xfffff800affe76a0:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a =
5a ZZZZZZZZZZZZZZZZ
  Object 0xfffff800affe76b0:  00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 =
02 ................
  Object 0xfffff800affe76c0:  00 00 00 01 00 02 8a bd 00 00 00 00 00 00 75 =
30 .......=BD......u0
  Object 0xfffff800affe76d0:  00 00 00 01 00 02 88 b7 00 00 00 00 00 00 00 =
01 .......=B7........
  Object 0xfffff800affe76e0:  00 00 00 00 00 00 36 b8 5a 5a 5a 5a 5a 5a 5a =
5a ......6=B8ZZZZZZZZ
  Object 0xfffff800affe76f0:  00 00 00 00 00 00 00 00 ff ff f8 00 af fe 76 =
f8 ........=FF=FF=F8.=AF=FEv=F8
  Object 0xfffff800affe7700:  ff ff f8 00 af fe 76 f8 ff ff f8 00 af fe 77 =
08 =FF=FF=F8.=AF=FEv=F8=FF=FF=F8.=AF=FEw.
  Object 0xfffff800affe7710:  ff ff f8 00 af fe 77 08 00 00 00 00 00 00 00 =
00 =FF=FF=F8.=AF=FEw.........
  Object 0xfffff800affe7720:  00 00 00 00 00 00 00 20 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe7730:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe7740:  ff ff f8 00 af fe 77 40 ff ff f8 00 af fe 77 =
40 =FF=FF=F8.=AF=FEw@=FF=FF=F8.=AF=FEw@
  Object 0xfffff800affe7750:  00 00 00 01 5a 5a 5a 5a 00 00 00 00 00 00 00 =
00 ....ZZZZ........
  Object 0xfffff800affe7760:  00 5a 5a 5a 5a 5a 5a 5a de ad 4e ad ff ff ff =
ff .ZZZZZZZ=DE=ADN=AD=FF=FF=FF=FF
  Object 0xfffff800affe7770:  ff ff ff ff ff ff ff ff 00 00 00 00 00 92 a6 =
30 =FF=FF=FF=FF=FF=FF=FF=FF......=A60
  Object 0xfffff800affe7780:  00 00 00 00 00 00 00 00 00 00 00 00 00 75 b3 =
c8 .............u=B3=C8
  Object 0xfffff800affe7790:  ff ff f8 00 af fe 77 90 ff ff f8 00 af fe 77 =
90 =FF=FF=F8.=AF=FEw.=FF=FF=F8.=AF=FEw.
  Object 0xfffff800affe77a0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe77b0:  00 00 00 00 00 10 01 00 00 00 00 00 00 20 02 =
00 ................
  Object 0xfffff800affe77c0:  ff ff f8 00 af fe 77 c0 ff ff f8 00 af fe 77 =
c0 =FF=FF=F8.=AF=FEw=C0=FF=FF=F8.=AF=FEw=C0
  Object 0xfffff800affe77d0:  ff ff f8 00 af fe 77 d0 ff ff f8 00 af fe 77 =
d0 =FF=FF=F8.=AF=FEw=D0=FF=FF=F8.=AF=FEw=D0
  Object 0xfffff800affe77e0:  00 00 00 00 01 f4 c4 89 00 00 00 00 00 00 00 =
02 .....=F4=C4.........
  Object 0xfffff800affe77f0:  00 00 03 e8 00 00 03 e8 00 00 00 00 00 00 00 =
00 ...=E8...=E8........
  Object 0xfffff800affe7800:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 =
00 ................
  Object 0xfffff800affe7810:  00 00 00 00 48 ea 74 ac 00 00 00 00 00 00 00 =
00 ....H=EAt=AC........
  Object 0xfffff800affe7820:  00 00 00 00 49 76 fe 74 00 00 00 00 00 00 00 =
00 ....Iv=FEt........
  Object 0xfffff800affe7830:  00 00 00 00 49 76 fe 74 00 00 00 00 00 00 00 =
00 ....Iv=FEt........
  Object 0xfffff800affe7840:  00 00 00 12 00 00 00 00 00 00 00 00 00 00 00 =
08 ................
  Object 0xfffff800affe7850:  00 00 41 ed 00 00 00 00 00 00 00 00 00 00 00 =
00 ..A=ED............
  Object 0xfffff800affe7860:  de ad 4e ad ff ff ff ff ff ff ff ff ff ff ff =
ff =DE=ADN=AD=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF
  Object 0xfffff800affe7870:  00 00 00 00 00 7b be 88 00 00 00 00 00 00 00 =
00 .....{=BE.........
  Object 0xfffff800affe7880:  00 00 00 00 00 76 4b f0 00 00 00 01 00 00 00 =
00 .....vK=F0........
  Object 0xfffff800affe7890:  00 00 00 00 00 00 00 00 de ad 4e ad ff ff ff =
ff ........=DE=ADN=AD=FF=FF=FF=FF
  Object 0xfffff800affe78a0:  ff ff ff ff ff ff ff ff 00 00 00 00 00 92 a6 =
60 =FF=FF=FF=FF=FF=FF=FF=FF......=A6`
  Object 0xfffff800affe78b0:  00 00 00 00 00 00 00 00 00 00 00 00 00 75 b4 =
c0 .............u=B4=C0
  Object 0xfffff800affe78c0:  ff ff f8 00 af fe 78 c0 ff ff f8 00 af fe 78 =
c0 =FF=FF=F8.=AF=FEx=C0=FF=FF=F8.=AF=FEx=C0
  Object 0xfffff800affe78d0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe78e0:  ff ff f8 00 af fe 78 88 00 00 00 00 00 7b be =
98 =FF=FF=F8.=AF=FEx......{=BE.
  Object 0xfffff800affe78f0:  00 00 00 00 00 00 00 00 00 00 00 00 00 76 4c =
70 .............vLp
  Object 0xfffff800affe7900:  00 69 7a 38 00 69 78 d8 00 00 00 00 00 00 00 =
00 .iz8.ix=D8........
  Object 0xfffff800affe7910:  00 69 78 f8 00 00 00 00 00 5f 38 d0 00 71 dc =
c0 .ix=F8....._8=D0.q=DC=C0
  Object 0xfffff800affe7920:  00 69 79 38 00 71 dc e0 00 00 00 00 00 00 00 =
00 .iy8.q=DC=E0........
  Object 0xfffff800affe7930:  00 69 79 18 00 00 00 02 00 5f 38 d0 00 69 79 =
18 .iy......_8=D0.iy.
  Object 0xfffff800affe7940:  ff ff f8 00 af fe 79 38 00 00 00 00 00 7b be =
a0 =FF=FF=F8.=AF=FEy8.....{=BE.
  Object 0xfffff800affe7950:  00 00 00 00 00 00 00 00 00 00 00 00 00 76 4c =
50 .............vLP
  Object 0xfffff800affe7960:  00 00 00 00 00 6d 5e 38 00 00 00 00 00 6d 5c =
a8 .....m^8.....m\=A8
  Object 0xfffff800affe7970:  ff ff f8 00 bd 84 5b 18 00 00 00 00 00 00 00 =
00 =FF=FF=F8.=BD.[.........
  Object 0xfffff800affe7980:  ff ff f8 00 af fe 79 88 ff ff f8 00 af fe 77 =
a0 =FF=FF=F8.=AF=FEy.=FF=FF=F8.=AF=FEw.
  Object 0xfffff800affe7990:  00 00 00 00 00 00 00 20 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe79a0:  00 00 00 00 00 00 00 00 de ad 4e ad ff ff ff =
ff ........=DE=ADN=AD=FF=FF=FF=FF
  Object 0xfffff800affe79b0:  ff ff ff ff ff ff ff ff 00 00 00 00 00 e7 1d =
70 =FF=FF=FF=FF=FF=FF=FF=FF.....=E7.p
  Object 0xfffff800affe79c0:  00 00 00 00 00 00 00 00 00 00 00 00 00 76 4c =
d0 .............vL=D0
  Object 0xfffff800affe79d0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe79e0:  00 01 00 01 00 00 00 00 ff ff f8 00 af fe 79 =
e8 ........=FF=FF=F8.=AF=FEy=E8
  Object 0xfffff800affe79f0:  ff ff f8 00 af fe 79 e8 00 00 00 00 00 00 00 =
00 =FF=FF=F8.=AF=FEy=E8........
  Object 0xfffff800affe7a00:  de ad 4e ad ff ff ff ff ff ff ff ff ff ff ff =
ff =DE=ADN=AD=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF
  Object 0xfffff800affe7a10:  00 00 00 00 00 e7 1d 68 00 00 00 00 00 00 00 =
00 .....=E7.h........
  Object 0xfffff800affe7a20:  00 00 00 00 00 76 4c f0 00 00 00 00 00 00 00 =
00 .....vL=F0........
  Object 0xfffff800affe7a30:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe7a40:  00 00 00 00 00 e7 1c c8 00 00 00 00 00 12 00 =
d2 .....=E7.=C8.......=D2
  Object 0xfffff800affe7a50:  00 00 00 00 00 7b 46 40 00 00 00 00 00 00 00 =
00 .....{F@........
  Object 0xfffff800affe7a60:  de ad 4e ad ff ff ff ff ff ff ff ff ff ff ff =
ff =DE=ADN=AD=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF
  Object 0xfffff800affe7a70:  00 00 00 00 00 e7 1d 60 00 00 00 00 00 00 00 =
00 .....=E7.`........
  Object 0xfffff800affe7a80:  00 00 00 00 00 76 4d 10 ff ff f8 00 af fe 7a =
88 .....vM.=FF=FF=F8.=AF=FEz.
  Object 0xfffff800affe7a90:  ff ff f8 00 af fe 7a 88 00 00 00 00 00 00 00 =
00 =FF=FF=F8.=AF=FEz.........
  Object 0xfffff800affe7aa0:  ff ff f8 00 af fe 7a a0 ff ff f8 00 af fe 7a =
a0 =FF=FF=F8.=AF=FEz.=FF=FF=F8.=AF=FEz.
  Object 0xfffff800affe7ab0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe7ac0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe7ad0:  ff ff f8 00 af fe 7a d0 ff ff f8 00 af fe 7a =
d0 =FF=FF=F8.=AF=FEz=D0=FF=FF=F8.=AF=FEz=D0
  Object 0xfffff800affe7ae0:  00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
  Object 0xfffff800affe7af0:  de ad 4e ad ff ff ff ff ff ff ff ff ff ff ff =
ff =DE=ADN=AD=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF
  Object 0xfffff800affe7b00:  00 00 00 00 00 92 a6 60 00 00 00 00 00 00 00 =
00 ......=A6`........
  Object 0xfffff800affe7b10:  00 00 00 00 00 75 b4 c0 ff ff f8 00 af fe 7b =
18 .....u=B4=C0=FF=FF=F8.=AF=FE{.
  Object 0xfffff800affe7b20:  ff ff f8 00 af fe 7b 18 00 00 00 00 00 00 00 =
00 =FF=FF=F8.=AF=FE{.........
  Object 0xfffff800affe7b30:  00 00 00 00 00 00 00 00 ff ff f8 00 af fe 7a =
e0 ........=FF=FF=F8.=AF=FEz=E0
  Object 0xfffff800affe7b40:  00 00 00 00 00 06 02 00 30 7f fc 00 00 00 c0 =
00 ........0.=FC...=C0.
  Object 0xfffff800affe7b50:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
40 ...............@
  Object 0xfffff800affe7b60:  00 00 01 0c 00 00 00 09 00 00 00 24 00 00 00 =
07 ...........$....
  Object 0xfffff800affe7b70:  00 00 00 00 00 06 02 00                      =
   ........       =20
 Redzone 0xfffff800affe7b78:  30 7f fc 00 00 00 40 00                      =
   0.=FC...@.       =20
 Padding 0xfffff800affe7bb8:  5a 5a 5a 5a 5a 5a 5a 5a                      =
   ZZZZZZZZ       =20
Call Trace:
 [00000000004bde04] print_trailer+0xc4/0x160
 [00000000004be4a8] check_bytes_and_report+0xa8/0xe0
 [00000000004be528] check_object+0x48/0x260
 [00000000004bee0c] __slab_free+0x2ac/0x440
 [00000000004c1ce8] kmem_cache_free+0x88/0xe0
 [00000000005456ec] nfs_destroy_inode+0xc/0x20
 [00000000004d75cc] destroy_inode+0x2c/0x60
 [00000000004d7cec] dispose_list+0xac/0x100
 [00000000004d8614] shrink_icache_memory+0x1d4/0x2e0
 [00000000004a29cc] shrink_slab+0x16c/0x200
 [00000000004a2df8] kswapd+0x398/0x5a0
 [000000000047381c] kthread+0x3c/0x80
 [0000000000427010] kernel_thread+0x30/0x60
 [0000000000473b10] kthreadd+0x170/0x200
FIX nfs_inode_cache: Restoring 0xfffff800affe7b78-0xfffff800affe7b7f=3D0xcc
