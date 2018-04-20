From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Date: Fri, 20 Apr 2018 15:38:19 +0000
Subject: Re: sparc64 floppy: error X while reading block 0, Oops
Message-Id: <1B833180-C684-4B88-BAE1-AEF62B6D5862@exactcode.com>
List-Id: <sparclinux.vger.kernel.org>
References: <C78BCB0E-4135-4B3C-928E-ACB04315A937@exactcode.com>
In-Reply-To: <C78BCB0E-4135-4B3C-928E-ACB04315A937@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello again,

On 20 Apr 2018, at 14:05, Ren=E9 Rebe <rene@exactcode.com> wrote:

> Hello everyone,
>=20
> continuing with sparc64 testing I made the mistake to insert a floppy int=
o my Ultra 5.
> Most likely the first time ever in the 10+ years I own it, =85
> I realize this is certainly of as low priority as it was for me the last =
decade, but maybe someone is interested nonetheless (or it just works in De=
bian ;-)
> I took the effort to connect another known good PC floppy (just to rule o=
ut hw failure) with the same result:

same with another 386/PC floppy, and both appear to test fine w/ OBDiag, =85
https://www.youtube.com/watch?v=3DkAAJG0UlRxU

	Ren=E9


> [    0.000260] Linux version 4.16.2-dist (root@somewhere.exactco.de) (gcc=
 version 5.3.0 (GCC)) #1 SMP Tue Apr 17 08:21:44 Local time zone must be se=
t--see zic=20
> ...
> [   87.347699] Floppy drive(s): fd0 is 1.44M
> [   87.365912] FDC 0 is a National Semiconductor PC87306
> [  110.396974] attempt to access beyond end of device
> [  110.397007] fd0: rw=3D0, want=3D16, limit=3D8
> [  110.397020] floppy: error 10 while reading block 0
> [  110.397050] Unable to handle kernel NULL pointer dereference
> [  110.408807] tsk->{mm,active_mm}->context =3D 00000000000003e1
> [  110.420546] tsk->{mm,active_mm}->pgd =3D fffff80000dac000
> [  110.432288]               \|/ ____ \|/
>                             "@'/ .. \`@"
>                             /_| \__/ |_\
>                                \__U_/
> [  110.432302] mount(676): Oops [#1]
> [  110.432329] CPU: 0 PID: 676 Comm: mount Not tainted 4.16.2-dist #1
> [  110.432347] TSTATE: 0000008011e01607 TPC: 000000000048d3e8 TNPC: 00000=
0000048d3ec Y: 13b0943e    Not tainted
> [  110.432392] TPC: <__wake_up_common+0x60/0x130>
> [  110.432407] g0: 0000000000000000 g1: 0000000000000000 g2: 000000000000=
0006 g3: 0000000000000000
> [  110.432422] g4: fffff80012379000 g5: fffff80016d8c000 g6: fffff80000ff=
0000 g7: 0000000000000006
> [  110.432435] o0: ffffffffffffffe8 o1: 0000000000000000 o2: 000000000000=
0000 o3: 0000000000000000
> [  110.432450] o4: 0000000000000026 o5: 0000000000000006 sp: fffff80000ff=
28d1 ret_pc: 00000000004a0100
> [  110.432471] RPC: <printk+0x20/0x30>
> [  110.432488] l0: 0000000000a9248a l1: fffff80000ff3638 l2: 000000000000=
0000 l3: 0000000000000000
> [  110.432503] l4: 0000000000a80e80 l5: 0000000000a86100 l6: 0000000000a1=
e400 l7: 0000000000a74180
> [  110.432517] i0: fffff80000ff3630 i1: 0000000000000003 i2: 000000000000=
0001 i3: 0000000000000000
> [  110.432532] i4: 0000000000000000 i5: 0000000000000000 i6: fffff80000ff=
2981 i7: 000000000048de2c
> [  110.432556] I7: <complete+0x34/0x44>
> [  110.432568] Call Trace:
> [  110.432593]  [000000000048de2c] complete+0x34/0x44
> [  110.432631]  [00000000006129bc] bio_endio+0x168/0x1ac
> [  110.432659]  [00000000006192ec] generic_make_request_checks+0x1e0/0x444
> [  110.432680]  [000000000061a894] generic_make_request+0x8/0x1f8
> [  110.432699]  [000000000061ab3c] submit_bio+0xb8/0x13c
> [  110.432763]  [000000001084ebc4] __floppy_read_block_0+0xb8/0x104 [flop=
py]
> [  110.432802]  [000000001084ee3c] floppy_revalidate+0x22c/0x2a0 [floppy]
> [  110.432829]  [00000000005ae4d8] check_disk_change+0x38/0x48
> [  110.432866]  [000000001084f6f0] floppy_open+0x338/0x3d8 [floppy]
> [  110.432887]  [00000000005aed58] __blkdev_get+0xc0/0x390
> [  110.432906]  [00000000005af0cc] blkdev_get+0xa4/0x2f8
> [  110.432942]  [00000000005776e8] do_dentry_open.isra.1+0x234/0x328
> [  110.432969]  [00000000005884a8] path_openat+0xbe8/0xdc0
> [  110.432989]  [00000000005886a4] do_filp_open+0x24/0x7c
> [  110.433007]  [000000000057875c] do_sys_open+0x164/0x208
> [  110.433037]  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
> [  110.433049] Disabling lock debugging due to kernel taint
> [  110.433080] Caller[000000000048de2c]: complete+0x34/0x44
> [  110.433107] Caller[00000000006129bc]: bio_endio+0x168/0x1ac
> [  110.433132] Caller[00000000006192ec]: generic_make_request_checks+0x1e=
0/0x444
> [  110.433154] Caller[000000000061a894]: generic_make_request+0x8/0x1f8
> [  110.433175] Caller[000000000061ab3c]: submit_bio+0xb8/0x13c
> [  110.433219] Caller[000000001084ebc4]: __floppy_read_block_0+0xb8/0x104=
 [floppy]
> [  110.433259] Caller[000000001084ee3c]: floppy_revalidate+0x22c/0x2a0 [f=
loppy]
> [  110.433281] Caller[00000000005ae4d8]: check_disk_change+0x38/0x48
> [  110.433320] Caller[000000001084f6f0]: floppy_open+0x338/0x3d8 [floppy]
> [  110.433342] Caller[00000000005aed58]: __blkdev_get+0xc0/0x390
> [  110.433362] Caller[00000000005af0cc]: blkdev_get+0xa4/0x2f8
> [  110.433389] Caller[00000000005776e8]: do_dentry_open.isra.1+0x234/0x328
> [  110.433412] Caller[00000000005884a8]: path_openat+0xbe8/0xdc0
> [  110.433433] Caller[00000000005886a4]: do_filp_open+0x24/0x7c
> [  110.433451] Caller[000000000057875c]: do_sys_open+0x164/0x208
> [  110.433475] Caller[00000000004061b4]: linux_sparc_syscall32+0x34/0x60
> [  110.433490] Caller[00000000f7f38840]: 0xf7f38840
> [  110.433498] Instruction DUMP:
> [  110.433507]  80a44001=20
> [  110.433515]  02600033=20
> [  110.433523]  a4102000=20
> [  110.433530] <e05a2018>
> [  110.433538]  a0043fe8=20
> [  110.433545]  82022018=20
> [  110.433553]  80a44001=20
> [  110.433560]  0260002e=20
> [  110.433567]  b010001a=20
>=20
>=20
> [  113.588299] floppy driver state
> [  113.588304] -------------------
> [  113.588388] now=3D4294920384 last interrupt=3D4294913827 diff=3D6557 l=
ast called handler=3Dreset_interrupt [floppy]
> [  113.588395] timeout_message=3Dlock fdc
> [  113.588400] last output bytes:
> [  113.588409]  0  0 0
> [  113.588417]  0  0 0
> [  113.588424]  0  0 0
> [  113.588433]  8 80 4294913827
> [  113.588441]  8 80 4294913827
> [  113.588450]  8 80 4294913827
> [  113.588459]  8 80 4294913827
> [  113.588467]  e 80 4294913827
> [  113.588476] 13 80 4294913827
> [  113.588485]  0 90 4294913827
> [  113.588493] 1a 90 4294913827
> [  113.588502]  0 90 4294913827
> [  113.588511] 12 80 4294913827
> [  113.588520]  0 90 4294913827
> [  113.588528] 14 80 4294913827
> [  113.588537] 18 80 4294913827
> [  113.588546]  8 80 4294913827
> [  113.588554]  8 80 4294913827
> [  113.588563]  8 80 4294913827
> [  113.588572]  8 80 4294913827
> [  113.588579] last result at 4294913827
> [  113.588586] last redo_fd_request at 4294913827
> [  113.588601] status=3D80
> [  113.588607] fdc_busy=3D1
> [  113.588616] cont=3D          (null)
> [  113.588624] current_req=3D          (null)
> [  113.588630] command_status=3D-1
>=20
> [  113.588655] floppy0: floppy timeout called
> [  113.588661] no cont in shutdown!
> [  113.588693] floppy0: floppy_shutdown: timeout handler died.=20
>=20
> --=20
> Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
> https://exactcode.com | https://t2sde.org | https://rene.rebe.de

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de

