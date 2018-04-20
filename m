From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Date: Fri, 20 Apr 2018 15:31:52 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <185C6CDE-C3D7-4386-A273-8EA773F7E207@exactcode.com>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On 20 Apr 2018, at 15:44, Ren=E9 Rebe <rene@exactcode.com> wrote:

> Speaking of =93updates=94, if you have a patch for that segfault, =85
> But today is your lucky, as my latest financing opensource work by YouTube
> videos (http://youtube.com/renerebe) shows some results, I now rebuild
> latest t2/svn:HEAD toolchain and re-build the Linux kernel for you (as
> the binutils/ld crash happened with glibc, I only need to toolchain for
> the kernel build):
>=20
> # scripts/Build-Target  -cfg sparc64 -job 0-binutils
> =3D=3D 13:34:33 =3D[0]=3D> Building develop/binutils [2.30 9.0-svn].
> # scripts/Build-Target  -cfg sparc64 -job 0-gcc=20
> =3D=3D 13:36:00 =3D[0]=3D> Building develop/gcc [7.3.0 9.0-svn].
> # scripts/Build-Target  -cfg sparc64 -job 1-linux
> =3D=3D 13:42:19 =3D[1]=3D> Building base/linux [4.16.3 9.0-svn].
>=20
> Waiting for the kernel to finish on my more Epyc CPU and then
> rsync and reboot. So maybe less than an hour or so ;-)

Did not change a thing, w/ GCC-7.3, latest Binutils 2.30, Ultra5:

[    0.000147] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
[    0.000173] PROMLIB: Root node compatible:=20
[    0.000260] Linux version 4.16.3-dist (root@builder.exactcode.de) (gcc v=
ersion 7.3.0 (GCC)) #1 SMP Fri Apr 20 13:44:06 Local time zone must be set-=
-see zic=20
[    0.040693] bootconsole [btext0] enabled
[    0.040723] ARCH: SUN4U
[    0.040915] Ethernet address: 08:00:20:13:de:ad
[    0.041302] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits =3D=3D =
40)
[    0.041314] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.041323] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.045674] Kernel: Using 2 locked TLB entries for main kernel image.
...
[   28.162995] random: crng init done
[   30.858246] BUG: Bad rss-counter state mm:000000003b665864 idx:1 val:1
[   30.858499] BUG: non-zero pgtables_bytes on freeing mm: 8192

Full disclosure:
a) this is a cross compiler, but that never mattered for me in the last dec=
ade (this is my fastest Sun @360MHz, =85)
b) this system is using btrfs, however, I think I initially repotted form t=
he Ultra30 wi/ only Ext3
c) this system has some non Sun PCI cards plugged, in, but again initially =
reported on the U30:

00:01.0 PCI bridge: Oracle/SUN Simba Advanced PCI Bridge (rev 13)
00:01.1 PCI bridge: Oracle/SUN Simba Advanced PCI Bridge (rev 13)
01:01.0 Bridge: Oracle/SUN EBUS (rev 01)
01:01.1 Ethernet controller: Oracle/SUN Happy Meal 10/100 Ethernet [hme] (r=
ev 01)
01:02.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] 3=
D Rage Pro PCI (rev 5c)
01:03.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 03)
02:01.0 SCSI storage controller: Adaptec AIC-7861 (rev 03)
02:02.0 RAID bus controller: Promise Technology, Inc. PDC20371 (FastTrak S1=
50 TX2plus) (rev 02)
02:03.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
02:03.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
02:03.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 0=
4)

As I said, the system does continue to run =93just fine=94 (as far as I can=
 see, so far), so for now this is cosmetic, and meant as =93heads up=94 inf=
ormal report, ...

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de
