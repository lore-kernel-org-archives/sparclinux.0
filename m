From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jun 2006 03:54:41 +0000
Subject: Re: [PATCH] migration cost tune up in sparc smp
Message-Id: <20060611.205441.105429173.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4483db6b9a343@wp.pl>
In-Reply-To: <4483db6b9a343@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Sun, 11 Jun 2006 20:21:09 -0500

> David Miller wrote:
> > But why in the world does the scheduler "lock up" just because the
> > migration cost is too large?
> 
> There is an address space collision between the vmalloc area and where
> the prom maps the framebuffer.

And this is what locks up the scheduler when a bad migration cost
calculation is made?

Please start a new thread if you are talking about some new topic,
it gets confusing :-/

> The vmalloc range is 0xfe600000 to 0xffc00000.  I have a cg6 that gets
> mapped to 0xfee00000, and a cg14 with 8MB vsimm that gets mapped to
> 0xfe700000.  These leave only 8MB and 1MB of usable vmalloc space before
> bad things happen.
> 
> We may want to find a different vm hole to put vmalloc into.  Is there
> any documentation on what address spaces are reserved with the different
> prom versions?

I don't know, but from your report it seems that OBP takes
0xfe000000 up to 0xfff00000.

Actually, you can look at the "available" property of the
virtual-memory node.  Or, you can see if there is a "translations"
node in the /virtual-memory node like there is on sparc64.

