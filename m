From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 20 Mar 2006 23:26:34 +0000
Subject: Re: Switch default page size to 64k?
Message-Id: <20060320.152634.130183645.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ed9ea0040603191435t36c95a80k47d2bf4903a66811@mail.gmail.com>
In-Reply-To: <ed9ea0040603191435t36c95a80k47d2bf4903a66811@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Holger Berger" <holger.s.berger@googlemail.com>
Date: Mon, 20 Mar 2006 18:45:56 +0100

> On 3/20/06, David S. Miller <davem@davemloft.net> wrote:
> > From: "Holger Berger" <holger.s.berger@googlemail.com>
> > Date: Mon, 20 Mar 2006 01:25:24 +0100
> >
> > > there is no such agenda.
> >
> > I would like to publicly apologize to Holger for saying that he had an
> > agenda for suggesting a default page size of 64K.
> 
> Apology accepted... :-)

Ok, so let's talk about what happens on your system when the default
page size goes up to 64K.  I think most users will not be pleased with
the following ramifications.

Let's look at how much memory it takes to hold the Linux kernel source
tree in the filesystem page cache with different page sizes.  There
are around 19,000 files, which by size total around 208MB.

The average size of a file is 11K, the median size, however, is around
4K.  By page size, a table of the number of files in that set which
fit in one page looks like this:

	in 4kB: 9616 files (49.9%)
	in 8kB: 12996 files (67.5%)
	in 16kB: 15912 files (82.6%)
	in 32kB: 17820 files (92.5%)
	in 64kB: 18747 files (97.3%)

Half of the files file in a 4K page, 2/3 fit into an 8K page.

So how much memory is required to hold all of those files in ram for
each page size?  Let's do the math, keeping in mind that, as we stated
above, the size total assuming no alignment (ie. if we could have a
page size of 1 byte :-), is 208MB:

 - 4kB: 251.5 MB
 - 8kB: 303.4 MB
 - 16kB: 421.0 MB
 - 32kB: 684.0 MB
 - 64kB: 1252.3 MB
 - 128kB: 2428.6 MB

That's right, with a 64K page size it takes more than a gigabyte of
ram to hold the kernel sources, whereas with an 8KB page it takes only
300MB.  If that doesn't make you feel ill about using 64K pages by
default, I don't know what will :-)

Let's express this disaster in terms of overhead.

1) with 4K pages, the overhead is ~%25, rather acceptable
2) with 8K pages, the overhead is ~%50, which is worse than 4K but
   isn't too hard to live with
3) with 16K pages, we are now wasting half of our memory, this is
   starting to hurt
4) with 64K pages, we are wasting 85% of our memory, that is simply
   unacceptable

I can only conclude that 64K pages are a fun benchmarking tool and
nothing more.  Benchmarks can make 64K pages look great, especially
when everything fits in ram and none of the above issues cause the
workload to start not fitting in memory.  But that is not real life,
and I would label any such benchmark to be seriously flawed.

I would severely discourage anyone from seriously considering 64K
pages by default.
