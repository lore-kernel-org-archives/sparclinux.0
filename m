From: joshk@triplehelix.org (Joshua Kwan)
Date: Sun, 09 May 2004 00:49:15 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040509004915.GB19993@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
To: sparclinux@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 08, 2004 at 05:14:00PM -0700, David S. Miller wrote:
> errno =3D -__res; \
> return -1; \
> }
> ^^^^^ this is line 433

Er, well - I'm using 2.6.6-rc3-mm2, line 433 of asm-sparc64/unistd.h
contains:

static __inline__ _syscall0(pid_t,setsid)

Well, fancy that, 2.6.6-rc3 stock does build... good to hear, huh? :)

Either way it's your changes that messed it up, so now consider this a
report against the changes made in 2.6.6-rc3-mm2. :D

--=20
Joshua Kwan

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJ2ACqOILr94RG8mAQJHpw/7BHJhWSuq2ojrHO0NVhWoo7O6AWXcvsO0
YF6G86YTAzq0HDQoyFT4MIi3BnXT5PWDKvyHWPMmlA3E9IXDMCvb7YuM4jd+iL4Y
5+q/sJlDxys+yJl1h/GCwpPnUIQbzc8bAGeE2V0swibB0MpIkZA9oDn2VeNx0LbL
/WrZBg/RV6sqOIRXCcTgHPFhkeFRIeK9XKSvwOWN/YTfrCbipSLD39PYF7zSR+Ae
xPOUKKcxOQjdAdcsSqLFX5REjVXlWMrGpqFbFrMgDOOaCtpQ8RTqd3OyUgwGeJmh
YFx536jeZQ/hAldeb1JrxRDWU8WWQqf85Vd9qL80eNCQlKNxRsaSCQ1HDfORxZVs
iP6ezhJTD1Q2hAvkOnR2fKlwyqXlscHnqb6wwZFLxzfx0U3b5N1HL3/7q33bjtQS
su7xYE0N1F7YUvv4kj3dmxYI8ZBw5wZ97/hcTn8jbCCOjy1vXz+iADz6D6q30LVK
gNf+6xG6MByJwunL6uNBiI+dQcch0527CqkkHucXFYLCRCSan20ECBri9GM7udDr
VhCoHuSJJTSYEjDu0+L+eYqJRUuhcz3Zt99zsI+N6wXMZt/vjw52nUwHayMk1JgG
XBiO2axFQA8eQ56qWR6he5ouK6ShtahZyP8PaQsplqj2XspPxVk90G+I3Xu0dSQ0
X1Yr8odoDf0=
=A/3z
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
