From: David Miller <davem@davemloft.net>
Date: Fri, 27 Dec 2013 18:48:14 +0000
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
Message-Id: <20131227.134814.345379118522548543.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20131227180018.GC4945@linux.intel.com>
In-Reply-To: <20131227180018.GC4945@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: willy@linux.intel.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org

From: Matthew Wilcox <willy@linux.intel.com>
Date: Fri, 27 Dec 2013 13:00:18 -0500

> It seems to me that while (for example) on SPARC, it's not possible to
> create a non-coherent mapping with mmap(), after we've done an mmap,
> we can then use remap_file_pages() to create a mapping that no longer
> aliases in the D-cache.
> 
> I have only compile-tested this patch.  I don't have any SPARC hardware,
> and my PA-RISC hardware hasn't been turned on in six years ... I noticed
> this while wandering around looking at some other stuff.

I suppose this is needed, but only in the case where the mapping is
shared and writable, right?  I don't see you testing those conditions,
but with them I'd be OK with this change.

