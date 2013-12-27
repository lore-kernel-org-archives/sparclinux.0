From: Matthew Wilcox <willy@linux.intel.com>
Date: Fri, 27 Dec 2013 19:33:30 +0000
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
Message-Id: <20131227193330.GE4945@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20131227180018.GC4945@linux.intel.com>
 <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl>
In-Reply-To: <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John David Anglin <dave.anglin@bell.net>
Cc: linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org

On Fri, Dec 27, 2013 at 02:13:16PM -0500, John David Anglin wrote:
> On 27-Dec-13, at 1:00 PM, Matthew Wilcox wrote:
> 
> >+#ifdef __ARCH_FORCE_SHMLBA
> >+	/* Is the mapping cache-coherent? */
> >+	if ((pgoff ^ linear_page_index(vma, start)) &
> >+	    ((SHMLBA-1) >> PAGE_SHIFT))
> >+		goto out;
> >+#endif
> 
> 
> I think this will cause problems on PA-RISC.  The reason is we have
> an additional offset
> for mappings.  See get_offset() in sys_parisc.c.

I don't think it will cause any additional problems.  The test merely
asks "Is the offset to put at this address cache-coherent with the offset
that was at this address when the mmap was established?"

> SHMLBA is 4 MB on PA-RISC.  If we limit ourselves to aligned
> mappings, we run out of
> memory very quickly.  Even with our current implementation, we fail
> the perl locales test
> with locales-all installed.

I know the large SHMLBA is problematic for PA-RISC, but I don't think
there's a lot of code out there using remap_file_pages().  code.google.com
found almost nothing, and a regular google search found only a couple
of little toys.

Have you considered measuring SHMLBA on different CPU models and
reducing it at boot time?  I know that 4MB is the architectural guarantee
(actually, I seem to remember that 16MB was the architectural guarantee,
but jsm found some CPU architects who said it would enver exceed 4MB).
I bet some CPUs have considerably lower cache coherency limits.
