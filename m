From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Wed, 11 Apr 2007 02:41:20 +0000
Subject: Re: Build error : 2.6.21-rc6-mm1 on sparc64
Message-Id: <20070411024120.GA26931@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20070411004838.GD15262@Krystal> <20070410181854.7d532c59.akpm@linux-foundation.org> <1176257739.19452.13.camel@sebastian.intellilink.co.jp> <20070410193429.ffbfa33c.akpm@linux-foundation.org>
In-Reply-To: <20070410193429.ffbfa33c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

* Andrew Morton (akpm@linux-foundation.org) wrote:
> On Wed, 11 Apr 2007 11:15:39 +0900 Fernando Luis V=E1zquez Cao <fernando@=
oss.ntt.co.jp> wrote:
>=20
> > The problem is that to use hard_smp_processor_id in UP kernels just
> > including linux/smp.h does not suffice anymore. Now
> > hard_smp_processor_id is architecture specific code and consequently
> > asm/smp.h should be included explicitly.
>=20
> yeah.  The fact that linux/smp.h only exposes asm/smp.h if CONFIG_SMP hits
> us again and again and again.  It would be good to fix that up, I guess by
> including asm/smp.h unconditionally from within linux/smp.h.
>=20
> But that's a separate little project.
>=20
> > Mathieu, does the (untested) patch below fix this issue?
>=20

With this patch, sparc64 builds correctly. Thanks!


> I'll test it.
>=20

--=20
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
