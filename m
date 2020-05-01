From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 01 May 2020 17:18:28 +0000
Subject: Re: [PATCH V1 00/10] Remove duplicated kmap code
Message-Id: <20200501171828.GA673260@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200430203845.582900-1-ira.weiny@intel.com>
 <20200501085456.GL27858@infradead.org>
In-Reply-To: <20200501085456.GL27858@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Christian Koenig <christian.koenig@amd.com>

On Fri, May 01, 2020 at 01:54:56AM -0700, Christoph Hellwig wrote:
> In addition to the work already it the series, it seems like
> LAST_PKMAP_MASK, PKMAP_ADDR and PKMAP_NR can also be consolidated
> to common code.

Agreed, I mentioned in the cover letter there are similarities...

> 
> Also kmap_atomic_high_prot / kmap_atomic_pfn could move into common
> code, maybe keyed off a symbol selected by the actual users that
> need it.  It also seems like it doesn't actually ever need to be
> exported.

...  but these are not as readily obvious, at least to me.  I do see a pattern
but the differences seemed subtle enough that it would take a while to ensure
correctness.  So I'd like to see this series go in and build on it.

> 
> This in turn would lead to being able to allow io_mapping_map_atomic_wc
> on all architectures, which might make nouveau and qxl happy, but maybe
> that can be left for another series.

I agree, that this should be follow on patches.  I still need to fix the
bisect-ability and I don't want to bog down 0-day with a longer series.

Thanks for the review!
Ira
