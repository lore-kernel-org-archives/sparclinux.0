From: Bob Breuer <breuerr@mc.net>
Date: Mon, 12 Jun 2006 01:21:09 +0000
Subject: Re: [PATCH] migration cost tune up in sparc smp
Message-Id: <448CC185.80500@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4483db6b9a343@wp.pl>
In-Reply-To: <4483db6b9a343@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> But why in the world does the scheduler "lock up" just because the
> migration cost is too large?

There is an address space collision between the vmalloc area and where
the prom maps the framebuffer.

The vmalloc range is 0xfe600000 to 0xffc00000.  I have a cg6 that gets
mapped to 0xfee00000, and a cg14 with 8MB vsimm that gets mapped to
0xfe700000.  These leave only 8MB and 1MB of usable vmalloc space before
bad things happen.

We may want to find a different vm hole to put vmalloc into.  Is there
any documentation on what address spaces are reserved with the different
prom versions?

Bob

