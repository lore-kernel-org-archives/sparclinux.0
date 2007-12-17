From: Matt Mackall <mpm@selenic.com>
Date: Mon, 17 Dec 2007 14:55:54 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <20071217145554.GD19691@waste.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200712161948.42656.m.kozlowski@tuxland.pl> <200712162010.11028.m.kozlowski@tuxland.pl> <20071217021149.GC19691@waste.org> <20071216.202611.226170474.davem@davemloft.net> <20071216223917.873e34bf.akpm@linux-foundation.org>
In-Reply-To: <20071216223917.873e34bf.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, m.kozlowski@tuxland.pl, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sun, Dec 16, 2007 at 10:39:17PM -0800, Andrew Morton wrote:
> On Sun, 16 Dec 2007 20:26:11 -0800 (PST) David Miller <davem@davemloft.net> wrote:
> 
> > From: Matt Mackall <mpm@selenic.com>
> > Date: Sun, 16 Dec 2007 20:11:49 -0600
> > 
> > > But as the function doesn't actually show up in your stack trace,
> > > something else is probably wrong. So I'd also try commenting out
> > > pieces of that function until it started working.
> > 
> > Some piece of state is being indirectly corrupted and this
> > is showing up later in some unrelated operation.
> > 
> > Can someone send me this kpageflags patch under seperate
> > cover?  I'll try figure out why it farts on sparc64.
> 
> hm, non trivial.  It's the third-from-last patch in:
> 
> maps4-add-proportional-set-size-accounting-in-smaps.patch
> maps4-rework-task_size-macros.patch
> maps4-rework-task_size-macros-mips-fix.patch
> maps4-move-is_swap_pte.patch
> maps4-introduce-a-generic-page-walker.patch
> maps4-use-pagewalker-in-clear_refs-and-smaps.patch
> maps4-simplify-interdependence-of-maps-and-smaps.patch
> maps4-move-clear_refs-code-to-task_mmuc.patch
> maps4-regroup-task_mmu-by-interface.patch
> maps4-add-proc-pid-pagemap-interface.patch

Actually, you may only need these two:

> maps4-add-proc-kpagecount-interface.patch
> maps4-add-proc-kpageflags-interface.patch

-- 
Mathematics is the supreme nostalgia of our time.
