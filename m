From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Thu, 09 Dec 2004 05:25:51 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to
Message-Id: <1102569951.20234.15.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-JI7OO/mNa/Xy3cY1HNEw"
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
To: sparclinux@vger.kernel.org


--=-JI7OO/mNa/Xy3cY1HNEw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-12-08 at 21:01 -0800, David S. Miller wrote:
> Please use __KERNEL__ instead of things like _SIGNAL_H
> Thanks.

Ok, I'll keep that in mind for next time.  I was just copying the same
behavior from asm-x86_64.  Do you want me to update/resend the patch?=20

--=20
Jeremy Huddleston <eradicator@gentoo.org>

--=-JI7OO/mNa/Xy3cY1HNEw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBt+HfOpjtAl+gMRURAjTjAJ96O8X03WZBoW9JF3bpRM4fAIR2DwCg0DMD
d5kh5PyOQz03XYsq8s5GrEo=
=RjuZ
-----END PGP SIGNATURE-----

--=-JI7OO/mNa/Xy3cY1HNEw--

