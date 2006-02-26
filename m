From: Ferris McCormick <fmccor@gentoo.org>
Date: Sun, 26 Feb 2006 03:14:58 +0000
Subject: U1/U2 failures with kernel 2.6.<anything> --- maybe a clue?
Message-Id: <Pine.LNX.4.64.0602260312230.17700@terciopelo.krait.us>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

OK, I've been thinking about this, and here is what we have.
(1) Some U1/U2 systems do very well on these kernels;
(2) Some are unusable:  I have one which on 2.6.xx, has mean time between 
(very hard lock) failure of about a day, on kernel-2.4.32, it's never 
(literally).
(3) Weeve and (I believe) squash are as in point 2.

Now, I am not imagining things: a system which responds to nothing at all 
is hard to make up.

Further, my unusable-with-2.6 system is 2x400; stable ones are I think a 
bit slower.

Here's the clue:  I tried the 2x400 system with a cdrecord, (which works 
perfectly on 2.4.xx) with 2.6.15-rc4.  It wrote the disk.  Then it tried 
to fixate it. 
That killed it within about 1 second.  I *think* fixating is one long 
system call (I haven't read cdrecord yet), and scsi disk activity I know 
is the general killer.  So maybe looking at cdrecord's fixating system 
activity can tell where the problem is.  (I do know cdrecord on this
system with 2.6.xx has a 100% failure rate, based on several attempts.)

Thoughts, Comments?
(By the way, I regret my rash remarks from earlier.)
Regards,
Ferris
- --
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Devrel, Sparc)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEAR06Qa6M3+I///cRAmq7AJ9SCiBS/sXieWdWF/Xu6nBMxIplngCdF2/3
Ku3jz0TMhUjvbnbT1md+Y/0=tMFQ
-----END PGP SIGNATURE-----
