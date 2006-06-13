From: Bob Breuer <breuerr@mc.net>
Date: Tue, 13 Jun 2006 16:09:34 +0000
Subject: Re: vmalloc can clobber framebuffer on sparc32
Message-Id: <448EE33E.3060500@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <448D0D0D.8080606@mc.net>
In-Reply-To: <448D0D0D.8080606@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Mark Fortescue wrote:
> Hi,
> 
> Why don't you just move the VMALLOC area to say FC000000. I did this on my
> sparc32 system to alow me to debug some PROM Console/CG3 issues. I did not
> observe any failures/anomalies with this and is gets around any problems
> with the PROM memory mapping of frame buffers.

Sounds like a good idea, but SRMMU_NOCACHE occupies FC000000, and then
highmem mappings (PKMAP_BASE) are after that.  However, if the nocache
and highmem mappings are not used on sun4c, we may be able to move them
below F0000000.

> It also has the advantage of alowing you to increase the size of the
> VMALLOC area should this be required.
> 
> Ideally, the area should be dynamically allocated based on the required
> size and the PROM allocations on boot but this may be somewhat
> impractical in real life.
> 
> Regards
> 	Mark Fortescue.
> 
