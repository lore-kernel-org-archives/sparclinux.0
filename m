From: David Miller <davem@davemloft.net>
Date: Sun, 29 Jul 2007 09:05:54 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070729.020554.104645494.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 09:29:33 +0100 (BST)

> The trouble is I by the time I have sorted out one bug, another 3 or more 
> have been introduced :-(.

I share your pain, even from purely the sparc64 perspective every
day feels exactly the same way to me.  Today was no exception.

I even try to share as much code as possible between sparc32 and
sparc64 when the opportunity presents itself.  That's the whole idea
behind the of_device and generic PROM device tree layers.
Unfortunately these unifications bring along with them some temporary
breakage as well.  Nothing is free :-)

> If the rate of breakage can be reduced to somthing that can be dealt with 
> over 1 to 2 days per week then I could try to keep things tested. If not 
> then I will run out of time whenever I am earing a living.

At the very least if you do a GIT pull every few days, you will have
so much less to sift through if a breakage occurs all of a sudden.

The best thing to do is to have a fast build machine, and for sparc32
that undoubtedly means cross compilation on a more modern platform,
and then test booting those images on the real sparc32 hardware.

Another option is qemu, which I am to understand can boot sparc32
kernels.

> I have tried to identify a NULL pointer bug that has crepped into the code 
> that runs /sbin/init but git bisect only gave me a kernel that will not 
> build because of DMA changes. I tries some random selections to try and 
> find a buildable/working kernel but without any sucess.
> 
> Any sugestions as to how to track the issue down through the 2000+ commits 
> since v2.6.22. At between 20 and 40min per build+test the time required to 
> test each build untill I get one that works is excessive.

This can be the problem with GIT bisects.

Figure out what's NULL, then try to figure out why it might have
gotten that way.  If you can't figure out why, add tracing code into
some choice locations (for example, do_sparc_fault() or similar)
that does something like:

	if (!strcmp(current->comm, "init") &&
	    whatever = NULL)
		printk("FOO is NULL at ...");

keep adding these until you see exactly what makes it NULL.  This
is most doable when you have a very isolated time in which the
problem occurs, which fits perfectly to a case like init failing
to execute properly.

To be honest, once you find out what is NULL, it may be clear to
aparent what the cause is.  I'm surprised you haven't figured
this out yet in the traces :-)

I think analysis should be the first step before even considering a
GIT bisect, I only ever bisect when the crash is so mysterious that up
to an hour of code inspection and crash analysis and probing is unable
to reach an answer.  And frankly you'll learn more and be better
prepared for future bug analysis if you don't resort to GIT bisect.
