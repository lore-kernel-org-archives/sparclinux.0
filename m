From: Ciaran McCreesh <ciaranm@gentoo.org>
Date: Thu, 29 Jul 2004 00:05:27 +0000
Subject: Re: SMP support in 2.6.x kernel for sparc32
Message-Id: <20040729010527.39cfbb29@snowdrop.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__29_Jul_2004_01_05_27_+0100_fBp60lUptkX+Ubh2"
List-Id: <sparclinux.vger.kernel.org>
References: <001301c474db$af707860$3c01a8c0@cascade>
In-Reply-To: <001301c474db$af707860$3c01a8c0@cascade>
To: sparclinux@vger.kernel.org

--Signature=_Thu__29_Jul_2004_01_05_27_+0100_fBp60lUptkX+Ubh2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 28 Jul 2004 16:53:29 -0700 William Lee Irwin III
<wli@holomorphy.com> wrote:
| I just rediffed the smp patch by brute force vs. 2.6.8-rc2. I'll spin
| it up on 3x hypersparc if it turns out the box is actually functional
| and see where it explodes sometime in the next 72 hours.

Well, hypersparc has a whole extra set of problems. Unless you use an
embedded root it's got a ~97% chance of not running init. Only way to
run a proper userspace on hypersparcs with 2.6.x is to boot into
busybox, nfsmount a system image and then repeatedly try to run things
until you get lucky with DMA...

-- 
Ciaran McCreesh : Gentoo Developer (Sparc, MIPS, Vim, Fluxbox)
Mail            : ciaranm at gentoo.org
Web             : http://dev.gentoo.org/~ciaranm


--Signature=_Thu__29_Jul_2004_01_05_27_+0100_fBp60lUptkX+Ubh2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQFBCD9J96zL6DUtXhERAsmqAJjFrLojg2R9115lXrDdLqqdB7FaAJ9gGv2h
mA2ARBo7TmN+pWBqQJEMbA==
=kUEZ
-----END PGP SIGNATURE-----

--Signature=_Thu__29_Jul_2004_01_05_27_+0100_fBp60lUptkX+Ubh2--
