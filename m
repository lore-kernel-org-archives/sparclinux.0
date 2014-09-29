From: Bob Picco <bpicco@meloft.net>
Date: Mon, 29 Sep 2014 22:35:22 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140929223522.GM4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:	[Mon Sep 29 2014, 05:33:17PM EDT]
> From: Bob Picco <bob.picco@oracle.com>
> Date: Mon, 29 Sep 2014 17:03:22 -0400
>=20
> > My local T4-2 and T5-2 seem solid for THP "always" and large kernel par=
allel
> > makes. I've seen no issues.
>=20
> Ok, how about the T5-8?  Does it at least boot properly with
> DEBUG_PAGEALLOC disabled?
>=20
Sorry family issue on top of work!

It would require time to get on this machine but not required.

This is debug from the T5-8 from a while ago:
From the next line=20
PERCPU: static=3D0x5d80 reserved=3D0x2000 dyn=3D0x6280 unit=3D0x10000
PERCPU: atom=3D0x400000 alloc=3D0x400000 __ai=3D0x2000 nr=3D8
PERCPU: group=3D0 ptr=3D0xffff803f5d000000 nid=3D0 nr_units=128 cpu=3D0
PERCPU: group=3D1 ptr=3D0xffff883f7f000000 nid=3D1 nr_units=128 cpu=128
PERCPU: group=3D2 ptr=3D0xffff903f7f000000 nid=3D2 nr_units=128 cpu%6
PERCPU: group=3D3 ptr=3D0xffff983f7f000000 nid=3D3 nr_units=128 cpu84
PERCPU: group=3D4 ptr=3D0xffffa03f7f000000 nid=3D4 nr_units=128 cpuQ2
PERCPU: group=3D5 ptr=3D0xffffa83f7f000000 nid=3D5 nr_units=128 cpud0
PERCPU: group=3D6 ptr=3D0xffffb03f7f000000 nid=3D6 nr_units=128 cpuv8
PERCPU: group=3D7 ptr=3D0xffffb83f5ec00000 nid=3D7 nr_units=128 cpu=896
PERCPU: base=3D0xffff803f5d000000
to the previous line is from percpu-debug.patch.
PERCPU: max_distance=3D0x380001c10000 too large for vmalloc space 0xff00000=
000
. So just subtract 0xffff800000000000UL from "ptr".

This from a SMI/Oracle hardware engineer and also contained within the
T5 hardware specification:
"But on T5 this has changed. Memory on T5 is spread out based on PA[45:43].=
 So,
that means same situation as above will see physical addresses as :"
.

This is current from my T5-2:
[    0.000000] MM: PAGE_OFFSET is 0xffff800000000000 (max_phys_bits =3D 47)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000400000000000]
[    0.000000] MM: VMEMMAP [0x0000400000000000 --> 0x0000800000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
...
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x30400000-0x1fef781fff]
[    0.000000]   node   0: [mem 0x1fef788000-0x1fef789fff]
[    0.000000]   node   1: [mem 0x80000000000-0x81ffff0ffff]
[    0.000000]   node   1: [mem 0x81ffff20000-0x81ffff43fff]

You can see the MCU increases linearly within bits positions PA[45:43] by
node. VMALLOC range is based on VMALLOC_END =3D (~PAGE_OFFSET + 1) >> 1;.
So it would seem to fail for T5-8. It indeed does for M7-4 but other
issues manifest too.

This is M7-4:
MM: PAGE_OFFSET is 0xfffe000000000000 (max_phys_bits =3D 49)^M
MM: VMALLOC [0x0000000100000000 --> 0x0001000000000000]^M
MM: VMEMMAP [0x0001000000000000 --> 0x0002000000000000]^M
Kernel: Using 3 locked TLB entries for main kernel image.^M
Remapping the kernel... done.^M
..
Early memory node ranges^M
  node   0: [mem 0x50400000-0x3fbf6bdfff]^M
  node   0: [mem 0x3fbf6c4000-0x3fbf6c5fff]^M
  node   1: [mem 0x400000000000-0x403bffffffff]^M
  node   2: [mem 0x800000000000-0x803fffffffff]^M
  node   3: [mem 0xc00000000000-0xc03fffd5dfff]^M
  node   3: [mem 0xc03fffd90000-0xc03fffdaffff]^M
  node   3: [mem 0xc03fffdc0000-0xc03fffdc3fff]^M
Booting Linux...^M
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]^M
CPU CAPS: [popc,vis,vis2,ASIBlkInit,fmaf,vis3,hpc,ima]^M
CPU CAPS: [pause,cbcond,aes,des,camellia,md5,sha1,sha256]^M
CPU CAPS: [sha512,mpmul,montmul,montsqr,crc32c]^M
PERCPU: max_distance=3D0xc000c2410000 too large for vmalloc space 0xffff000=
00000^M
PERCPU: auto allocator failed (-22), falling back to page size^M
PERCPU: 6 8K pages/cpu @0000000100000000 s23552 r8192 d17408^M

Let me look at this in the morning when NOT distracted by family issue.

thanx,

bob

