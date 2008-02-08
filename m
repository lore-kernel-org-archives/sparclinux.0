From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 08 Feb 2008 11:05:43 +0000
Subject: Re: gcc 4.2 or kernel bug ?
Message-Id: <47AC3787.9030607@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <47AC34B6.4000302@systella.fr>
In-Reply-To: <47AC34B6.4000302@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl wrote:
>     Hello,
>=20
>     On a U60 SMP running debian/testing, 2.6.24 kernel, I can seen in=20
> dmesg :
>=20
> Mem-info:
> Normal per-cpu:
> CPU    0: Hot: hi:   90, btch:  15 usd:  56   Cold: hi:   30, btch:   7=20
> usd:  23
> CPU    2: Hot: hi:   90, btch:  15 usd:   0   Cold: hi:   30, btch:   7=20
> usd:   0
> Active:98801 inactive:19262 dirty:68 writeback:0 unstable:0
>  free:530 slab:3845 mapped:6871 pagetables:553 bounce:0
> Normal free:4104kB min:4040kB low:5048kB high:6056kB active:790408kB=20
> inactive:15
> 4096kB present:1023992kB pages_scanned:33 all_unreclaimable? no
> lowmem_reserve[]: 0 0
> Normal: 449*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB=20
> 0*2048kB 0
> *4096kB 0*8192kB =3D 4088kB
> Swap cache: add 150320, delete 132225, find 212550/233466, race 0+1
> Free swap  =3D 1682128kB
> Total swap =3D 1951792kB
> Free swap:       1682128kB
> 360340 pages of RAM
> 233704 reserved pages
> 41539 pages shared
> 18049 pages swap cached
> 68 pages dirty
> 0 pages writeback
> 6871 pages mapped
> 3845 pages slab
> 553 pages pagetables
> swapper: page allocation failure. order:1, mode:0x4020
> Call Trace:
>  [00000000004b67e0] __slab_alloc+0x248/0x660
>  [00000000004b8c00] __kmalloc_track_caller+0xe8/0x100
>  [0000000000634b20] __alloc_skb+0x48/0x100
>  [00000000005b662c] happy_meal_rx+0x114/0x420
>  [00000000005b7954] happy_meal_interrupt+0x7c/0xe0
>  [000000000048efcc] handle_IRQ_event+0x34/0xa0
>  [0000000000490a38] handle_fasteoi_irq+0xa0/0x140
>  [000000000042ef48] handler_irq+0x90/0xc0
>  [00000000004208b4] tl0_irq5+0x1c/0x20
>  [0000000000474108] __rcu_process_callbacks+0x90/0x280
>  [0000000000474318] rcu_process_callbacks+0x20/0x40
>  [00000000004667d4] tasklet_action+0x7c/0x160
>  [0000000000466054] __do_softirq+0xbc/0x100
>  [00000000004660fc] do_softirq+0x64/0x80
>  [0000000000432ae8] timer_interrupt+0x90/0x100
>  [00000000004209d4] tl0_irq14+0x1c/0x20
>=20
>     Running kernel was build with gcc 4.2. Can 2.6.24 kernel be built=20
> with this release of gcc ?

	Same constatation on U2/SMP. On a 32-threads T1000, I obtain :
BUG: soft lockup - CPU#1 stuck for 11s! [md2_raid1:2736]
TSTATE: 0000000080001600 TPC: 00000000005580c8 TNPC: 00000000005580cc Y:=20
00000000    Not tainted
TPC: <loop+0xc/0x28>
g0: fffff800ed5e61e0 g1: 8ffa70d1c0000000 g2: 00058f2321a38000 g3:=20
0000000000000000
g4: fffff800f9779b60 g5: fffff80000492000 g6: fffff800f7f64000 g7:=20
0000000000000000
o0: fffff800ed1cd41e o1: fffff800ed32741e o2: 0000000000000be2 o3:=20
0000000000000000
o4: 1ffa715380000000 o5: 00058ea162a70000 sp: fffff800f7f67381 ret_pc:=20
00000000005e704c
RPC: <raid1d+0x9b4/0xfc0>
l0: fffff800ed766be0 l1: 0000000000000040 l2: 0000000000000005 l3:=20
0000000000000008
l4: fffff800f452f6e0 l5: fffff800f82e72e0 l6: 0000000000000001 l7:=20
0000000000000080
i0: fffff800f79aa000 i1: 0000000000000002 i2: fffff80000000000 i3:=20
fffff800efca19e0
i4: 00000000005e7e00 i5: 0000000000000010 i6: fffff800f7f674f1 i7:=20
00000000005f28d8
I7: <md_thread+0x40/0x140>
md: md2: data-check done.

	I'm not sure that both constatations come from the same bug.

	Regards,

	JKB
