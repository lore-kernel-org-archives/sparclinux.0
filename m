From: Jason Wever <weeve@gentoo.org>
Date: Sat, 01 May 2004 03:14:00 +0000
Subject: Re: Illegal instruction with silo 1.4.4 and ultra 1
Message-Id: <20040430211400.4129bdc6@excelsior.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__30_Apr_2004_21_14_01_-0600_lm/ueMSTP.Qg9Jju"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
To: sparclinux@vger.kernel.org

--Signature=_Fri__30_Apr_2004_21_14_01_-0600_lm/ueMSTP.Qg9Jju
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 30 Apr 2004 07:32:04 -0400
Ben Collins <bcollins@debian.org> wrote:

> Doesn't look like a silo problem off-hand. This PC is in the start of
> the kernel. What compiler are you compiling your kernels with?

Used gcc-3.3.3.  Had to power-off the box for a while today, and when I
turned it back up, it was booting fine.  Both before when it was
having this problem and now if I enabled diag-switch? everything checked
out.  I'll keep an eye on it and see if it does crop up again if I can
better pinpoint conditions.

Thanks for the help,
-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature=_Fri__30_Apr_2004_21_14_01_-0600_lm/ueMSTP.Qg9Jju
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkxX8dKvgdVioq28RAqXYAJ9e4bteWMotPbxm2EDyDQO+YLkb8ACggbQC
lhZDUQEwpqdL6yxYJAB4TxE=
=T/V1
-----END PGP SIGNATURE-----

--Signature=_Fri__30_Apr_2004_21_14_01_-0600_lm/ueMSTP.Qg9Jju--
