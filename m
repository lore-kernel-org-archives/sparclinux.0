From: Ciaran McCreesh <ciaranm@gentoo.org>
Date: Mon, 31 May 2004 02:19:08 +0000
Subject: Re: hme hang in SMP (was: 2.6.6 SMP on UE2 hangs consistently)
Message-Id: <20040531031908.0bc1e90c@snowdrop.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__31_May_2004_03_19_08_+0100_4BbgBjB5GQcj1yRE"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
To: sparclinux@vger.kernel.org

--Signature=_Mon__31_May_2004_03_19_08_+0100_4BbgBjB5GQcj1yRE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 28 May 2004 11:07:04 +0300 (EEST) Meelis Roos <mroos@linux.ee>
wrote:
| > Did you try booting with maxcpus=1 or building without SMP ?
| 
| I did try maxcpus=1 now, this works too in addition to UP. So it's two
| CPU-s that's showing the bug, not just SMP kernel.
| 
| Additionally I found out that keyboard is actually OK, I just have to
| use the right keymap for 2.6 (duh). So only hme is dieing in real SMP.

This is a *very* long shot, but... Have you tried applying the ultra1E
hme lockup patch? A Gentoo user reported the same problem, and he is
also using dual USI CPUs in an Ultra2.

If you can't find the patch anywhere, it's included in:
http://gentoo.oregonstate.edu/distfiles/patches-2.6.6-sparc.tar.bz2

(blindly stabbing in the dark...)
-- 
Ciaran McCreesh : Gentoo Developer (Sparc, MIPS, Vim, Fluxbox)
Mail            : ciaranm at gentoo.org
Web             : http://dev.gentoo.org/~ciaranm


--Signature=_Mon__31_May_2004_03_19_08_+0100_4BbgBjB5GQcj1yRE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAupYj96zL6DUtXhERAqVaAJ0adWA31AAwBu3gNWGDIE5HaD16XwCg0Dyb
5OBWfYxYccZEyjYCuP2iSec=
=ALFT
-----END PGP SIGNATURE-----

--Signature=_Mon__31_May_2004_03_19_08_+0100_4BbgBjB5GQcj1yRE--
