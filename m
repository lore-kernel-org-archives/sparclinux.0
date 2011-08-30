From: Ryan <dreadlocks@gmail.com>
Date: Tue, 30 Aug 2011 01:24:04 +0000
Subject: Re: 3.0.3 on V120 Panic
Message-Id: <4E061F4B-C886-45E2-A3E7-058677F59C0C@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_B1EF2607-1C92-4124-90C1-FEFEC920A42B"
List-Id: <sparclinux.vger.kernel.org>
References: <D5A65271-7B45-4B76-AC73-A4F140F1FB11@nayr.net>
In-Reply-To: <D5A65271-7B45-4B76-AC73-A4F140F1FB11@nayr.net>
To: sparclinux@vger.kernel.org


--Apple-Mail=_B1EF2607-1C92-4124-90C1-FEFEC920A42B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Just built against 3.0.4 and encountered same issue..=20

On Aug 29, 2011, at 4:58 PM, Ryan wrote:

> Built latest stable kernel and it works perfectly fine on a SunFire =
T1000, tried to install the same kernel on a V120 and this is the result =
from boot:
>=20
>=20
> [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.18.5 2005/10/21 =
17:55'
> [    0.000000] PROMLIB: Root node compatible:=20
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.0.3-websvs2 (root@websvs1) (gcc version =
4.4.5 (Debian 4.4.5-8) ) #1 SMP Mon Aug 29 15:33:23 MDT 2011
> [    0.000000] bootconsole [earlyprom0] enabled
> [    0.000000] ARCH: SUN4U
> [    0.000000] Ethernet address: 00:14:4f:4d:94:45
> [    0.000000] Kernel: Using 2 locked TLB entries for main kernel =
image.
> [    0.000000] Remapping the kernel... done.
> [    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
> [    0.000000] PROM: Built device tree with 81100 bytes of memory.
> [    0.000000] Top of RAM: 0x123feee000, Total RAM: 0xffea8000
> [    0.000000] Memory hole size: 70656MB
> [    0.000000] [0000010000000000-fffff80000400000] page_structs=3D131072=
 node=3D0 entry=3D0/8192
> [    0.000000] [0000010000000000-fffff80000800000] page_structs=3D131072=
 node=3D0 entry=3D1/8192
> [    0.000000] [0000010004000000-fffff80000c00000] page_structs=3D131072=
 node=3D0 entry=3D16/8192
> [    0.000000] [0000010004000000-fffff80001000000] page_structs=3D131072=
 node=3D0 entry=3D17/8192
> [    0.000000] [0000010020000000-fffff80001400000] page_structs=3D131072=
 node=3D0 entry=3D128/8192
> [    0.000000] [0000010020000000-fffff80001800000] page_structs=3D131072=
 node=3D0 entry=3D129/8192
> [    0.000000] [0000010024000000-fffff80001c00000] page_structs=3D131072=
 node=3D0 entry=3D144/8192
> [    0.000000] [0000010024000000-fffff80002000000] page_structs=3D131072=
 node=3D0 entry=3D145/8192
> [    0.000000] Zone PFN ranges:
> [    0.000000]   Normal   0x00000000 -> 0x0091ff77
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[8] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x00020000
> [    0.000000]     0: 0x00100000 -> 0x00120000
> [    0.000000]     0: 0x00800000 -> 0x00820000
> [    0.000000]     0: 0x00900000 -> 0x0091f7ff
> [    0.000000]     0: 0x0091f800 -> 0x0091ff48
> [    0.000000]     0: 0x0091ff50 -> 0x0091ff58
> [    0.000000]     0: 0x0091ff70 -> 0x0091ff74
> [    0.000000]     0: 0x0091ff76 -> 0x0091ff77
> [    0.000000] Booting Linux...
> [    0.000000] CPU CAPS: =
[flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
> [    0.000000] CPU CAPS: [v8plus,popc,vis,vis2]
> [    0.000000]               \|/ ____ \|/
> [    0.000000]               "@'/ .. \`@"
> [    0.000000]               /_| \__/ |_\
> [    0.000000]                  \__U_/
> [    0.000000] swapper(0): Kernel illegal instruction [#1]
> [    0.000000] TSTATE: 0000001180e01605 TPC: 00000000005b7b20 TNPC: =
00000000005b7b24 Y: 00000000    Not tainted
> [    0.000000] TPC: <__ffs+0x8/0x88>
> [    0.000000] g0: 000000000080b351 g1: 0000000000040000 g2: =
fffff8003fedc008 g3: 000000000003ffe1
> [    0.000000] g4: 0000000000822890 g5: 0000000000000000 g6: =
0000000000808000 g7: 00000000003d3130
> [    0.000000] o0: fffffffffffc0000 o1: 000000000007ffff o2: =
ffffffffffffffff o3: 000000000080be48
> [    0.000000] o4: 00000000008bc228 o5: 0000000000000000 sp: =
000000000080b3b1 ret_pc: 00000000005a720c
> [    0.000000] RPC: <find_next_zero_bit+0xa4/0xb8>
> [    0.000000] l0: 0000000000000000 l1: 0000000000000a37 l2: =
000000000082b8c8 l3: 0000000000000a35
> [    0.000000] l4: fffffffffffff5c9 l5: 000000000000000e l6: =
000000000082b884 l7: 000000000082b890
> [    0.000000] i0: fffff8003fedc000 i1: 000000000091ff77 i2: =
ffffffffffffffee i3: 000000000082b8c8
> [    0.000000] i4: 00000000008bc130 i5: 00000000008bc150 i6: =
000000000080b461 i7: 000000000086da40
> [    0.000000] I7: <alloc_bootmem_core+0x188/0x314>
> [    0.000000] Call Trace:
> [    0.000000]  [000000000086da40] alloc_bootmem_core+0x188/0x314
> [    0.000000]  [000000000086dc48] ___alloc_bootmem_nopanic+0x7c/0xc0
> [    0.000000]  [000000000086dfe0] ___alloc_bootmem+0x10/0x44
> [    0.000000]  [000000000085e584] start_kernel+0x9c/0x39c
> [    0.000000]  [00000000007121c8] tlb_fixup_done+0x98/0xa0
> [    0.000000]  [0000000000000000]           (null)
> [    0.000000] Disabling lock debugging due to kernel taint
> [    0.000000] Caller[000000000086da40]: =
alloc_bootmem_core+0x188/0x314
> [    0.000000] Caller[000000000086dc48]: =
___alloc_bootmem_nopanic+0x7c/0xc0
> [    0.000000] Caller[000000000086dfe0]: ___alloc_bootmem+0x10/0x44
> [    0.000000] Caller[000000000085e584]: start_kernel+0x9c/0x39c
> [    0.000000] Caller[00000000007121c8]: tlb_fixup_done+0x98/0xa0
> [    0.000000] Caller[0000000000000000]:           (null)
> [    0.000000] Instruction DUMP: 01000000  82200008  923a0001=20
> [    0.000000]  81c3e008  90222001  01000000  832a3030  85323010=20
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle =
task!
> [    0.000000] Call Trace:
> [    0.000000]  [00000000004687e0] do_exit+0xb4/0x774
> [    0.000000]  [0000000000427be8] die_if_kernel+0x29c/0x2c4
> [    0.000000]  [0000000000427e64] do_illegal_instruction+0x4c/0x170
> [    0.000000]  [0000000000420210] tl0_ill+0x10/0x20
> [    0.000000]  [00000000005b7b20] __ffs+0x8/0x88
> [    0.000000]  [000000000086da40] alloc_bootmem_core+0x188/0x314
> [    0.000000]  [000000000086dc48] ___alloc_bootmem_nopanic+0x7c/0xc0
> [    0.000000]  [000000000086dfe0] ___alloc_bootmem+0x10/0x44
> [    0.000000]  [000000000085e584] start_kernel+0x9c/0x39c
> [    0.000000]  [00000000007121c8] tlb_fixup_done+0x98/0xa0
> [    0.000000]  [0000000000000000]           (null)
> [    0.000000] Press Stop-A (L1-A) to return to the boot prom
>=20
>=20
>=20


--Apple-Mail=_B1EF2607-1C92-4124-90C1-FEFEC920A42B
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAk5cO7gACgkQIcAiq3SnceFOZQCfSEd53yk1PDWIMfuIVtjIChLo
dHkAoLECGnPv0nWSKPEjTWJt3zO42f8p
=mNtg
-----END PGP SIGNATURE-----

--Apple-Mail=_B1EF2607-1C92-4124-90C1-FEFEC920A42B--
