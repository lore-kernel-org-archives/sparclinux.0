From: Ciaran McCreesh <ciaranm@gentoo.org>
Date: Mon, 12 Jan 2004 15:46:06 +0000
Subject: Re: [2.6.1] still no working keyboard/mouse on ultra-enterprise 2
Message-Id: <20040112154606.775a42a0@snowdrop.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__12_Jan_2004_15_46_07_+0000_.4s8LWf9yiKOv88F"
List-Id: <sparclinux.vger.kernel.org>
References: <20040112140940.C4116@pc9391.uni-regensburg.de>
In-Reply-To: <20040112140940.C4116@pc9391.uni-regensburg.de>
To: sparclinux@vger.kernel.org

--Signature=_Mon__12_Jan_2004_15_46_07_+0000_.4s8LWf9yiKOv88F
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2004 14:09:40 +0100 Christian Guggenberger 
<Christian.Guggenberger@physik.uni-regensburg.de> wrote:
| after reading 2.6.1's changelog, I hoped, my keyboard and mouse would
| be working for the 1st time in 2.6. (sunmouse and sun type5 kbd
| attached to zilog) - they never worked with previous 2.6-test*
| kernels, but did with any 2.4; well, still a nogo in 2.6.

Are you using the 2.4-style KEYMAPs? I don't know how Debian handles
this, but in Gentoo it's necessary to comment out the KEYMAP="sunkeymap"
line in /etc/rc.conf (or replace it with an x86-style setting if you
prefer).

I have a type5 working quite happily on an ultra1 running 2.6.1-rc2
(with Keith's patches) this way.

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm


--Signature=_Mon__12_Jan_2004_15_46_07_+0000_.4s8LWf9yiKOv88F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAsFC96zL6DUtXhERAiKdAKCyE2flQ89sruYtxemOBSuJpRXApACghAjw
Spz5HAFFL0FviW8OQg6hafY=
=QmLG
-----END PGP SIGNATURE-----

--Signature=_Mon__12_Jan_2004_15_46_07_+0000_.4s8LWf9yiKOv88F--
