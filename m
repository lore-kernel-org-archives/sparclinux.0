From: Wiktor Wodecki <wodecki@gmx.de>
Date: Tue, 13 Jan 2004 20:46:54 +0000
Subject: Re: Status of Ross hyperSPARC on linux-2.4.x and linux-2.6.x?
Message-Id: <20040113204654.GD860@gmx.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
List-Id: <sparclinux.vger.kernel.org>
References: <20040113204206.A988@sparky.j-son.org>
In-Reply-To: <20040113204206.A988@sparky.j-son.org>
To: sparclinux@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2004 at 08:42:06PM +0100, christian@j-son.org wrote:
> Just a little ping for me (and anyone else).. what's the status of the
> linux kernels 2.4 and 2.6 for running Ross' hyperSPARC processors?

I have a quad hyperSparc ss10 running 2.4.25-pre4* and it is running
pretty well - From time to time it hangs, tho. The system watchdog
interrupts and the system goes back to OBP.

* with Ben's recent smp_mb additions

--=20
Regards,

Wiktor Wodecki

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFABFk+6SNaNRgsl4MRAvgaAJ0dqi6IqNrC8igNxU37nEd8Iyox3ACfZKMS
Hl0rAnPRU9ICypFMtIZfslE=
=GdHY
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
