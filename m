From: Meelis Roos <mroos@linux.ee>
Date: Wed, 18 Apr 2018 21:34:33 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <alpine.LRH.2.21.1804190032380.12593@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> On my Ultra 30 I get some BUG printk in dmesg:
>=20
> [    0.000145] PROMLIB: Sun IEEE Boot Prom 'OBP 3.9.5 1997/04/11 10:03'
> [    0.000168] PROMLIB: Root node compatible:=20
> [    0.000251] Linux version 4.16.2-dist (root@somewhere.exactcode.de) > =
(gcc version 5.3.0 (GCC)) #1 SMP Tue Apr 17 08:21:44 Local time zone > must=
 be set--see zic=20
> [    0.000828] bootconsole [earlyprom0] enabled
> [    0.000835] ARCH: SUN4U
> =85
> [ 3290.076290] BUG: Bad rss-counter state mm:00000000e37e5ba7 idx:1 > val=
:1
> [ 3290.080937] BUG: non-zero pgtables_bytes on freeing mm: 8192

Turn off Transparent Hugepages in kernel configuration - they are known=20
to cause this. I turned it off on all my sparc64 machines and crashes=20
like that are gone.

--=20
Meelis Roos (mroos@linux.ee)
