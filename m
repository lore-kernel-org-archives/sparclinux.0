From: joshk@triplehelix.org (Joshua Kwan)
Date: Sat, 08 May 2004 21:04:43 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040508210443.GB14744@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
To: sparclinux@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 08, 2004 at 01:03:45PM -0700, David S. Miller wrote:
> It is using "-m64" so a sparc64 build, but for some reason the
> include/asm symlink is being set to the sparc32 header directory
> include/asm-sparc instead of the correct include/asm-sparc64

Line 433 in include/asm-sparc/unistd.h is a comment. Remember, I'm
talking 2.6 here.

> > include/asm is indeed symlinked to include/asm-sparc64, FWIW.
>=20
> I really don't think so, line 433 is only a place where a compile
> error like that can occur in the sparc32 unistd.h not the sparc64
> one.

We-ell, ok. Let's see then:

$ make ARCH=3Dsparc64 CROSS_COMPILE=3Dsparc-linux- mrproper defconfig image
[...]
(Failure ensues)
$ ls -l include/asm
lrwxrwxrwx    1 joshk    joshk          11 2004-05-08 14:02 include/asm -> =
asm-sparc64

I'm absolutely positive it is using that directory and that unistd.h.

--=20
Joshua Kwan

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJ1LaqOILr94RG8mAQI5Pw/+M9tnTzL7abencX4fxQa54mjqlc+XG8fN
8pgjSEQYTeqJJVv07ZvSGntXDEAxabixzYc6kzYo3ju9/U2HFZiQMMKTVsicZJQC
nra7oOpokGjdDFIKtgV9Lxla53ZpVLMQMnHT018oiqbaZg0qXQ7DBK9cdd+tp+Si
eK17Qf4zwO/AGkLfdskRcss0V4PICVNtzetw/zwQ3d9szlFj+ss5Kyn1Z/S09lvd
nNSsXg68ZXd/NPMk4rAWwoPb+Cnecx7wDoUNaarazYm7batz1vS8iKgOeQnqvFr8
LTBs/RA6AgzY36GnGndZ5xvlkMeIlXSEvQrO1lCUS41mry7zUKv8CrctQzQsfG7Y
3AOEc7PspBC9H+x+KXqP4E/D94R7buTMq1s7lZR/UTY8Di95SLL9xdAlOyZlIZ89
aZ3SZ1DamFSgdNCq44hgaKJTdmTcjU9HHKC6o+RWYXm+FoN/r/nmCfITV5JK+YLD
7R2RFvrONzzzjcXJzG7PJDyQRETdiqglXwFZ6wIfZMwzPQKJTyXoSTYpjABZiOiA
wiT98Egtlc+Mrd7GkpW0jMkPII4ZiZtX1oG14QqETEBuxwn9DhnCdBg5AbZ7Vwij
19afILc6MaS+3oWpCKeiboj+ff2qW/BBFISWTWcOryISfWkEqbtLLMNs9kua/X0y
9qnxbllQCPo=
=uwV8
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
