From: Frederik Dannemare <frederik@dannemare.net>
Date: Wed, 02 Jun 2004 15:09:06 +0000
Subject: Re: new debian-installer images for sparc
Message-Id: <200406021709.19547.frederik@dannemare.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531034458.GF2384@triplehelix.org>
In-Reply-To: <20040531034458.GF2384@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 31 May 2004 05:44, Joshua Kwan wrote:
> Folks,
>
> Here is a mini-ISO image I cooked up with SILO rolled back to 1.3.2.
> Tom Callaway suggested that I try this because a lot of new stuff
> related to initrds changed in 1.4.x.
>
> http://june.voxel.net/~joshk/mini.iso
>
> Tell us what happens! (And wish me luck on finals!)

Tested on a Sun Ultra 5 (UltraSPARC-IIi 333MHz (sun4u arch)).

I stops with:
sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk(1,0)
Kernel panic: VFS: Unable to mount root fs on 00:00

Same as Bug#243122.

- -- 
Frederik Dannemare | frederik@dannemare.net | http://dannemare.net
GnuPG key: search for 'dannemare' on http://pgpkeys.mit.edu
Key fingerprint: BB7B 078A 0DBF 7663 180A  F84A 2D25 FAD5 9C4E B5A8
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAve2WLSX61ZxOtagRAjdFAJ9tW7w6bkE/Qoq4S4bBmO3QgqC3HgCeIe1i
QKYn3qyxgTWCTBYPqc9ZTe8=Yjm5
-----END PGP SIGNATURE-----
