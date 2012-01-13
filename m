From: David Miller <davem@davemloft.net>
Date: Fri, 13 Jan 2012 23:15:45 +0000
Subject: Re: [WIP] sparc32: replace bootmem with memblock
Message-Id: <20120113.151545.1892091882527042657.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120103204516.GA4271@merkur.ravnborg.org>
In-Reply-To: <20120103204516.GA4271@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 3 Jan 2012 21:45:16 +0100

> +	/* Reserve all highmem in memblock - this may be nothing */
> +	memblock_reserve(highstart, memblock_end_of_DRAM() - highstart);

Actually this calculation is going to be negative most of the time when
there is no highmem.  And if it is in fact zero, memblock_reserve() has
a BUG check on that.

I therefore think you'll need to guard this with a:

	if (memblock_end_of_DRAM() - highstart)

test.

Otherwise this patch so far looks great.
