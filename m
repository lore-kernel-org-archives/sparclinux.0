From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 07 May 2020 20:52:58 +0000
Subject: Re: [PATCH V3 13/15] parisc/kmap: Remove duplicate kmap code
Message-Id: <20200507135258.f430182578c0d63b7488916e@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200507150004.1423069-1-ira.weiny@intel.com>
 <20200507150004.1423069-14-ira.weiny@intel.com>
In-Reply-To: <20200507150004.1423069-14-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ira.weiny@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Thu,  7 May 2020 08:00:01 -0700 ira.weiny@intel.com wrote:

> parisc reimplements the kmap calls except to flush it's dcache.  This is
> arguably an abuse of kmap but regardless it is messy and confusing.
> 
> Remove the duplicate code and have parisc define
> ARCH_HAS_FLUSH_ON_KUNMAP for a kunmap_flush_on_unmap() architecture
> specific call to flush the cache.

checkpatch says:

ERROR: #define of 'ARCH_HAS_FLUSH_ON_KUNMAP' is wrong - use Kconfig variables or standard guards instead
#69: FILE: arch/parisc/include/asm/cacheflush.h:103:
+#define ARCH_HAS_FLUSH_ON_KUNMAP

which is fair enough, I guess.  More conventional would be

arch/parisc/include/asm/cacheflush.h:

static inline void kunmap_flush_on_unmap(void *addr)
{
	...
}
#define kunmap_flush_on_unmap kunmap_flush_on_unmap


include/linux/highmem.h:

#ifndef kunmap_flush_on_unmap
static inline void kunmap_flush_on_unmap(void *addr)
{
}
#define kunmap_flush_on_unmap kunmap_flush_on_unmap
#endif


static inline void kunmap_atomic_high(void *addr)
{
	/* Mostly nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
	 * handles re-enabling faults + preemption */
	kunmap_flush_on_unmap(addr);
}


but I don't really think it's worth bothering changing it.	

(Ditto patch 3/15)
