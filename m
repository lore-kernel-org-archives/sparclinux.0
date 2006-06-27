From: Will Simoneau <simoneau@ele.uri.edu>
Date: Tue, 27 Jun 2006 19:28:56 +0000
Subject: Re: 2.6.17 + sym53c876 causes many i/o errors
Message-Id: <20060627192856.GA12663@ele.uri.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
List-Id: <sparclinux.vger.kernel.org>
References: <20060620175656.GA12525@ele.uri.edu>
In-Reply-To: <20060620175656.GA12525@ele.uri.edu>
To: sparclinux@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13:39 Mon 26 Jun     , David Miller wrote:
> From: Will Simoneau <simoneau@ele.uri.edu>
> Date: Mon, 26 Jun 2006 15:46:11 -0400
>=20
> > Just an update: 2.6.17.1 had the same problem until I changed both the
> > max # and default # of tagged queue commands to 64 instead of 256 like I
> > had them. The doc file for the driver seems to indicate that at most 255
> > tagged queue commands are supported, but the help text in 'make
> > menuconfig' indicates that up to 256 are supported. Maybe setting it to
> > 256 causes badness in the driver?
> >=20
> > Anyway, 2.6.17.1 is fine on this machine now.
>=20
> If that's the theory, try setting it to 255 and see if that works.
>=20
> If it does, then the configuration system should not let you set
> 256 or higher if that value is illegal.

I just tried setting both parameters to 255 and I still get I/O errors.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEoYb4LYBaX8VDLLURAjS1AJsGRNZOoW8tsqqRzH5LDyUoNxKAvQCfVSee
W7+ppYpFEcBNzPEKtpd7nMY=
=Hunl
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
