From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 14 Jul 2017 11:19:06 +0000
Subject: Re: Trying out debian sparc64
Message-Id: <20170714111906.GC26530@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, Jul 14, 2017 at 02:11:33PM +0300, Meelis Roos wrote:
> > I agree that this is a problem, there is actually a technical reason
> > for that which is the fact that the bootloader (or was it the
> > firmware?) is choking on the size of the installer image.
> >=20
> > I did create some images for testing:
> >=20
> > > https://people.debian.org/~glaubitz/netboot/
>=20
> Will try, thanks!

There was discussion on the netboot images somewhere on the
debian-sparc mailing list, forgot where.

> > > * Installer still tells ext4 is unsupported for silo, that should not=
 be=20
> > >   a problem for years now?
>=20
> Actually, I may have hit a problem with silo - silos is not fining any=20
> files, no /etc/silo.conf, no /boon/vmlinuz or any other file.

Yeah, I usually create a separate /boot partition with 1 GiB to avoid
issues with SILO.

> Comparing filesystem features - the news fs has 64bit and metadata_csum=20
> features that my working ext4 filesystems do not have. Will make more=20
> test to see if these are related.
>=20
> > SILO is being phased out and replaced with GRUB anyway. The reason why
> > we're still defaulting to SILO and not GRUB is because not all patches
> > by Eric Snowberg have been merged upstream yet and are hence part of
> > the package.
> >=20
> > See: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=854568
>=20
> Should it work on any sparc64?

Currently all sun4v systems are officially supported. sun4u may work
as well, but are not officially supported. I think there were plans to
work on sun4u support in the future.

See: https://github.com/esnowberg/grub2-sparc/wiki

Here are grub2 Debian packages with Eric's sparc64 patches integrated:

> http://snapshot.debian.org/package/grub2/2.02%7Ebeta3-5%2Bsparc64/

Several users have reported success.

> > > So it seems the installer does not have relevant PGP key for this rep=
o.
> > >=20
> > > Am I using wrong repo? Should I add some PGP key manually? Or is the =

> > > March installer out of date with respect to current PGP keys after=20
> > > stretch was released?
> >=20
> > This was an issue in debian-cd and has been fixed:
> >=20
> > > https://.debian.org/plugins/scmgit/cgi-bin/gitweb.cgi?p=DEbian-cd/deb=
ian-cd.git;a=3Dcommit;h=B6c7df147ab61ae42d97610b78e8480cb8b81e00
>=20
> No actual hostname int he URL?

Oops. No idea how I managed to do that. Here's the full URL:

> https://alioth.debian.org/plugins/scmgit/cgi-bin/gitweb.cgi?p=DEbian-cd/d=
ebian-cd.git;a=3Dsummary

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
