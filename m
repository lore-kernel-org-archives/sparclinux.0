From: Richard Braun <syn@sceen.net>
Date: Mon, 27 Mar 2006 06:41:07 +0000
Subject: Re: Sun Blade 100
Message-Id: <20060327064107.GA3209@sceen.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
List-Id: <sparclinux.vger.kernel.org>
References: <442762C4.8020104@home.tzo.org>
In-Reply-To: <442762C4.8020104@home.tzo.org>
To: sparclinux@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 26, 2006 at 10:57:56PM -0500, Anthony Gabrielson wrote:
> Hello,
>    I just wanted to see if anyone could put me to a distro that=20
> currently works with a Sun Blade 100.  Tried a few today, but the=20
> furthest I could get was Gentoo.  Having never installed Gentoo it seems=
=20
> a bit in depth, actually the redhat 3.x series seemed less difficult way=
=20
> back.  So, if anyone could point me in a good direction I would=20
> appreciate it.

I'm using both Debian sarge and Debian etch on several Sun Blade 100, using
a 2.6 kernel. The only problem you may really have is the freeze that
heppens when loading the IDE cdrom module. To avoid this, right after
kernel packages have been downloaded (if doing a netinstall), switch
to another terminal and add these lines to /etc/modules.conf :

alias ide-cd off
alias ide_cd off
alias cdrom off

When the installer will try autodetection, the cdrom will not be supported,
but your Sun Blade 100 won't freeze. After installation is done, and before
rebooting from the installer, mount the target file system (I don't
remember if it's still mounted at this point), and do the same thing
(the /etc/modules.conf file installed on the target file system is the
original one, so your system will freeze at the next reboot). You may need
to add those lines in /etc/modutils/aliases, but I'm not sure.

If you want to use XFree86/XOrg, look for Option "reference_clock" at [1].

--=20
Richard Braun

[1] http://www.de-brauwer.be/docs/debian_on_sun.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEJ4kDBlWsEPLYRi8RAm3vAJ40t0EEnHq22IUejZtchA4LDlu42QCgg08k
Cpyi67C5k0VCu+mH+pFD1xE=
=kX52
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
