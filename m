From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 26 Feb 2006 15:18:00 +0000
Subject: Re: U1/U2 failures with kernel 2.6.<anything> --- maybe a clue?
Message-Id: <Pine.LNX.4.10.10602261450370.6328-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0602260312230.17700@terciopelo.krait.us>
In-Reply-To: <Pine.LNX.4.64.0602260312230.17700@terciopelo.krait.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

There have been a number of changes from V2.2.xx to V2.6.xx in the SCSI
layers that break things.

I tried to use the AHA1542 driver (PC ISA) with a 2.6.10 kernel and it
failed miserably. I have not tried a more recent one yet but as looking at
the code between a working 2.2.26 kernel and the 2.6.10 kernel indicated
that a number of things relating to SCSI Bus timeouts have been re-located
and messed arround with. It is clear that not all the comments in the
V2.2/V2.4 SCSI drivers/SCSI layer code were read and understod before the
changes to the V2.6 kernel were made and that much more testing of the
various SCSI drivers should have been done before the changes got into the
kernel.

The lack of thorough testing apears to be a big issue with the 2.6.xx
kernels as from my point of view is the continuously changing internal
interfaces. It is hard work keeping propriatory hardware device drivers
uptodate with all the changes, let alown attempting to identift and fix
bugs in the kernel supplied drivers/interface layers.

I have had to make significant changes to the frame buffer code to get a
satesfactory/usable display using my SparcStation 1 (CG3). Black on black
displays make debugging very dificult especially when the CG3 code causes 
a system crash.

I still do not have a usable system as there is a bug someware that
prevents a NFS root filing system from working properly (linking causes a
radix error in the NFS code) and the UFS filing system write support cause
the kernel to lockup on file change.

Regards
	Mark Fortescue.

On Sun, 26 Feb 2006, Ferris McCormick wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> OK, I've been thinking about this, and here is what we have.
> (1) Some U1/U2 systems do very well on these kernels;
> (2) Some are unusable:  I have one which on 2.6.xx, has mean time between 
> (very hard lock) failure of about a day, on kernel-2.4.32, it's never 
> (literally).
> (3) Weeve and (I believe) squash are as in point 2.
> 
> Now, I am not imagining things: a system which responds to nothing at all 
> is hard to make up.
> 
> Further, my unusable-with-2.6 system is 2x400; stable ones are I think a 
> bit slower.
> 
> Here's the clue:  I tried the 2x400 system with a cdrecord, (which works 
> perfectly on 2.4.xx) with 2.6.15-rc4.  It wrote the disk.  Then it tried 
> to fixate it. 
> That killed it within about 1 second.  I *think* fixating is one long 
> system call (I haven't read cdrecord yet), and scsi disk activity I know 
> is the general killer.  So maybe looking at cdrecord's fixating system 
> activity can tell where the problem is.  (I do know cdrecord on this
> system with 2.6.xx has a 100% failure rate, based on several attempts.)
> 
> Thoughts, Comments?
> (By the way, I regret my rash remarks from earlier.)
> Regards,
> Ferris
> - --
> Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
> Developer, Gentoo Linux (Devrel, Sparc)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.1 (GNU/Linux)
> 
> iD8DBQFEAR06Qa6M3+I///cRAmq7AJ9SCiBS/sXieWdWF/Xu6nBMxIplngCdF2/3
> Ku3jz0TMhUjvbnbT1md+Y/0> =tMFQ
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

