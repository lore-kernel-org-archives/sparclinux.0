From: Dennis Gilmore <dennis@ausil.us>
Date: Fri, 10 Sep 2010 03:56:29 +0000
Subject: Re: bugs compiling 2.6.35.4
Message-Id: <201009092256.31949.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1797320.FHsGRslaRA"
List-Id: <sparclinux.vger.kernel.org>
References: <201009092029.52510.dennis@ausil.us>
In-Reply-To: <201009092029.52510.dennis@ausil.us>
To: sparclinux@vger.kernel.org

--nextPart1797320.FHsGRslaRA
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday, September 09, 2010 10:36:51 pm David Miller wrote:
> Turn off CONFIG_DEBUG_STRICT_USER_COPY_CHECKS in your config, it
> is a debugging facility for kernel developers not something you
> should enable yourself.
>=20
> In fact because so many people turned this on and report the build
> failures, I've simply just removed it from the tree as I got tired
> of explaining this every single time :-/
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

the fedora kernel devs have it enabled.  and we picked it up though the=20
generic configs for every arch.  for now ive turned it off however the firs=
t=20
issue still exists.

Dennis

--nextPart1797320.FHsGRslaRA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyJrG8ACgkQkSxm47BaWfebdwCdFRYMgHRMcgvvjLkxU8PHOobV
HHMAn00tBQrBmoaXHmZSew0ES8KxsSlN
=AjCY
-----END PGP SIGNATURE-----

--nextPart1797320.FHsGRslaRA--
