From: Ben Collins <bcollins@debian.org>
Date: Wed, 16 Jun 2004 13:42:35 +0000
Subject: Re: [SOLVED] Take 3: sparc64 CDs work?
Message-Id: <20040616134235.GC1331@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200406161359.51864.frederik@dannemare.net>
In-Reply-To: <200406161359.51864.frederik@dannemare.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Then today (don't know why this idea came to me) I decided to open up 
> the box and juggle around with the memory sticks. And voila! Moving the 
> two sticks from DIMM3 and DIMM4 to DIMM1 and DIMM2 made the initrd 
> issue go away (booted with default SILO parameters). Dunno why Sarge is 
> picky, when Woody, Solaris, and some old SuSE is not.

That's pretty interesting, and probably very critical info. Thanks for
trying that.

What it means to me is that either SILO or the kernel (likely SILO)
isn't coping well with the physical memory being located high up when it
comes to the initrd. I'll move some sticks around in my U5 and see if I
can reproduce this bug now. I could never reproduce it before.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
