From: John David Anglin <dave.anglin@bell.net>
Date: Fri, 27 Dec 2013 19:13:16 +0000
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
Message-Id: <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <20131227180018.GC4945@linux.intel.com>
In-Reply-To: <20131227180018.GC4945@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org

On 27-Dec-13, at 1:00 PM, Matthew Wilcox wrote:

> +#ifdef __ARCH_FORCE_SHMLBA
> +	/* Is the mapping cache-coherent? */
> +	if ((pgoff ^ linear_page_index(vma, start)) &
> +	    ((SHMLBA-1) >> PAGE_SHIFT))
> +		goto out;
> +#endif


I think this will cause problems on PA-RISC.  The reason is we have an  
additional offset
for mappings.  See get_offset() in sys_parisc.c.

SHMLBA is 4 MB on PA-RISC.  If we limit ourselves to aligned mappings,  
we run out of
memory very quickly.  Even with our current implementation, we fail  
the perl locales test
with locales-all installed.

Dave
--
John David Anglin	dave.anglin@bell.net



