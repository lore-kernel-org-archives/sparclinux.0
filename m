From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 24 Mar 2006 06:26:42 +0000
Subject: Re: sparc32 smp patch
Message-Id: <20060323.222642.84670854.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <43D7F9B5.9050707@mc.net>
In-Reply-To: <43D7F9B5.9050707@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Wed, 25 Jan 2006 16:20:37 -0600

> It may not be ready for upstream merging yet, but it would be helpful to
> get some review and testing of it.
> 
> Todo items:
>  - IRQ_INPROGRESS flag - use sparc64 irq buckets, or generic irq_desc?
>  - sun4d
>  - re-indent large chunks of sun4m_smp.c
>  - some places assume sequential cpu numbering (i.e. 0,1 instead of 0,2)
> 
> Last I checked (with 2.6.14), random programs segfault with dual
> HyperSPARC.  And with SuperSPARC II's, it seems stable but will
> eventually die from a write lock error (wrong lock owner or something).
> 
> I haven't tried the HyperSPARC + highmem combination recently, so that
> may still be a problem.

I think this is better than no progress at all, so I'm going
to put this patch into 2.6.17

Thanks Bob, and please provide "Signed-off-by: " lines in the
future.
