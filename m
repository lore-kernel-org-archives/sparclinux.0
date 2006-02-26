From: gentuxx <gentuxx@gmail.com>
Date: Sun, 26 Feb 2006 04:23:20 +0000
Subject: Re: [gentoo-sparc] U1/U2 failures with kernel 2.6.<anything> ---
Message-Id: <44012D38.5000205@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0602260312230.17700@terciopelo.krait.us>
In-Reply-To: <Pine.LNX.4.64.0602260312230.17700@terciopelo.krait.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ferris McCormick wrote:

> OK, I've been thinking about this, and here is what we have.
> (1) Some U1/U2 systems do very well on these kernels;
> (2) Some are unusable: I have one which on 2.6.xx, has mean time
> between (very hard lock) failure of about a day, on kernel-2.4.32,
> it's never (literally).
> (3) Weeve and (I believe) squash are as in point 2.
>
> Now, I am not imagining things: a system which responds to nothing
> at all is hard to make up.
>
> Further, my unusable-with-2.6 system is 2x400; stable ones are I
> think a bit slower.


This could be.  I currently have 3 U1's running 2.6.15-r5 perfectly
fine.  I'm still sort of in the process of building them out (just
adding packaged I need and such), so they have been compiling (with
distcc) fine for about 3 days straight.  Two are 200Mhz Ultrasparc I's
and one is a 166Mhz U1.

They each only have one processor, but SMP is enabled.

>
> Here's the clue: I tried the 2x400 system with a cdrecord, (which
> works perfectly on 2.4.xx) with 2.6.15-rc4. It wrote the disk.
> Then it tried to fixate it. That killed it within about 1 second. I
> *think* fixating is one long system call (I haven't read cdrecord
> yet), and scsi disk activity I know is the general killer. So maybe
> looking at cdrecord's fixating system activity can tell where the
> problem is. (I do know cdrecord on this
> system with 2.6.xx has a 100% failure rate, based on several attempts.)
>
> Thoughts, Comments?
> (By the way, I regret my rash remarks from earlier.)
> Regards,
> Ferris
> --
> Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
> Developer, Gentoo Linux (Devrel, Sparc)


- --
gentux
echo "hfouvyAdpy/ofu" | perl -pe 's/(.)/chr(ord($1)-1)/ge'

gentux's gpg fingerprint => 34CE 2E97 40C7 EF6E EC40  9795 2D81 924A
6996 0993
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEAS04LYGSSmmWCZMRAmqtAKC1RoYtSKkJywwjC4j49pqQmwgr9wCeLE7A
rX6mbX/BI8o7YTdfsV5Nvtk=j9Yv
-----END PGP SIGNATURE-----

