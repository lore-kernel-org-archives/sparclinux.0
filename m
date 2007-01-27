From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 27 Jan 2007 04:28:11 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <1169872091.4809.66.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, 2007-01-26 at 21:42 -0600, Tom 'spot' Callaway wrote:
> On Fri, 2007-01-26 at 18:10 -0800, David Miller wrote:
> > From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
> > Date: Fri, 26 Jan 2007 16:15:30 -0600
> >=20
> > > Warning: unable to open an initial console.
> >=20
> > Enable PROM console, that should get you going at least
> > enough to boot into userspace, you won't be able to type
> > any input but it should get a /dev/console and be able to
> > thus boot past that point.
>=20
> Nope. In fact, it actually caused the kernel to die before I could get
> it to mount the NFS root:
>=20
> http://auroralinux.org/people/spot/e10k-dmesg-smp-promconsole.txt

Enabled all sorts of memory related debugging, and got this:

Console: mono PROM 80x34                                   =20
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)  =20
Memory: 2058328k available (1752k kernel code, 416k data, 152k init)
[fffff80000000000,000000007fcea000]
slab error in cache_alloc_debugcheck_after(): cache `size-512': double
free, or memory outside object was overwritten
Call Trace: [000000000047be28]  [000000000047c2cc]  [00000000006370fc]
[000000000062a62c]  [00000000004045c0]  [0000000000000000]=20
fffff8007fce6000: redzone 1:0x5a5a5a5a5a5a5a5a, redzone
2:0x170fc2a5             =20
slab error in cache_alloc_debugcheck_after(): cache `size-512': double
free, or memory outside object was overwritten
Call Trace: [000000000047be28]  [000000000047c2cc]  [00000000006370fc]
[000000000062a62c]  [00000000004045c0]  [0000000000000000]=20
fffff8007fce6000: redzone 1:0x5a5a5a5a5a5a5a5a, redzone
2:0x170fc2a5                                   =20
slab error in cache_alloc_debugcheck_after(): cache `size-512': double
free, or memory outside object was overwritten
Call Trace: [000000000047be28]  [000000000047c2cc]  [00000000006370fc]
[000000000062a62c]  [00000000004045c0]  [0000000000000000]=20
fffff8007fce6000: redzone 1:0x5a5a5a5a5a5a5a5a, redzone
2:0x170fc2a5             =20
slab error in cache_alloc_debugcheck_after(): cache `size-512': double
free, or memory outside object was overwritten
Call Trace: [000000000047be28]  [000000000047c2cc]  [00000000006370fc]
[000000000062a62c]  [00000000004045c0]  [0000000000000000]=20
fffff8007fce6000: redzone 1:0x5a5a5a5a5a5a5a5a, redzone
2:0x170fc2a5             =20
slab error in cache_alloc_debugcheck_after(): cache `size-512': double
free, or memory outside object was overwritten
Call Trace: [000000000047be28]  [000000000047c2cc]  [00000000006370fc]
[000000000062a62c]  [00000000004045c0]  [0000000000000000]=20
fffff8007fce6000: redzone 1:0x5a5a5a5a5a5a5a5a, redzone
2:0x170fc2a5               =20
slab error in cache_alloc_debugcheck_after(): cache `size-512': double
free, or memory outside object was overwritten
Call Trace: [000000000047be28]  [000000000047c2cc]  [00000000006370fc]
[000000000062a62c]  [00000000004045c0]  [0000000000000000]=20
fffff8007fce6000: redzone 1:0x5a5a5a5a5a5a5a5a, redzone
2:0x170fc2a5                =20
slab error in cache_alloc_debugcheck_after(): cache `size-512': double
free, or memory outside object was overwritten
Call Trace: [000000000047be28]  [000000000047c2cc]  [00000000006370fc]
[000000000062a62c]  [00000000004045c0]  [0000000000000000]=20
fffff8007fce6000: redzone 1:0x5a5a5a5a5a5a5a5a, redzone
2:0x170fc2a5          =1B[7          =03=C3=BE                             =
  =20
slab error in cache_alloc_debugcheck_after(): cache `size-512': double
free, or memory outside object was overwritten
Call Trace: [000000000047be28]  [000000000047c2cc]  [00000000006370fc]
[000000000062a62c]  [00000000004045c0]  [0000000000000000]=20
fffff8007fce6000: redzone 1:0x5a5a5a5a5a5a5a5a, redzone 2:0x170fc2a5
Unable to handle kernel paging request at virtual address
fffff803db27c000
tsk->{mm,active_mm}->context =3D 0000000000000000
tsk->{mm,active_mm}->pgd =3D fffff800002572d0
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\                                       =20
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000004480f01607 TPC: 000000000050ac50 TNPC: 000000000050ac54 Y:
00000000    Not tainted
g0: 00000000005e75d1 g1: 0000000000000018 g2: 0000000000000000 g3:
0000000000000001
g4: 00000000005e8400 g5: fffff80000e67a80 g6: 00000000005e4400 g7:
0000000000000060
o0: fffff8007fcc9f18 o1: fffff803db27d710 o2: 0000000000000000 o3:
fffffffca4a4c808
o4: fffff8007fcc9f18 o5: fffff8000028e0f8 sp: 00000000005e75e1 ret_pc:
000000000047b13c
l0: 000000000000000c l1: fffff8007fcc9ef0 l2: fffff800002866f8 l3:
fffff8007fcc7bf0
l4: 000000000000000c l5: fffff8000028853c l6: 0000000000000001 l7:
0000000000000010
i0: fffff8000028b700 i1: 00000000000000d0 i2: 0000000000000000 i3:
000000000047bdd8
i4: 0000000000000001 i5: fffff80000288538 i6: 00000000005e76a1 i7:
000000000047b998
Caller[000000000047b998]
Caller[000000000047bdd8]
Caller[000000000047bfbc]
Caller[000000000047c2cc]
Caller[00000000006370fc]
Caller[000000000062a62c]
Caller[00000000004045c0]
Caller[0000000000000000]
Instruction DUMP: 96220009  8e2aa00f  940aa00f <da5a6000> c25a6008
8ea1e010  da72400b  92026008  c272400b=20
Kernel panic - not syncing: Attempted to kill the idle task!
 <0>Press Stop-A (L1-A) to return to the boot prom


