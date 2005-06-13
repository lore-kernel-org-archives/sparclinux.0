From: Jason Wever <weeve@gentoo.org>
Date: Mon, 13 Jun 2005 20:56:49 +0000
Subject: Re: Working config wanted for 2.6.11, Ultra 5, sparc64
Message-Id: <Pine.LNX.4.63.0506131452350.24772@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
In-Reply-To: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 13 Jun 2005, David S. Miller wrote:

> As for the ATI driver, I have problems with it as well, but
> only on my SunBlade100 system.  It doesn't setup my Samsung
> 19" LCD properly.  Perhaps specifying a by-hand resolution
> and sync rate on the kernel command line will help.

We've had one Gentoo user report that atyfb doesn't work for him in the 
most recent 2.6 kernels (blade 1x0).  I haven't had a chance to test it on 
mine, but I believe he is using a CRT.

As for LCDs, in times past to get my Samsung 17" LCD to work, I had to 
specify both an OBP level resolution and refresh rate as well as in the 
kernel arguments for the atyfb driver (since atyfb doesn't always seem to 
respect the OBP defined rates).

The OBP setting that worked in my case was 
output-device=screen:r1280x1024x60 and the kernel argument was 
video=atyfb:1024x768@60 (never did quite get a 1280x1024 console going).

Cheers,
- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCrfMUdKvgdVioq28RAp9WAJ4sGVYUCFQ7bMUzQ52TylxvzOCrqwCfVgRn
fXXEt8ryARVcQHVGfiWO+lg=4jjI
-----END PGP SIGNATURE-----
