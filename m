From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Thu, 22 Jan 2009 22:58:13 +0000
Subject: Re: [sparc] ext3 corruption on latest mainline
Message-Id: <200901222358.13640.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <200901201917.12141.m.kozlowski@tuxland.pl>
In-Reply-To: <200901201917.12141.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> > > > > > I ended up with corrupted ext3 (see sparc.jpg) and working now =
to restore it.
> > > > >=20
> > > > > Up and running again. I managed to get some more info from yester=
day crash from syslog:
> > > >=20
> > > > I've seen similar corruptions with an Intel SSD drive on an MPT Fus=
ion
> > > > SAS interface, which also goes through scsi like your sym case here.
> > > >=20
> > > > But I'm pretty sure I also saw them with 2.6.28, were you able to r=
un
> > > > 2.6.28 cleanly?
> > >=20
> > > The thing is the last time I run this sparc was somewhere in 2.6.27~2=
.6.28 window.
> > > I didn't see anything like it at that time. I'll give a try to 2.6.28=
 but it might
> > > be hard to trigger it as I don't know what exactly caused it. Also ye=
sterday
> > > the very same kernel (f3b8436a) worked under I/O load for hours just =
fine.
> > > I'll leave it with 2.6.28 on it busy for a few days and see what happ=
ens.
> >=20
> > This is vanilla 2.6.28 and it shows memory corruption problems as well.
> > After a few hours I got these:
> >=20
> > (see my comments at the end of mail)
> >=20
> > Jan 22 15:49:27 localhost kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D> > Jan 22 15:49:27 localhost kernel: BUG tsb_16KB: Object padding overw=
ritten
> > Jan 22 15:49:27 localhost kernel: -------------------------------------=
----------------------------------------
> > Jan 22 15:49:27 localhost kernel:=20
> > Jan 22 15:49:27 localhost kernel: INFO: 0xfffff800bdb7fcc0-0xfffff800bd=
b7fcff. First byte 0x0 instead of 0x5a
> > Jan 22 15:49:27 localhost kernel: INFO: Allocated in tsb_grow+0x88/0x44=
0 age=19349783 cpu=3D0 pid212
> > Jan 22 15:49:27 localhost kernel: INFO: Freed in tsb_grow+0x2f0/0x440 a=
ge=19810433 cpu=3D0 pid(23
> > Jan 22 15:49:27 localhost kernel: INFO: Slab 0x0000000202392680 objects=
=3D1 used=3D1 fp=3D0x0000000000000000 flags=3D0x2083
> > Jan 22 15:49:27 localhost kernel: INFO: Object 0xfffff800bdb78000 @offs=
et=3D0 fp=3D0x0000000000000000
> > Jan 22 15:49:27 localhost kernel:=20
> > Jan 22 15:49:27 localhost kernel:   Object 0xfffff800bdb78000:  00 00 4=
0 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b ..@.....kkkkkkkk
> [...]
> > Jan 22 15:49:28 localhost kernel:  Padding 0xfffff800bdb7fff0:  5a 5a 5=
a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a ZZZZZZZZZZZZZZZZ
> > Jan 22 15:49:28 localhost kernel: Call Trace:
> > Jan 22 15:49:28 localhost kernel:  [00000000004bde04] print_trailer+0xc=
4/0x160
> > Jan 22 15:49:28 localhost kernel:  [00000000004be4a8] check_bytes_and_r=
eport+0xa8/0xe0
> > Jan 22 15:49:28 localhost kernel:  [00000000004be6e0] check_object+0x20=
0/0x260
> > Jan 22 15:49:28 localhost kernel:  [00000000004bee0c] __slab_free+0x2ac=
/0x440
> > Jan 22 15:49:28 localhost kernel:  [00000000004c1ce8] kmem_cache_free+0=
x88/0xe0
> > Jan 22 15:49:28 localhost kernel:  [00000000004448e0] destroy_context+0=
x20/0xa0
> > Jan 22 15:49:28 localhost kernel:  [000000000045a260] __mmdrop+0x80/0xc0
> > Jan 22 15:49:28 localhost kernel:  [00000000004552e8] finish_task_switc=
h+0x88/0xc0
> > Jan 22 15:49:28 localhost kernel:  [00000000006bf874] switch_to_pc+0x88=
/0x4d4
> > Jan 22 15:49:28 localhost kernel:  [00000000006c11a4] schedule_hrtimeou=
t_range+0xc4/0xe0
> > Jan 22 15:49:28 localhost kernel:  [00000000004d3338] do_select+0x3b8/0=
x4c0
> > Jan 22 15:49:28 localhost kernel:  [00000000004fb300] compat_core_sys_s=
elect+0x160/0x200
> > Jan 22 15:49:28 localhost kernel:  [00000000004fce60] compat_sys_select=
+0x20/0x100
> > Jan 22 15:49:28 localhost kernel:  [0000000000406254] linux_sparc_sysca=
ll32+0x34/0x40
> > Jan 22 15:49:28 localhost kernel: FIX tsb_16KB: Restoring 0xfffff800bdb=
7fcc0-0xfffff800bdb7fcff=3D0x5a
> > Jan 22 15:49:28 localhost kernel:=20
> > Jan 22 15:55:40 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:02:21 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:09:02 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:15:43 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:22:24 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:29:05 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:35:46 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:42:27 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:45:40 localhost rc-scripts: WARNING:  sshd has already been s=
tarted.
> > Jan 22 16:48:50 localhost kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D> > Jan 22 16:48:50 localhost kernel: BUG kmalloc-64: Redzone overwritten
> > Jan 22 16:48:50 localhost kernel: -------------------------------------=
----------------------------------------
> > Jan 22 16:48:50 localhost kernel:=20
> > Jan 22 16:48:50 localhost kernel: INFO: 0xfffff800bdd526a0-0xfffff800bd=
d526a7. First byte 0x0 instead of 0xbb
> > Jan 22 16:48:50 localhost kernel: INFO: Freed in free_rb_tree_fname+0x4=
8/0xc0 age=104208 cpu=3D0 pidV36
> > Jan 22 16:48:50 localhost kernel: INFO: Slab 0x0000000202397f60 objects=
` usedY fp=3D0xfffff800bdd52660 flags=3D0x00c3
> > Jan 22 16:48:50 localhost kernel: INFO: Object 0xfffff800bdd52660 @offs=
et=1632 fp=3D0x0000000000000000
> > Jan 22 16:48:50 localhost kernel:=20
> > Jan 22 16:48:50 localhost kernel: Bytes b4 0xfffff800bdd52650:  00 00 0=
0 00 00 00 00 00 5a 5a 5a 5a 5a 5a 5a 5a ........ZZZZZZZZ
> > Jan 22 16:48:50 localhost kernel:   Object 0xfffff800bdd52660:  6b 6b 6=
b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b kkkkkkkkkkkkkkkk
> > Jan 22 16:48:50 localhost kernel:   Object 0xfffff800bdd52670:  6b 6b 6=
b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b kkkkkkkkkkkkkkkk
> > Jan 22 16:48:50 localhost kernel:   Object 0xfffff800bdd52680:  00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> > Jan 22 16:48:50 localhost kernel:   Object 0xfffff800bdd52690:  00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> > Jan 22 16:48:50 localhost kernel:  Redzone 0xfffff800bdd526a0:  00 00 0=
0 00 00 00 00 00                         ........       =20
> > Jan 22 16:48:50 localhost kernel:  Padding 0xfffff800bdd526e0:  5a 5a 5=
a 5a 5a 5a 5a 5a                         ZZZZZZZZ       =20
> > Jan 22 16:48:50 localhost kernel: Call Trace:
> > Jan 22 16:48:50 localhost kernel:  [00000000004bde04] print_trailer+0xc=
4/0x160
> > Jan 22 16:48:50 localhost kernel:  [00000000004be4a8] check_bytes_and_r=
eport+0xa8/0xe0
> > Jan 22 16:48:50 localhost kernel:  [00000000004be528] check_object+0x48=
/0x260
> > Jan 22 16:48:50 localhost kernel:  [00000000004bfadc] __slab_alloc+0x59=
c/0x720
> > Jan 22 16:48:50 localhost kernel:  [00000000004bfef4] __kmalloc+0xf4/0x=
120
> > Jan 22 16:48:50 localhost kernel:  [0000000000519258] ext3_htree_store_=
dirent+0x18/0x160
> > Jan 22 16:48:50 localhost kernel:  [00000000005232d0] htree_dirblock_to=
_tree+0x170/0x1e0
> > Jan 22 16:48:50 localhost kernel:  [0000000000523394] ext3_htree_fill_t=
ree+0x54/0x260
> > Jan 22 16:48:50 localhost kernel:  [0000000000519900] ext3_readdir+0x56=
0/0x660
> > Jan 22 16:48:50 localhost kernel:  [00000000004d22f8] vfs_readdir+0x78/=
0xc0
> > Jan 22 16:48:50 localhost kernel:  [00000000004d2370] sys_getdents64+0x=
30/0xa0
> > Jan 22 16:48:50 localhost kernel:  [0000000000406254] linux_sparc_sysca=
ll32+0x34/0x40
> > Jan 22 16:48:50 localhost kernel: FIX kmalloc-64: Restoring 0xfffff800b=
dd526a0-0xfffff800bdd526a7=3D0xbb
> > Jan 22 16:48:50 localhost kernel:=20
> > Jan 22 16:48:50 localhost kernel: FIX kmalloc-64: Marking all objects u=
sed
> > Jan 22 16:49:09 localhost init: Id "s0" respawning too fast: disabled f=
or 5 minutes
> > Jan 22 16:49:14 localhost kernel: SysRq : Emergency Sync
> > Jan 22 16:49:14 localhost kernel: Emergency Sync complete
> >=20
> > I left the box doing some compilation etc. Somewhere around 16:45 I cou=
ldn't log into it via ssh so I logged into
> > the box on a few terminals, started typing something and the terminals =
started freezing one after another. At the
> > end the buzzer was making constant sound and then the keyboard stopped =
working - at that point I considered the
> > box dead so I restared it manually. I'll push it some more to see if/wh=
at else pops out.
>=20
> Another one:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> BUG nfs_inode_cache: Redzone ov=
erwritten
> -------------------------------------------------------------------------=
----
>=20
> INFO: 0xfffff800affe7b78-0xfffff800affe7b7f. First byte 0x30 instead of 0=
xcc
> INFO: Allocated in nfs_alloc_inode+0x10/0x40 age=11324173 cpu=3D0 pidD71
> INFO: Slab 0x00000002020ffa00 objects" used" fp=3D0x0000000000000000 flag=
s=3D0x2083
> INFO: Object 0xfffff800affe7620 @offset0240 fp=3D0x0000000000000000
>=20
> Bytes b4 0xfffff800affe7610:  00 00 00 00 00 00 00 00 5a 5a 5a 5a 5a 5a 5=
a 5a ........ZZZZZZZZ
>   Object 0xfffff800affe7620:  00 00 00 00 01 f4 c4 89 00 24 01 00 07 01 9=
a 44 .....=F4=C4..$.....D
>   Object 0xfffff800affe7630:  6b 01 00 00 00 00 58 c4 5a 3f 85 9e 41 3f a=
e b8 k.....X=C4Z?..A?=AE=B8
>   Object 0xfffff800affe7640:  1d 46 52 42 55 be 89 c4 f4 01 b8 cd d9 ad 5=
a 5a .FRBU=BE.=C4=F4.=B8=CD=D9=ADZZ
>   Object 0xfffff800affe7650:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5=
a 5a ZZZZZZZZZZZZZZZZ
>   Object 0xfffff800affe7660:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5=
a 5a ZZZZZZZZZZZZZZZZ
>   Object 0xfffff800affe7670:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5=
a 5a ZZZZZZZZZZZZZZZZ
>   Object 0xfffff800affe7680:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5=
a 5a ZZZZZZZZZZZZZZZZ
>   Object 0xfffff800affe7690:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5=
a 5a ZZZZZZZZZZZZZZZZ
>   Object 0xfffff800affe76a0:  5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5=
a 5a ZZZZZZZZZZZZZZZZ
>   Object 0xfffff800affe76b0:  00 00 00 00 00 00 00 01 00 00 00 00 00 00 0=
0 02 ................
>   Object 0xfffff800affe76c0:  00 00 00 01 00 02 8a bd 00 00 00 00 00 00 7=
5 30 .......=BD......u0
>   Object 0xfffff800affe76d0:  00 00 00 01 00 02 88 b7 00 00 00 00 00 00 0=
0 01 .......=B7........
>   Object 0xfffff800affe76e0:  00 00 00 00 00 00 36 b8 5a 5a 5a 5a 5a 5a 5=
a 5a ......6=B8ZZZZZZZZ
>   Object 0xfffff800affe76f0:  00 00 00 00 00 00 00 00 ff ff f8 00 af fe 7=
6 f8 ........=FF=FF=F8.=AF=FEv=F8
>   Object 0xfffff800affe7700:  ff ff f8 00 af fe 76 f8 ff ff f8 00 af fe 7=
7 08 =FF=FF=F8.=AF=FEv=F8=FF=FF=F8.=AF=FEw.
>   Object 0xfffff800affe7710:  ff ff f8 00 af fe 77 08 00 00 00 00 00 00 0=
0 00 =FF=FF=F8.=AF=FEw.........
>   Object 0xfffff800affe7720:  00 00 00 00 00 00 00 20 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe7730:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe7740:  ff ff f8 00 af fe 77 40 ff ff f8 00 af fe 7=
7 40 =FF=FF=F8.=AF=FEw@=FF=FF=F8.=AF=FEw@
>   Object 0xfffff800affe7750:  00 00 00 01 5a 5a 5a 5a 00 00 00 00 00 00 0=
0 00 ....ZZZZ........
>   Object 0xfffff800affe7760:  00 5a 5a 5a 5a 5a 5a 5a de ad 4e ad ff ff f=
f ff .ZZZZZZZ=DE=ADN=AD=FF=FF=FF=FF
>   Object 0xfffff800affe7770:  ff ff ff ff ff ff ff ff 00 00 00 00 00 92 a=
6 30 =FF=FF=FF=FF=FF=FF=FF=FF......=A60
>   Object 0xfffff800affe7780:  00 00 00 00 00 00 00 00 00 00 00 00 00 75 b=
3 c8 .............u=B3=C8
>   Object 0xfffff800affe7790:  ff ff f8 00 af fe 77 90 ff ff f8 00 af fe 7=
7 90 =FF=FF=F8.=AF=FEw.=FF=FF=F8.=AF=FEw.
>   Object 0xfffff800affe77a0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe77b0:  00 00 00 00 00 10 01 00 00 00 00 00 00 20 0=
2 00 ................
>   Object 0xfffff800affe77c0:  ff ff f8 00 af fe 77 c0 ff ff f8 00 af fe 7=
7 c0 =FF=FF=F8.=AF=FEw=C0=FF=FF=F8.=AF=FEw=C0
>   Object 0xfffff800affe77d0:  ff ff f8 00 af fe 77 d0 ff ff f8 00 af fe 7=
7 d0 =FF=FF=F8.=AF=FEw=D0=FF=FF=F8.=AF=FEw=D0
>   Object 0xfffff800affe77e0:  00 00 00 00 01 f4 c4 89 00 00 00 00 00 00 0=
0 02 .....=F4=C4.........
>   Object 0xfffff800affe77f0:  00 00 03 e8 00 00 03 e8 00 00 00 00 00 00 0=
0 00 ...=E8...=E8........
>   Object 0xfffff800affe7800:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 1=
0 00 ................
>   Object 0xfffff800affe7810:  00 00 00 00 48 ea 74 ac 00 00 00 00 00 00 0=
0 00 ....H=EAt=AC........
>   Object 0xfffff800affe7820:  00 00 00 00 49 76 fe 74 00 00 00 00 00 00 0=
0 00 ....Iv=FEt........
>   Object 0xfffff800affe7830:  00 00 00 00 49 76 fe 74 00 00 00 00 00 00 0=
0 00 ....Iv=FEt........
>   Object 0xfffff800affe7840:  00 00 00 12 00 00 00 00 00 00 00 00 00 00 0=
0 08 ................
>   Object 0xfffff800affe7850:  00 00 41 ed 00 00 00 00 00 00 00 00 00 00 0=
0 00 ..A=ED............
>   Object 0xfffff800affe7860:  de ad 4e ad ff ff ff ff ff ff ff ff ff ff f=
f ff =DE=ADN=AD=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF
>   Object 0xfffff800affe7870:  00 00 00 00 00 7b be 88 00 00 00 00 00 00 0=
0 00 .....{=BE.........
>   Object 0xfffff800affe7880:  00 00 00 00 00 76 4b f0 00 00 00 01 00 00 0=
0 00 .....vK=F0........
>   Object 0xfffff800affe7890:  00 00 00 00 00 00 00 00 de ad 4e ad ff ff f=
f ff ........=DE=ADN=AD=FF=FF=FF=FF
>   Object 0xfffff800affe78a0:  ff ff ff ff ff ff ff ff 00 00 00 00 00 92 a=
6 60 =FF=FF=FF=FF=FF=FF=FF=FF......=A6`
>   Object 0xfffff800affe78b0:  00 00 00 00 00 00 00 00 00 00 00 00 00 75 b=
4 c0 .............u=B4=C0
>   Object 0xfffff800affe78c0:  ff ff f8 00 af fe 78 c0 ff ff f8 00 af fe 7=
8 c0 =FF=FF=F8.=AF=FEx=C0=FF=FF=F8.=AF=FEx=C0
>   Object 0xfffff800affe78d0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe78e0:  ff ff f8 00 af fe 78 88 00 00 00 00 00 7b b=
e 98 =FF=FF=F8.=AF=FEx......{=BE.
>   Object 0xfffff800affe78f0:  00 00 00 00 00 00 00 00 00 00 00 00 00 76 4=
c 70 .............vLp
>   Object 0xfffff800affe7900:  00 69 7a 38 00 69 78 d8 00 00 00 00 00 00 0=
0 00 .iz8.ix=D8........
>   Object 0xfffff800affe7910:  00 69 78 f8 00 00 00 00 00 5f 38 d0 00 71 d=
c c0 .ix=F8....._8=D0.q=DC=C0
>   Object 0xfffff800affe7920:  00 69 79 38 00 71 dc e0 00 00 00 00 00 00 0=
0 00 .iy8.q=DC=E0........
>   Object 0xfffff800affe7930:  00 69 79 18 00 00 00 02 00 5f 38 d0 00 69 7=
9 18 .iy......_8=D0.iy.
>   Object 0xfffff800affe7940:  ff ff f8 00 af fe 79 38 00 00 00 00 00 7b b=
e a0 =FF=FF=F8.=AF=FEy8.....{=BE.
>   Object 0xfffff800affe7950:  00 00 00 00 00 00 00 00 00 00 00 00 00 76 4=
c 50 .............vLP
>   Object 0xfffff800affe7960:  00 00 00 00 00 6d 5e 38 00 00 00 00 00 6d 5=
c a8 .....m^8.....m\=A8
>   Object 0xfffff800affe7970:  ff ff f8 00 bd 84 5b 18 00 00 00 00 00 00 0=
0 00 =FF=FF=F8.=BD.[.........
>   Object 0xfffff800affe7980:  ff ff f8 00 af fe 79 88 ff ff f8 00 af fe 7=
7 a0 =FF=FF=F8.=AF=FEy.=FF=FF=F8.=AF=FEw.
>   Object 0xfffff800affe7990:  00 00 00 00 00 00 00 20 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe79a0:  00 00 00 00 00 00 00 00 de ad 4e ad ff ff f=
f ff ........=DE=ADN=AD=FF=FF=FF=FF
>   Object 0xfffff800affe79b0:  ff ff ff ff ff ff ff ff 00 00 00 00 00 e7 1=
d 70 =FF=FF=FF=FF=FF=FF=FF=FF.....=E7.p
>   Object 0xfffff800affe79c0:  00 00 00 00 00 00 00 00 00 00 00 00 00 76 4=
c d0 .............vL=D0
>   Object 0xfffff800affe79d0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe79e0:  00 01 00 01 00 00 00 00 ff ff f8 00 af fe 7=
9 e8 ........=FF=FF=F8.=AF=FEy=E8
>   Object 0xfffff800affe79f0:  ff ff f8 00 af fe 79 e8 00 00 00 00 00 00 0=
0 00 =FF=FF=F8.=AF=FEy=E8........
>   Object 0xfffff800affe7a00:  de ad 4e ad ff ff ff ff ff ff ff ff ff ff f=
f ff =DE=ADN=AD=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF
>   Object 0xfffff800affe7a10:  00 00 00 00 00 e7 1d 68 00 00 00 00 00 00 0=
0 00 .....=E7.h........
>   Object 0xfffff800affe7a20:  00 00 00 00 00 76 4c f0 00 00 00 00 00 00 0=
0 00 .....vL=F0........
>   Object 0xfffff800affe7a30:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe7a40:  00 00 00 00 00 e7 1c c8 00 00 00 00 00 12 0=
0 d2 .....=E7.=C8.......=D2
>   Object 0xfffff800affe7a50:  00 00 00 00 00 7b 46 40 00 00 00 00 00 00 0=
0 00 .....{F@........
>   Object 0xfffff800affe7a60:  de ad 4e ad ff ff ff ff ff ff ff ff ff ff f=
f ff =DE=ADN=AD=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF
>   Object 0xfffff800affe7a70:  00 00 00 00 00 e7 1d 60 00 00 00 00 00 00 0=
0 00 .....=E7.`........
>   Object 0xfffff800affe7a80:  00 00 00 00 00 76 4d 10 ff ff f8 00 af fe 7=
a 88 .....vM.=FF=FF=F8.=AF=FEz.
>   Object 0xfffff800affe7a90:  ff ff f8 00 af fe 7a 88 00 00 00 00 00 00 0=
0 00 =FF=FF=F8.=AF=FEz.........
>   Object 0xfffff800affe7aa0:  ff ff f8 00 af fe 7a a0 ff ff f8 00 af fe 7=
a a0 =FF=FF=F8.=AF=FEz.=FF=FF=F8.=AF=FEz.
>   Object 0xfffff800affe7ab0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe7ac0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe7ad0:  ff ff f8 00 af fe 7a d0 ff ff f8 00 af fe 7=
a d0 =FF=FF=F8.=AF=FEz=D0=FF=FF=F8.=AF=FEz=D0
>   Object 0xfffff800affe7ae0:  00 00 00 01 00 00 00 00 00 00 00 00 00 00 0=
0 00 ................
>   Object 0xfffff800affe7af0:  de ad 4e ad ff ff ff ff ff ff ff ff ff ff f=
f ff =DE=ADN=AD=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF
>   Object 0xfffff800affe7b00:  00 00 00 00 00 92 a6 60 00 00 00 00 00 00 0=
0 00 ......=A6`........
>   Object 0xfffff800affe7b10:  00 00 00 00 00 75 b4 c0 ff ff f8 00 af fe 7=
b 18 .....u=B4=C0=FF=FF=F8.=AF=FE{.
>   Object 0xfffff800affe7b20:  ff ff f8 00 af fe 7b 18 00 00 00 00 00 00 0=
0 00 =FF=FF=F8.=AF=FE{.........
>   Object 0xfffff800affe7b30:  00 00 00 00 00 00 00 00 ff ff f8 00 af fe 7=
a e0 ........=FF=FF=F8.=AF=FEz=E0
>   Object 0xfffff800affe7b40:  00 00 00 00 00 06 02 00 30 7f fc 00 00 00 c=
0 00 ........0.=FC...=C0.
>   Object 0xfffff800affe7b50:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 40 ...............@
>   Object 0xfffff800affe7b60:  00 00 01 0c 00 00 00 09 00 00 00 24 00 00 0=
0 07 ...........$....
>   Object 0xfffff800affe7b70:  00 00 00 00 00 06 02 00                    =
     ........       =20
>  Redzone 0xfffff800affe7b78:  30 7f fc 00 00 00 40 00                    =
     0.=FC...@.       =20
>  Padding 0xfffff800affe7bb8:  5a 5a 5a 5a 5a 5a 5a 5a                    =
     ZZZZZZZZ       =20
> Call Trace:
>  [00000000004bde04] print_trailer+0xc4/0x160
>  [00000000004be4a8] check_bytes_and_report+0xa8/0xe0
>  [00000000004be528] check_object+0x48/0x260
>  [00000000004bee0c] __slab_free+0x2ac/0x440
>  [00000000004c1ce8] kmem_cache_free+0x88/0xe0
>  [00000000005456ec] nfs_destroy_inode+0xc/0x20
>  [00000000004d75cc] destroy_inode+0x2c/0x60
>  [00000000004d7cec] dispose_list+0xac/0x100
>  [00000000004d8614] shrink_icache_memory+0x1d4/0x2e0
>  [00000000004a29cc] shrink_slab+0x16c/0x200
>  [00000000004a2df8] kswapd+0x398/0x5a0
>  [000000000047381c] kthread+0x3c/0x80
>  [0000000000427010] kernel_thread+0x30/0x60
>  [0000000000473b10] kthreadd+0x170/0x200
> FIX nfs_inode_cache: Restoring 0xfffff800affe7b78-0xfffff800affe7b7f=3D0x=
cc

And ... boom :)

Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 00000000000004b2
tsk->{mm,active_mm}->pgd =3D fffff8009848e000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
kswapd0(156): Oops [#1]
TSTATE: 0000009980f09605 TPC: 0000000000480094 TNPC: 0000000000480098 Y: 00=
000000    Not tainted
TPC: <__lock_acquire+0x34/0xb00>
g0: fffff800bf759090 g1: 000000000000000f g2: 0000000000000001 g3: fffff800=
bf348000
g4: fffff800bf331b00 g5: fffff800bf6d6000 g6: fffff800bf348000 g7: 00000000=
00000050
o0: 0000000000002000 o1: 00000000004a0cac o2: fff8000000000000 o3: fffff800=
bf331b00
o4: 0000000000000000 o5: 000000000099a760 sp: fffff800bf34b061 ret_pc: 0000=
0000004a4564
RPC: <__dec_zone_state+0x4/0xa0>
l0: 0000000000000494 l1: fffff80080002000 l2: 0000000000000000 l3: 00000800=
00000000
l4: fffff800bf331b00 l5: 00000000007c0c00 l6: 0000000000800000 l7: 00000000=
007a6000
i0: 00000000000000e8 i1: 0000000000000000 i2: 0000000000000000 i3: 00000000=
00000000
i4: 0000000000000001 i5: 0000000000000000 i6: fffff800bf34b121 i7: 00000000=
00481c04
I7: <lock_acquire+0x44/0x60>
Caller[0000000000481c04]: lock_acquire+0x44/0x60
Caller[00000000006c25e4]: _spin_lock+0x24/0x40
Caller[00000000004e5f94]: remove_inode_buffers+0x34/0xc0
Caller[00000000004d863c]: shrink_icache_memory+0x1fc/0x2e0
Caller[00000000004a29cc]: shrink_slab+0x16c/0x200
Caller[00000000004a2df8]: kswapd+0x398/0x5a0
Caller[000000000047381c]: kthread+0x3c/0x80
Caller[0000000000427010]: kernel_thread+0x30/0x60
Caller[0000000000473b10]: kthreadd+0x170/0x200
Instruction DUMP: 01000000  2ace408c  c25e0000 <e65e2008> 22c4c089  c25e000=
0  f20524b8  80a6602f  184000da=20
note: kswapd0[156] exited with preempt_count 1
BUG: sleeping function called from invalid context at /home/mako/linux/lkt/=
sources/linux-2.6/kernel/nsproxy.c:217
in_atomic(): 1, irqs_disabled(): 0, pid: 156, name: kswapd0
INFO: lockdep is turned off.
Call Trace:
 [0000000000453654] __might_sleep+0xd4/0x120
 [000000000047814c] switch_task_namespaces+0xc/0x60
 [00000000004781a8] exit_task_namespaces+0x8/0x20
 [000000000046010c] do_exit+0x4ec/0x8a0
 [0000000000429190] die_if_kernel+0x150/0x300
 [0000000000445030] unhandled_fault+0x70/0xe0
 [00000000004452f8] do_sparc64_fault+0x1d8/0x5c0
 [000000000040796c] sparc64_realfault_common+0x10/0x20
 [0000000000480094] __lock_acquire+0x34/0xb00
 [0000000000481c04] lock_acquire+0x44/0x60
 [00000000006c25e4] _spin_lock+0x24/0x40
 [00000000004e5f94] remove_inode_buffers+0x34/0xc0
 [00000000004d863c] shrink_icache_memory+0x1fc/0x2e0
 [00000000004a29cc] shrink_slab+0x16c/0x200
 [00000000004a2df8] kswapd+0x398/0x5a0
 [000000000047381c] kthread+0x3c/0x80


So (in reverse order) with gdb we get some more information:

(gdb) l *shrink_icache_memory+0x1fc
0x4d863c is in shrink_icache_memory (/home/mako/linux/lkt/sources/linux-2.6=
/fs/inode.c:430).
425                             continue;
426                     }
427                     if (inode_has_buffers(inode) || inode->i_data.nrpag=
es) {
428                             __iget(inode);
429                             spin_unlock(&inode_lock);
430                             if (remove_inode_buffers(inode))
431                                     reap +=3D invalidate_mapping_pages(=
&inode->i_data,
432                                                                     0, =
-1);
433                             iput(inode);
434                             spin_lock(&inode_lock);
(gdb) l *remove_inode_buffers+0x34
0x4e5f94 is in remove_inode_buffers (/home/mako/linux/lkt/sources/linux-2.6=
/fs/buffer.c:898).
893             if (inode_has_buffers(inode)) {
894                     struct address_space *mapping =3D &inode->i_data;
895                     struct list_head *list =3D &mapping->private_list;
896                     struct address_space *buffer_mapping =3D mapping->a=
ssoc_mapping;
897    =20
898                     spin_lock(&buffer_mapping->private_lock);
899                     while (!list_empty(list)) {
900                             struct buffer_head *bh =3D BH_ENTRY(list->n=
ext);
901                             if (buffer_dirty(bh)) {
902                                     ret =3D 0;
(gdb) l *_spin_lock+0x24=20
0x6c25e4 is in _spin_lock (/home/mako/linux/lkt/sources/linux-2.6/kernel/sp=
inlock.c:180).
175     EXPORT_SYMBOL(_write_lock_bh);
176    =20
177     void __lockfunc _spin_lock(spinlock_t *lock)
178     {
179             preempt_disable();
180             spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
181             LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
182     }
183    =20
184     EXPORT_SYMBOL(_spin_lock);
(gdb) l *lock_acquire+0x44
0x481c04 is in lock_acquire (/home/mako/linux/lkt/sources/linux-2.6/kernel/=
lockdep.c:2941).
2936   =20
2937            raw_local_irq_save(flags);
2938            check_flags(flags);
2939   =20
2940            current->lockdep_recursion =3D 1;
2941            __lock_acquire(lock, subclass, trylock, read, check,
2942                           irqs_disabled_flags(flags), nest_lock, ip);
2943            current->lockdep_recursion =3D 0;
2944            raw_local_irq_restore(flags);
2945    }
(gdb) l *__lock_acquire+0x34
0x480094 is in __lock_acquire (/home/mako/linux/lkt/sources/linux-2.6/kerne=
l/lockdep.c:2546).
2541                    printk("turning off the locking correctness validat=
or.\n");
2542                    return 0;
2543            }
2544   =20
2545            if (!subclass)
2546                    class =3D lock->class_cache; <---- boom
2547            /*
2548             * Not cached yet or subclass?
2549             */
2550            if (unlikely(!class)) {



Hm... and there are processess hanging in uninteruptible sleep:
This would be the bash in which i run echo 3 > /proc/sys/vm/drop_caches

bash          D 00000000004d84a0     0 17499      1
Call Trace:
 [00000000006c0a70] mutex_lock_nested+0x110/0x320
 [00000000004d84a0] shrink_icache_memory+0x60/0x2e0
 [00000000004a29cc] shrink_slab+0x16c/0x200
 [00000000004e2a6c] drop_caches_sysctl_handler+0x4c/0x220
 [000000000050f998] proc_sys_call_handler+0x78/0xa0
 [000000000050f9d4] proc_sys_write+0x14/0x40
 [00000000004c4bec] vfs_write+0x6c/0x120
 [00000000004c506c] sys_write+0x2c/0x60
 [0000000000406254] linux_sparc_syscall32+0x34/0x40


And this one would be sparc-unknown-gnu-linux-gcc compiler running from eme=
rge world.

sparc-unknown D 00000000004d84a0     0 16529      1
Call Trace:
 [00000000006c0a70] mutex_lock_nested+0x110/0x320
 [00000000004d84a0] shrink_icache_memory+0x60/0x2e0
 [00000000004a29cc] shrink_slab+0x16c/0x200
 [00000000004a3224] try_to_free_pages+0x224/0x360
 [000000000049ad54] __alloc_pages_internal+0x194/0x440
 [00000000004bfb9c] __slab_alloc+0x65c/0x720
 [00000000004bffbc] kmem_cache_alloc+0x9c/0xc0
 [00000000004449e8] tsb_grow+0x88/0x440
 [00000000004455dc] do_sparc64_fault+0x4bc/0x5c0
 [000000000040796c] sparc64_realfault_common+0x10/0x20


Both hang in the same place and it looks like fallout from the NULL pointer=
 dereference,
the thread that oopsed took iprune_mutex held with it.

# cat /proc/17499/wchan=20
shrink_icache_memory

# cat /proc/16529/wchan=20
shrink_icache_memory


# cat /proc/17499/stat =20
17499 (bash) D 1 17499 17499 0 -1 4194560 776 2910 0 7 5 294 22 97 20 0 1 0=
 1878410 3874816 267 18446744073709551615 65536 872296 4289715792 428971378=
4 4158566936 0 0 3293188 2072526587 5080224 0 0 20 0 0 0 0 0 0

# cat /proc/16529/stat =20
16529 (sparc-unknown-l) D 1 21719 4519 34818 4519 4196608 701 0 0 0 2 10 0 =
0 20 0 1 0 1966196 5201920 385 18446744073709551615 65536 404580 4292198832=
 4292198184 1880286944 0 0 16777216 0 5080224 0 0 20 2 0 0 0 0 0

5080224 -> 0x4D84A0

and that falls somewhere within shrink_icache_memory()

# grep shrink_icache /proc/kallsyms -A1
00000000004d8440 t shrink_icache_memory
00000000004d8720 T inode_init_once

offset is 0x4D84A0 - 0x4d8440 =3D 0x60
and that points to:

(gdb) l *shrink_icache_memory+0x60
0x4d84a0 is in shrink_icache_memory (/home/mako/linux/lkt/sources/linux-2.6=
/fs/inode.c:413).
408             LIST_HEAD(freeable);
409             int nr_pruned =3D 0;
410             int nr_scanned;
411             unsigned long reap =3D 0;
412    =20
413             mutex_lock(&iprune_mutex); <---- here
414             spin_lock(&inode_lock);
415             for (nr_scanned =3D 0; nr_scanned < nr_to_scan; nr_scanned+=
+) {
416                     struct inode *inode;
417    =20

I'm not an expert but it seems that the corruption happens to random memory=
 areas
and thus the system dies in many different wonderful ways ;) Alhough this m=
ight
be just a coincidence.

Hope that helps,

	Mariusz
