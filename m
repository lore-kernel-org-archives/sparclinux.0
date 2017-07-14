From: Meelis Roos <mroos@linux.ee>
Date: Fri, 14 Jul 2017 11:11:33 +0000
Subject: Re: Trying out debian sparc64
Message-Id: <alpine.LRH.2.20.1707141406060.3086@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> I agree that this is a problem, there is actually a technical reason
> for that which is the fact that the bootloader (or was it the
> firmware?) is choking on the size of the installer image.
>=20
> I did create some images for testing:
>=20
> > https://people.debian.org/~glaubitz/netboot/

Will try, thanks!

> This is the new standard debian-installer which uses GNU screen when
> installing over a serial terminal. I was sure there were hints on how
> to switch between the terminals. It's an improvement over the previous
> design as you couldn't switch terminals over a serial connection at
> all.

Yes, screen keybindings do work, this is useful.

> > * Installer still tells ext4 is unsupported for silo, that should not b=
e=20
> >   a problem for years now?

Actually, I may have hit a problem with silo - silos is not fining any=20
files, no /etc/silo.conf, no /boon/vmlinuz or any other file.

Comparing filesystem features - the news fs has 64bit and metadata_csum=20
features that my working ext4 filesystems do not have. Will make more=20
test to see if these are related.

> SILO is being phased out and replaced with GRUB anyway. The reason why
> we're still defaulting to SILO and not GRUB is because not all patches
> by Eric Snowberg have been merged upstream yet and are hence part of
> the package.
>=20
> See: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=854568

Should it work on any sparc64?

> > * Installer asks for mirror and there is no good information on the=20
> > wiki. I derived host =3D deb.debian.org and directory =3D /debian-ports=
 and=20
> > it started downloading so seems correct.
>=20
> This is an issue with choose-mirror from debian-installer which does
> not officially support Debian Ports at the moment.

I added the key manually with apt-key add - and got past that step.

> > So it seems the installer does not have relevant PGP key for this repo.
> >=20
> > Am I using wrong repo? Should I add some PGP key manually? Or is the=20
> > March installer out of date with respect to current PGP keys after=20
> > stretch was released?
>=20
> This was an issue in debian-cd and has been fixed:
>=20
> > https://.debian.org/plugins/scmgit/cgi-bin/gitweb.cgi?p=DEbian-cd/debia=
n-cd.git;a=3Dcommit;h=B6c7df147ab61ae42d97610b78e8480cb8b81e00

No actual hostname int he URL?

--=20
Meelis Roos (mroos@linux.ee)
