From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 05 Feb 2005 03:19:43 +0000
Subject: Re: Xorg does not work on sparc32 in 2.6 (except on cg14)
Message-Id: <1107573583.3951.225.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1107553760.3951.211.camel@localhost.localdomain>
In-Reply-To: <1107553760.3951.211.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2005-02-04 at 17:15 -0800, William Lee Irwin III wrote:
> On Fri, Feb 04, 2005 at 04:40:27PM -0600, Tom 'spot' Callaway wrote:
> > Resending, since I think Evolution ate it. Apologies if this shows up twice.
> > With a working pte_read, and VMALLOC_START set sanely, the next major
> > bug that Aurora users have noticed is that Xorg does not work on sparc32
> > hardware running 2.6, with one exception: Bob Breuer has been able to
> > get the cg14 to work.
> > My SS20 with a CG6 (TGX+) works fine in 2.4. When I attempt to run Xorg
> > in 2.6 (specifically, 2.6.11-rc2-bk3), the Xorg.0.log claims that it is
> > running, but the kernel has actually oopsed:
> > kernel BUG at arch/sparc/mm/srmmu.c:140!
> 
> How much do the vmalloc_start patches fix here?

The vmalloc_start patches don't affect this problem at all. The results
are identical in all of the cases:

- VMALLOC_START at 0xfe600000
- VMALLOC_START reset to 0xfe300000
- VMALLOC_START set to vmalloc_start_addr (which gets set to 0xfe300000
on sun4m, and 0xfe600000 on sun4/sun4c) as in the patch I sent to the
list today.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

