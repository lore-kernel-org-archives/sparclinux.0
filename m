From: David Miller <davem@davemloft.net>
Date: Mon, 09 Jan 2017 19:48:59 +0000
Subject: Re: Crash in -next due to 'mm/vmalloc: replace opencoded 4-level page walkers'
Message-Id: <20170109.144859.1717139396935735509.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161028171825.GA15116@roeck-us.net>
	<20170109113707.GQ19067@nuc-i3427.alporthouse.com>
In-Reply-To: <20170109113707.GQ19067@nuc-i3427.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: chris@chris-wilson.co.uk
Cc: linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Mon, 9 Jan 2017 11:37:07 +0000

> Could some mm expert explain why it is safe for mm/vmalloc.c to ignore
> huge pud/pmd that raise BUG_ON in the same code in mm/memory.c
> (vmap_pmd_range() vs apply_to_pmd_range())?
> 
> At a guess, is sparc64 covering the init_mm with a huge zero page? How
> is it then meant to be split? Something like

We map the linear physical area (PAGE_OFFSET --> PAGE_OFFSET +
max_phys_addr) using huge pages unless DEBUG_PAGEALLOC is enabled.

It is not meant to be split, and that's why we don't use huge pages
when DEBUG_PAGEALLOC is set since that requires changes to the mapping
to be possible.
