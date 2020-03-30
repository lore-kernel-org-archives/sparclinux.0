From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 30 Mar 2020 10:18:07 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <1ce66ac3-17cf-0b74-8111-ae0b917e65b3@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Rolf!

On 3/30/20 10:41 AM, Rolf Eike Beer wrote:
> I run a 32 bit Gentoo userspace on my T5120 with a 64 bit kernel (5.5.7 a=
t the=20
> moment). This is nothing really new, I see this for a while, but it seems=
 to=20
> got a bit worse lately.

Debian's glibc maintainer told me that the glibc testsuite on SPARC has mor=
e failures
on 32-bit than on 64-bit. Maybe we should look into trying to get some of t=
hese failures
fixed first. CC'ing Adhemerval from glibc upstream who has done a lot of bu=
g fixing
on SPARC in glibc.

It could be useful in this context if Gentoo could provide a small Gentoo S=
PARC LDOM
running 32-bit userland for the GCC Compile Farm. This way upstream develop=
ers get
easy access to a Gentoo SPARC instance to be able to reproduce issues like =
this.

> When I read about https://sourceware.org/git/?
> p=3Dglibc.git;a=3Dcommit;h=B33e946fbb1659d2c5937c4dd756a7c49a132dff I tho=
ught that=20
> this may solve the issue, but I rebuild my glibc in a chroot with that pa=
tch=20
> and at least the fish testsuite hangs are unchanged.
>=20
> Has anyone a clue what's going on there?
I know that there have been some stability issues with the Linux kernel on =
SPARC
with older hardware like the UltraSPARC IIIi. The T5120 we have and newer m=
achines
seem to run relatively fine with a 64-bit userland.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
