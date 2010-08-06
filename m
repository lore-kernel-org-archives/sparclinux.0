From: Jon Bernard <jbernard@debian.org>
Date: Fri, 06 Aug 2010 00:13:29 +0000
Subject: Re: liburcu: debian sparc fail to configure
Message-Id: <20100806001327.GA1685@starquasia>
List-Id: <sparclinux.vger.kernel.org>
References: <20100805221352.GA30108@Krystal>
In-Reply-To: <20100805221352.GA30108@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> * Jon Bernard (jbernard@debian.org) wrote:
> > * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> > > Hi Jon,
> > >=20
> > > What's the cpuinfo spec of the build machine ?
> >=20
> > Here is the contents of /proc/cpuinfo:
> >=20
> >     cpu     : TI UltraSparc IIIi (Jalapeno)
>=20
> http://en.wikipedia.org/wiki/SPARC#SPARC_microprocessor_specifications
>=20
> UltraSPARC IIIi (Jalape=F1o)    ....   V9 / JPS1
>=20
> so it should be a sparcv9.
>=20
> Can you try a uname -a  to see which kernel version/architecture this
> is? I wonder if it's a 32 or 64-bit kernel.

Looks to be 64-bit:

    Linux lebrun 2.6.32-bpo.5-sparc64-smp #1 SMP Sat Jun 12 03:45:52 UTC 20=
10 sparc64 GNU/Linux

> You might also want to try modifying configure.ac to add:
>=20
>         sparc) ARCHTYPE=3D"sparc64" ;;
>=20
> below (or above)
>         sparc64) ARCHTYPE=3D"sparc64" ;;
>=20
> and try to build this (and run the library tests) on the machine to see
> if it works.

This /should/ work. Debian has dropped support for pre-v9 sparc
processors [1]. So regardless of wether autoconf detects sparc or
sparc64, setting ARCHTYPE=3D"sparc64" seems the right thing to do in this
case.

[1]: http://wiki.debian.org/Sparc64

J

> I suspect that this machine has a 32-bit kernel, hence the "sparc"
> rather than sparc64 host cpu. I'm not sure what's the best way to detect
> the machine type for these though, as really old sparcs before v9 will
> be tagged as "sparc". So basically, shipping the library with a distro
> targeting sparc64 is always fine, because these are v9+, but shipping
> the lib with a distro targeting old sparcs would be incorrect (at
> runtime) on these old machines. Now when the distro for old sparcs is
> deployed on the v9+ machines, then that works. So I really don't know
> what's the best approach there. Is the Linux kernel still supporting
> pre-v9 sparc boxes ?
>=20
> Thanks,
>=20
> Mathieu
>=20
> >     fpu     : UltraSparc IIIi integrated FPU
> >     pmu     : ultra3i
> >     prom        : OBP 4.11.4 2003/07/23 08:04
> >     type        : sun4u
> >     ncpus probed    : 2
> >     ncpus active    : 2
> >     D$ parity tl1   : 0
> >     I$ parity tl1   : 0
> >     Cpu0ClkTck  : 000000003bb94e80
> >     Cpu1ClkTck  : 000000003bb94e80
> >     MMU Type    : Cheetah+
> >     State:
> >     CPU0:       online
> >     CPU1:       online
> >=20
> > I belive sun4u means this is a pre-sparcv9 box, no?
> >=20
> > J
> >=20
> > >=20
> > > Basically, liburcu supports sparc starting from v9. Hopefully the bui=
ld
> > > machine you are trying to use is at least a v9.
> > >=20
> > > So yes, liburcu only recornises host "sparc64", not "sparc", because
> > > AFAIK all sparcv9+ are labeled "sparc64" rather than "sparc". But I
> > > might be wrong here. This is why having the cpuinfo information would=
 be
> > > helpful. Also knowing the kernel configuration might help.
> > >=20
> > > Usually, sparcv9+ are 64-bit Linux kernels with a 32-bit userland.
> > >=20
> > > Thanks,
> > >=20
> > > Mathieu
> > >=20
> > > * Pierre-Marc Fournier (pierre-marc.fournier@polymtl.ca) wrote:
> > > > As the maintainer of liburcu, Mathieu will be more able to help wit=
h =20
> > > > this than me. We do have a sparc machine in the lab. Maybe it will =
be =20
> > > > possible to reproduce the bug on it.
> > > >
> > > > pmf
> > > >
> > > > On 08/03/2010 05:39 PM, Jon Bernard wrote:
> > > >> Hey Pierre-Marc, I have a bug filled against liburcu in debian [1]=
 that
> > > >> fails to build and I am hoping you have an idea for this. The full=
 build
> > > >> log is here [2]. Unfortunately, the build daemon box that the build
> > > >> fails on is determined to be of host type 'sparc', but the porterb=
oxes
> > > >> that I have access to are determined to be of host type 'sparc64',=
 and
> > > >> so the build doesn't fail for me, only on the buildd machine ;) I =
cannot
> > > >> think of a way to duplicate this environment and so I thought you =
may
> > > >> have an idea. Any suggestions on this are much appreciated. If you=
 need
> > > >> any additional information, don't hesitate to ask.
> > > >>
> > > >> Cheers,
> > > >>
> > > >> J
> > > >>
> > > >> [1]: http://bugs.debian.org/cgi-bin/bugreport.cgi?bugX6543
> > > >> [2]: https://buildd.debian.org/fetch.cgi?pkg=3Dliburcu&arch=3Dspar=
c&ver=3D0.4.6-1&stamp=1277013595&file=3Dlog&as=3Draw
> > > >
> > >=20
> > > --=20
> > > Mathieu Desnoyers
> > > Operating System Efficiency R&D Consultant
> > > EfficiOS Inc.
> > > http://www.efficios.com
>=20
> --=20
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
