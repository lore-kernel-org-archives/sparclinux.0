From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 06 May 2020 20:33:39 +0000
Subject: Re: [PATCH V2 08/11] arch/kmap: Ensure kmap_prot visibility
Message-Id: <20200506203339.GG1084880@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200504010912.982044-1-ira.weiny@intel.com>
 <20200504010912.982044-9-ira.weiny@intel.com>
 <20200506061326.GD5192@infradead.org>
In-Reply-To: <20200506061326.GD5192@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Tue, May 05, 2020 at 11:13:26PM -0700, Christoph Hellwig wrote:
> On Sun, May 03, 2020 at 06:09:09PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > We want to support kmap_atomic_prot() on all architectures and it makes
> > sense to define kmap_atomic() to use the default kmap_prot.
> > 
> > So we ensure all arch's have a globally available kmap_prot either as a
> > define or exported symbol.
> 
> FYI, I still think a
> 
> #ifndef kmap_prot
> #define kmap_prot PAGE_KERNEL
> #endif
> 
> in linux/highmem.h would be nicer.  Then only xtensa and sparc need
> to override it and clearly stand out.

That would be nice...  But...  in this particular patch kmap_prot needs to be
in arch/microblaze/include/asm/highmem.h to preserve bisect-ability.

So there would be an inversion with this define and the core #ifndef...

I like the change but I'm going to add this change as a follow on patch because
at the end of the series microblaze no longer needs this.

If this is reasonable could I get a review on this patch to add to the next
series?

Ira
