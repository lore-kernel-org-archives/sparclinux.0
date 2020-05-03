From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 03 May 2020 03:11:28 +0000
Subject: Re: [PATCH V1 09/10] arch/kmap: Define kmap_atomic_prot() for all arch's
Message-Id: <20200503031127.GA685597@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200430203845.582900-1-ira.weiny@intel.com>
 <20200430203845.582900-10-ira.weiny@intel.com>
 <20200501023734.GF23230@ZenIV.linux.org.uk>
 <20200501032020.GG23230@ZenIV.linux.org.uk>
In-Reply-To: <20200501032020.GG23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Fri, May 01, 2020 at 04:20:20AM +0100, Al Viro wrote:
> On Fri, May 01, 2020 at 03:37:34AM +0100, Al Viro wrote:
> > On Thu, Apr 30, 2020 at 01:38:44PM -0700, ira.weiny@intel.com wrote:
> > 
> > > -static inline void *kmap_atomic(struct page *page)
> > > +static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
> > >  {
> > >  	preempt_disable();
> > >  	pagefault_disable();
> > >  	if (!PageHighMem(page))
> > >  		return page_address(page);
> > > -	return kmap_atomic_high(page);
> > > +	return kmap_atomic_high_prot(page, prot);
> > >  }
> > > +#define kmap_atomic(page)	kmap_atomic_prot(page, kmap_prot)
> > 
> > OK, so it *was* just a bisect hazard - you return to original semantics
> > wrt preempt_disable()...
> 
> FWIW, how about doing the following: just before #5/10 have a patch
> that would touch only microblaze, ppc and x86 splitting their
> kmap_atomic_prot() into an inline helper + kmap_atomic_high_prot().
> Then your #5 would leave their kmap_atomic_prot() as-is (it would
> use kmap_atomic_prot_high() instead).  The rest of the series plays
> out pretty much the same way it does now, and wrappers on those
> 3 architectures would go away when an identical generic one is
> introduced in this commit (#9/10).
> 
> AFAICS, that would avoid the bisect hazard and might even end
> up with less noise in the patches...

This works.  V2 coming out shortly.

Thanks for catching this,
Ira
