From: joshk@triplehelix.org (Joshua Kwan)
Date: Fri, 07 May 2004 23:33:54 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040507233354.GA11808@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
To: sparclinux@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2004 at 03:17:32PM -0700, David S. Miller wrote:
> > This bug crept up because I have a bi-architecture (32/64) binutils, and
> > unreasonable defaults sent my build to hell.
>=20
> Applied, how did this ever work?  '-V' is what you need to use regardless
> of how binutils was configured.

I have no idea. Isn't the bug in 2.6 as well?

FYI, on my i386 box, without this fix, it would link sparc32 kernels
correctly, but die when linking together 64-bit .o files. So I guess
'sparc-linux-ld' was really 'sparc-linux-ld -m elf32_sparc'. Perhaps the
binutils on a real sparc machine make the right decision based on the curre=
nt
system architecture?

--=20
Joshua Kwan

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJwc4KOILr94RG8mAQJgIhAAg+bTfzepiZu1VhIan31sCCFTLy2CSPQc
PzlfF0vfZKPRQ6ODU5PJJid7b5cmMFAhdAuVlmOgjW0c28BH0qgfAGi7h/1nImnh
4JTPdqzbjEUoe0eH6mojDN4DLIYUKQPq32GEM9sySZ+ZbRg64h6t0g8fDPuaka/y
7dXS88YEXr+FK2GmgtjQOqkKlvXeQvuraJQjADVp4cT5cbtj8Dlest60sshdSem2
sXfsbGSbvPc/I6gx4PMXnHYC/L/74jvbW2Jxg0zd7l3iP2faBZqOsqpDskjHvHSp
+Gb89IOyyjFI4pCc7q7ffkvrwPdimszM7wTQSyRvysBZ0PuPGDd4UbuByC+uM9GP
fnKKzc+mV7ylbfG4hUKeR+25zfLaEuB2JA261wtWRXjXytS6WglkLsgupb222rC+
4LZJmgW+YgzxAjuiWmkg31xUcealG2sa5BGcCa1qUxoyC8WHKDqcqx9pftmcmrrZ
NoVR4XHfVtU5glvacycainM30tlUTv/v+cwTPRcK/VAdSHl02Rhn9T0OtNxj5sOf
kgk4MdwKKYx5vqg0S4Nr5aAR+1LNZYmr9u0Z9NVELVy8w3NE57aGOfD2hwNS+Mf9
Mx+q+POo1uMS/0WGq6dvC9XVeIQk4ez2rCraYx9TI//SOaCZayX62S803BAx0tRt
4F/bF5sZeE8=
=R/PL
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
