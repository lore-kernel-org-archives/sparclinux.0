From: Ciaran McCreesh <ciaranm@gentoo.org>
Date: Fri, 30 Jan 2004 20:55:42 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040130205542.027b5b3a@snowdrop.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__30_Jan_2004_20_55_42_+0000_ZKjMRTJZf+lL5=nV"
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
To: sparclinux@vger.kernel.org

--Signature=_Fri__30_Jan_2004_20_55_42_+0000_ZKjMRTJZf+lL5=nV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2004 15:19:47 -0500 Ben Collins <bcollins@debian.org>
wrote:
| I just uploaded SILO 1.4.4, which fixes this problem.

This one worksforme on a sparcstation 5. It also boots a Gentoo-patched
2.6.2_rc2 properly, so I guess it's just sparc64 broken there.

ciaranm@sundrop ciaranm 0 $ qpkg -v -I silo
sys-boot/silo-1.4.4 *
ciaranm@sundrop ciaranm 0 $ uname -a
Linux sundrop 2.6.2-rc2-sparc #1 Thu Jan 29 18:41:07 GMT 2004 sparc
sun4m Fujitsu  MB86904 GNU/Linux

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm

--Signature=_Fri__30_Jan_2004_20_55_42_+0000_ZKjMRTJZf+lL5=nV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGsTj96zL6DUtXhERAkMrAJ0cEc3m2nr4DUn6GcwJVgWcUV33KwCglYaQ
KB9vf5dRd+3p8FqC5wF0J0U=
=bCoA
-----END PGP SIGNATURE-----

--Signature=_Fri__30_Jan_2004_20_55_42_+0000_ZKjMRTJZf+lL5=nV--
