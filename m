From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Date: Wed, 18 Apr 2018 16:53:24 +0000
Subject: BUG: Bad rss-counter state ...
Message-Id: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

I recently dusted off some sparc systems, to help testing latest versions a=
nd such (https://www.youtube.com/watch?v=3D10q2OxHAzQ4&t=3D500s).

On my Ultra 30 I get some BUG printk in dmesg:

[    0.000145] PROMLIB: Sun IEEE Boot Prom 'OBP 3.9.5 1997/04/11 10:03'
[    0.000168] PROMLIB: Root node compatible:=20
[    0.000251] Linux version 4.16.2-dist (root@somewhere.exactcode.de) (gcc=
 version 5.3.0 (GCC)) #1 SMP Tue Apr 17 08:21:44 Local time zone must be se=
t--see zic=20
[    0.000828] bootconsole [earlyprom0] enabled
[    0.000835] ARCH: SUN4U
=85
[ 3290.076290] BUG: Bad rss-counter state mm:00000000e37e5ba7 idx:1 val:1
[ 3290.080937] BUG: non-zero pgtables_bytes on freeing mm: 8192



--=20
 Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 https://exactcode.com | https://t2sde.org | https://rene.rebe.de
