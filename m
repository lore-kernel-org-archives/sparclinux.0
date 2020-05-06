From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 06 May 2020 20:25:14 +0000
Subject: Re: [PATCH V2 05/11] {x86,powerpc,microblaze}/kmap: Move preempt disable
Message-Id: <20200506202514.GF1084880@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200504010912.982044-1-ira.weiny@intel.com>
 <20200504010912.982044-6-ira.weiny@intel.com>
 <20200506061113.GA5192@infradead.org>
In-Reply-To: <20200506061113.GA5192@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Tue, May 05, 2020 at 11:11:13PM -0700, Christoph Hellwig wrote:
> On Sun, May 03, 2020 at 06:09:06PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > During this kmap() conversion series we must maintain bisect-ability.
> > To do this, kmap_atomic_prot() in x86, powerpc, and microblaze need to
> > remain functional.
> > 
> > Create a temporary inline version of kmap_atomic_prot within these
> > architectures so we can rework their kmap_atomic() calls and then lift
> > kmap_atomic_prot() to the core.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V1:
> > 	New patch
> > ---
> >  arch/microblaze/include/asm/highmem.h | 11 ++++++++++-
> >  arch/microblaze/mm/highmem.c          | 10 ++--------
> >  arch/powerpc/include/asm/highmem.h    | 11 ++++++++++-
> >  arch/powerpc/mm/highmem.c             |  9 ++-------
> >  arch/x86/include/asm/highmem.h        | 11 ++++++++++-
> >  arch/x86/mm/highmem_32.c              | 10 ++--------
> >  6 files changed, 36 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/microblaze/include/asm/highmem.h b/arch/microblaze/include/asm/highmem.h
> > index 0c94046f2d58..ec9954b091e1 100644
> > --- a/arch/microblaze/include/asm/highmem.h
> > +++ b/arch/microblaze/include/asm/highmem.h
> > @@ -51,7 +51,16 @@ extern pte_t *pkmap_page_table;
> >  #define PKMAP_NR(virt)  ((virt - PKMAP_BASE) >> PAGE_SHIFT)
> >  #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
> >  
> > -extern void *kmap_atomic_prot(struct page *page, pgprot_t prot);
> > +extern void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
> > +void *kmap_atomic_prot(struct page *page, pgprot_t prot)
> 
> Shouldn't this be marked inline?

Yes Thanks.  Done.

> 
> The rest looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,
Ira
