From: Ciaran McCreesh <ciaranm@gentoo.org>
Date: Fri, 30 Jan 2004 19:32:39 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040130193239.40a147cf@snowdrop.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__30_Jan_2004_19_32_39_+0000_cC5vIE/jgA7WHVQM"
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
To: sparclinux@vger.kernel.org

--Signature=_Fri__30_Jan_2004_19_32_39_+0000_cC5vIE/jgA7WHVQM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2004 13:29:54 -0500 Ben Collins <bcollins@debian.org>
wrote:
| I'm a little disappointed. I haven't gotten any feedback from people
| testing this new version. So either no one cares, or it works good and
| people don't want to waste their time sending "worked for me" emails
| :)

1.4.3 works for me with an Ultra 10 and an Ultra 1 with various 2.6.1
kernels.

As expected, 2.6.2-rc2 (+ Gentoo patches) refuses to boot. On an Ultra
10, OBP tells me the following:

| Allocated 8 Megs of memory at 0x40000000 for kernel
| Loaded kernel version 2.6.2
|
| Remapping the kernel... done.

and then locks up completely.

On an Ultra 1, it panics at boot (I can make a serial cable if you need
the full text) with init(1): TL1: Data Access Exception [#1].

Sparc32 seems to be totally broken. I'll send debug information once my
soldering iron's warmed up :)

Gentoo people, 1.4.3 is in portage but hard masked for now. Please test
if you're brave...

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm

--Signature=_Fri__30_Jan_2004_19_32_39_+0000_cC5vIE/jgA7WHVQM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGrFd96zL6DUtXhERAvcKAJ4leAunigjxmMwr0sLFscDhe5v0egCfdMvC
b/NrMwuvsH5C5fwxHOIvC3Y=
=Ysup
-----END PGP SIGNATURE-----

--Signature=_Fri__30_Jan_2004_19_32_39_+0000_cC5vIE/jgA7WHVQM--
