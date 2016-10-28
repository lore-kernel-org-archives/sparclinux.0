From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 28 Oct 2016 21:26:57 +0000
Subject: Re: Crash in -next due to 'mm/vmalloc: replace opencoded 4-level page walkers'
Message-Id: <20161028142657.3f4b23114737462043a4e109@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20161028171825.GA15116@roeck-us.net>
	<20161028201548.GA16450@nuc-i3427.alporthouse.com>
In-Reply-To: <20161028201548.GA16450@nuc-i3427.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>

On Fri, 28 Oct 2016 21:15:48 +0100 Chris Wilson <chris@chris-wilson.co.uk> wrote:

> > Bisect points to commit 0c79e3331f08 ("mm/vmalloc: replace opencoded 4-level
> > page walkers"). Reverting this patch fixes the problem.
> 
> Hmm, apply_to_pte_range() has a BUG_ON(pmd_huge(*pmd)) but the old
> vmap_pte_range() does not and neither has the code to handle that case.
> Presuming that the BUG_ON() there is actually meaningful.

Thanks, I'll drop mm-vmalloc-replace-opencoded-4-level-page-walkers.patch for now.
