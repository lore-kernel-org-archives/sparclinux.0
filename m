From: simoneau@ele.uri.edu
Date: Thu, 16 Feb 2006 15:12:02 +0000
Subject: Re: kernel-2.6.15-r4 (in)stability on U2-SMP, etc.
Message-Id: <20060216101202.1v4kjuotssggck44@webmail.ele.uri.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_1nyskpuwzzgg"
List-Id: <sparclinux.vger.kernel.org>
References: <1140008955.4844.42.camel@polylepis.inforead.com>
In-Reply-To: <1140008955.4844.42.camel@polylepis.inforead.com>
To: sparclinux@vger.kernel.org

This message is in MIME format and has been PGP signed.

--=_1nyskpuwzzgg
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Quoting Ferris McCormick <fmccor@gentoo.org>:

> A few days ago, I indicated that I was testing subject kernel on various
> systems (U2-SMP, U60-SMP, SB1000-MP) for stability.  U60/SB1000 appear
> to be stable.
>
> However, U2-SMP(2x450) is not.  As is the case with ALL 2.6.xx kernels,
> 2.6.15-r4 cannot handle the sort of disk activity which portage requires
> of it on a daily basis (although the daily slocate cron task no linger
> kills it).  Symptom is as with all kernels in the 2.6.xx series ---
> silent death with system completely non-responsive to anything.
>
> Regards,
> Ferris
> --
> Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
> Developer, Gentoo Linux (Sparc, Devrel)
>

2.6.15-rc5 worked for me (over 100 iterations of crashme with no problems) on
U2-SMP 2x248.

--=_1nyskpuwzzgg
Content-Type: application/pgp-signature
Content-Description: PGP Digital Signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBD9JZCLYBaX8VDLLURAsVdAJ9POTEkBYyTda3+8uU0JGQqimm3ZgCdE3qA
H8H0ZYPbBx0Xws2n/CijTls=
=HvbW
-----END PGP SIGNATURE-----

--=_1nyskpuwzzgg--

