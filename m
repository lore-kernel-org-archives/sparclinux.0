From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Mon, 15 Aug 2011 15:21:02 +0000
Subject: About ARCH=sparc and what to pass to recordmcount.pl
Message-Id: <20110815152102.GK11398@pengutronix.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello,

when I enable CONFIG_FUNCTION_TRACER and CONFIG_DYNAMIC_FTRACE for the
Debian kernel the build fails with:

  CC      init/do_mounts_initrd.o
Arch sparc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at .../scripts=
/recordmcount.pl line 368.

This happens because the kernel package build scripts call

	make ARCH=3Dsparc

$(ARCH) is passed to scripts/recordmcount.pl and the latter only knows
about "sparc64".

There are several options to fix that:

 a) let the package pass ARCH=3Dsparc64 instead of ARCH=3Dsparc
    Then sparc would be the only architecture that doesn't pass the
    (Debian) arch here. I'm not sure there are other reasons to stick to
    ARCH=3Dsparc. Bastian?
    It seems only recordmcount.pl chokes on that because Debian uses
    ARCH=3Dsparc since at least 2.6.32, probably much longer.

 b) pass SRCARCH instead of ARCH to recordmcount.pl and do
    s/sparc64/sparc/ in recordmcount.pl.

 c) do the following in recordmcount.pl:
	if ($arch =3D~ /sparc(32|64)?/) {
	    if ($bits =3D 64) {
	        $arch =3D "sparc64";
	    } else {
	        $arch =3D "sparc"; # or "sparc32"?
	    }
	}

    Something like that is already done for x86.
=20
Personally I prefer b), but I'm not sure I see all the consequences.

What do you think?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
