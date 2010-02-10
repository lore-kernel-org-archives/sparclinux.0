From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 10 Feb 2010 19:59:00 +0000
Subject: Re: [PATCH] sparc: Align clone and signal stacks to 16 bytes.
Message-Id: <201002101359.18592.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart8677078.kdzu5DcuLC"
List-Id: <sparclinux.vger.kernel.org>
References: <20100209.165006.142022647.davem@davemloft.net>
In-Reply-To: <20100209.165006.142022647.davem@davemloft.net>
To: sparclinux@vger.kernel.org

--nextPart8677078.kdzu5DcuLC
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 09 February 2010 06:50:06 pm David Miller wrote:
> [ Josip, when I hit this I thought that if it were a gcc bug it might
>   explain your gcc-4.4 kernel failures.  That's why I haven't played
>   with your machines yet.  Now that I know this is actually a kernel
>   bug effecting only user applications, I will go pursue your
>   issues. ]
>=20
> I originally thought this was a gcc bug:
>=20
> 	http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D43004
>=20
> But it's actually a kernel issue.
>=20
> When we clone or create a signal stack we only 8-byte align the stack
> frame, it should be 16-byte aligned on 64-bit.  Use 16-byte alignment
> for 32-bit too since that's harmless and it's cheaper that way.
>=20
> Distribution folks you really want this in your kernels, otherwise
> 64-bit threads and signal handlers will have broken alloca() and
> corrupt their stacks.

I thought that maybe this would help with a localdef generation issue that =
is=20
being seen while building glibc,  at least for debian and fedora.  however =
it=20
seems not.  I have built the latest Fedora 12 stable kernel with your patch=
=20
applied and glibc failed to build still.

patches had been submitted to glibc=20
http://sources.redhat.com/bugzilla/show_bug.cgi?id=3D10855
http://sources.redhat.com/bugzilla/show_bug.cgi?id=3D10283

however one had been outright rejected and the sparc specific one has not b=
een=20
looked at.   Is this something that should be fixed in the kernel?

Dennis

--nextPart8677078.kdzu5DcuLC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAktzEBEACgkQkSxm47BaWfeIYQCbBAZIdFFaJNMH9a6hCeTnXyuh
hMQAoIA1ODUYE6kobDTMTYP5LF0nOO6A
=FlD/
-----END PGP SIGNATURE-----

--nextPart8677078.kdzu5DcuLC--
