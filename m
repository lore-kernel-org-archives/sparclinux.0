From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 04 May 2020 05:04:47 +0000
Subject: Re: [PATCH V2 00/11] Subject: Remove duplicated kmap code
Message-Id: <20200504050447.GA979899@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200504010912.982044-1-ira.weiny@intel.com>
 <20200504013509.GU23230@ZenIV.linux.org.uk>
In-Reply-To: <20200504013509.GU23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Mon, May 04, 2020 at 02:35:09AM +0100, Al Viro wrote:
> On Sun, May 03, 2020 at 06:09:01PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The kmap infrastructure has been copied almost verbatim to every architecture.
> > This series consolidates obvious duplicated code by defining core functions
> > which call into the architectures only when needed.
> > 
> > Some of the k[un]map_atomic() implementations have some similarities but the
> > similarities were not sufficient to warrant further changes.
> > 
> > In addition we remove a duplicate implementation of kmap() in DRM.
> > 
> > Testing was done by 0day to cover all the architectures I can't readily
> > build/test.
> 
> OK...  Looking through my old notes on kmap unification (this winter, never
> went anywhere),
> 
> * arch/mips/mm/cache.c ought to use linux/highmem.h, not asm/highmem.h
> I suspect that your series doesn't build on some configs there.  Hadn't
> verified that, though.

Yes patch 6 makes the change because kmap_atomic() was no longer declared in
asm/highmem.h.  I'm pretty sure 0-day caught that ...  but I seem to remember
noticing some oddness in that file and I did go through it by hand.

> 
> * kmap_atomic_to_page() is dead, but not quite gone - csky and nds32 brought
> the damn thing back (nds32 - only an extern).  It needs killin'...

Easy enough. Added as a follow on patch.

> 
> * parisc is (arguably) abusing kunmap()/kunmap_atomic() for cache flushing.
> Replace the bulk of its highmem.h with
> #define ARCH_HAS_FLUSH_ON_KUNMAP
> #define arch_before_kunmap flush_kernel_dcache_page_addr
> and have default kunmap()/kunmap_atomic() do
> #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> 	arch_before_kunmap(page_address(page));
> #endif
> and
> #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> 	arch_before_kunmap(addr);
> #endif
> resp.  Kills ARCH_HAS_KMAP along with ifdefs on it, makes parisc use somewhat
> less hacky.

Agreed.  Done in a follow on patch.

> 
> I'd suggest checking various configs on mips - that's likely to cause headache.
> Said that, my analysis of include chains back then is pretty much worthless
> by now - I really hate the amount of indirect include chains leading to that
> sucker on some, but not all configs ;-/  IIRC, the proof that everything
> using kmap*/kunmap* would pull linux/highmem.h regardless of config took several
> hours of digging, ran for several pages and had been hopelessly brittle.
> arch/mips/mm/cache.c was the only exception caught by it, but these days
> there might be more.

Grepping for 'asm/highmem.h' and investigations don't reveal any issues...  But
you do have me worried.  That said 0-day has been crunching on multiple
versions of this series without issues such as this (save the mips issue
above).

I have to say it would be nice if the relation between linux/highmem.h and
asm/highmem.h was more straightforward.

Ira
