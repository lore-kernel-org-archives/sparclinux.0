From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 14 Jul 2017 09:21:04 +0000
Subject: Re: Trying out debian sparc64
Message-Id: <20170714092104.GA26530@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Meelis!

Thanks a lot for the feedback!

On Fri, Jul 14, 2017 at 11:45:23AM +0300, Meelis Roos wrote:
> I got my next machine, T5140, and decided to give sparc64 debian port a=20
> go. Here is my timeline of experiences.
>=20
> * There is still no netboot installer - this limits my testing since not =

>   all machines have a CD/DVD drive and my standard install here is=20
>   connect the cables, leave the cold room and do everything over the=20
>   network. The T5140 had a DVD driver fortunately, so I wrote a netinst=20
>   CD from 2017-03-24 and used that.

I agree that this is a problem, there is actually a technical reason
for that which is the fact that the bootloader (or was it the
firmware?) is choking on the size of the installer image.

I did create some images for testing:

> https://people.debian.org/~glaubitz/netboot/

> * The CD boots fine. Top of installer screen hints there is something=20
>   similar to virtual consoles but here is no hint how to use them on=20
>   serial console (if possible at all).

This is the new standard debian-installer which uses GNU screen when
installing over a serial terminal. I was sure there were hints on how
to switch between the terminals. It's an improvement over the previous
design as you couldn't switch terminals over a serial connection at
all.

> * Network setup is fine.

Good.

> * Installer does not create separate /boot any more, good!
>=20
> * Installer still tells ext4 is unsupported for silo, that should not be =

>   a problem for years now?

SILO is being phased out and replaced with GRUB anyway. The reason why
we're still defaulting to SILO and not GRUB is because not all patches
by Eric Snowberg have been merged upstream yet and are hence part of
the package.

See: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=854568

> * Initial debootstrap is fine.
>=20
> * Installer asks for mirror and there is no good information on the=20
> wiki. I derived host =3D deb.debian.org and directory =3D /debian-ports a=
nd=20
> it started downloading so seems correct.

This is an issue with choose-mirror from debian-installer which does
not officially support Debian Ports at the moment.

The source code of the package in question can be found here:

> https://anonscm.debian.org/cgit/d-i/choose-mirror.git/

> So it seems the installer does not have relevant PGP key for this repo.
>=20
> Am I using wrong repo? Should I add some PGP key manually? Or is the=20
> March installer out of date with respect to current PGP keys after=20
> stretch was released?

This was an issue in debian-cd and has been fixed:

> https://.debian.org/plugins/scmgit/cgi-bin/gitweb.cgi?p=DEbian-cd/debian-=
cd.git;a=3Dcommit;h=B6c7df147ab61ae42d97610b78e8480cb8b81e00

Once src:linux and src:debian-installer have been updated in unstable,
I will build new CD images where this issue has been resolved.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
