From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Date: Fri, 20 Apr 2018 13:25:47 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <BA4ABB3E-3196-457B-A57B-C67FE5BD60E5@exactcode.com>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On 19 Apr 2018, at 21:04, Ren=E9 Rebe <rene@exactcode.com> wrote:

> Hi,
>=20
> On 19 Apr 2018, at 19:21, John Paul Adrian Glaubitz <glaubitz@physik.fu-b=
erlin.de> wrote:
>=20
>> On 04/19/2018 05:41 PM, David Miller wrote:
>>> Then it could be pre-Ultra-IIIi systems that trigger the problem.
>>> Ultra30 is as such.
>>=20
>> Possible. But I haven't received any such bug report from Debian users
>> yet and we have people running the sparc64 port on machines as old
>> as the Ultra 10.
>>=20
>> Rene, would you mind testing Debian's sparc64 port on your machine?
>=20
> I would, however I realize this bug message does not reliably appear.
> (I should note the kernel continued to run further thru all the installat=
ion
> so for my first glance it was =93only=94 of cosmetic nature.)
> My thinking was to post it in case it ring a bell or remind someone of so=
mething.
>=20
> I will keep you posted what else I find, e.g. trying to mount a floppy on
> the Ultra 5 oopsed. Will double check and re-post details separately
> (unless someone warns me floppy support is known to be broken right
> now ;-)
>=20
> On the plus side: I could start latest xorg-server w/ sunffb driver, thou=
gh
> someone deleted the nice Mesa driver since the last time I turned it on,
> =85 :-/


For what it=92s worth it just occurred on my Ultra 5, being up some minutes=
, running
some larger svn up; or compiling something:

[    0.000151] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
[    0.000174] PROMLIB: Root node compatible:=20
[    0.000258] Linux version 4.16.2-dist (root@somewhere.exactco.de) (gcc v=
ersion 5.3.0 (GCC)) #1 SMP Tue Apr 17 08:21:44 Local time zone must be set-=
-see zic=20
[    0.040628] bootconsole [btext0] enabled
[    0.040655] ARCH: SUN4U
[    0.040837] Ethernet address: 08:00:20:13:de:ad
[    0.041214] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits =3D=3D =
40)
[    0.041227] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.041237] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.045556] Kernel: Using 2 locked TLB entries for main kernel image.
...
[  177.065984] internal=20
[  177.065992] transceiver at=20
[  177.066042] 100Mb/s, Full Duplex.
[  503.110890] eth0: Happy Meal receive FIFO overflow.
[  503.111079] eth0: Happy Meal receive FIFO overflow.
[  503.111354] eth0: Happy Meal receive FIFO overflow.
[  503.111578] eth0: Happy Meal receive FIFO overflow.
[  503.111850] eth0: Happy Meal receive FIFO overflow.
[ 1056.709749] BUG: Bad rss-counter state mm:000000000c3312a7 idx:1 val:2
[ 1056.710009] BUG: non-zero pgtables_bytes on freeing mm: 8192

The machine continues running =93fine=94, if there is anything to test let =
me know.
Maybe later the weekend or so I find the time to boot the debian image.

But given it occurs sporadically I currently have no way to reproduce this =
on demand anyways.

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de

