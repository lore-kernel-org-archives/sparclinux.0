From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 05 Feb 2005 16:25:58 +0000
Subject: Re: Xorg does not work on sparc32 in 2.6 (except on cg14)
Message-Id: <1107620758.3951.241.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-+xRHNopSK+P/WJB+61GO"
List-Id: <sparclinux.vger.kernel.org>
References: <1107553760.3951.211.camel@localhost.localdomain>
In-Reply-To: <1107553760.3951.211.camel@localhost.localdomain>
To: sparclinux@vger.kernel.org


--=-+xRHNopSK+P/WJB+61GO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-02-04 at 22:06 -0800, David S. Miller wrote:
> On Fri, 04 Feb 2005 16:40:27 -0600
> "Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:
> 
> > My SS20 with a CG6 (TGX+) works fine in 2.4. When I attempt to run Xorg
> > in 2.6 (specifically, 2.6.11-rc2-bk3), the Xorg.0.log claims that it is
> > running, but the kernel has actually oopsed:
> 
> > Removing the if (srmmu_device_memory(pte_val(pte))) check stops the
> > oops, but it doesn't make X work. The screen goes blank, but the X
> > session never appears.
> 
> Remove the BUG() instead, and let it return ~0.  That makes it
> so that copy_page_range() just copies device ptes over instead
> of trying to lookup pages and stuff using the pfn.  The idea is
> to return a bogus pfn so that pfn_valid() on it fails.

Patch attached which does this... however, it does not fix Xorg, it
simply stops the oops. Also confirmed that a cg3 doesn't work any better
than a cg6. Any other ideas?

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

--=-+xRHNopSK+P/WJB+61GO
Content-Disposition: attachment; filename=linux-2.6.10-sparc-pte_pfnfix.patch
Content-Type: text/x-patch; name=linux-2.6.10-sparc-pte_pfnfix.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/arch/sparc/mm/srmmu.c.BAD	2005-02-05 09:30:14.238512182 -0500
+++ linux-2.6.10/arch/sparc/mm/srmmu.c	2005-02-05 09:30:50.177048694 -0500
@@ -133,11 +133,7 @@
 static unsigned long srmmu_pte_pfn(pte_t pte)
 {
 	if (srmmu_device_memory(pte_val(pte))) {
-		/* XXX Anton obviously had something in mind when he did this.
-		 * But what?
-		 */
-		/* return (struct page *)~0; */
-		BUG();
+		return ~0;
 	}
 	return (pte_val(pte) & SRMMU_PTE_PMASK) >> (PAGE_SHIFT-4);
 }

--=-+xRHNopSK+P/WJB+61GO--

