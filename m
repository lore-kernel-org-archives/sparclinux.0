From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 01 May 2020 08:44:46 +0000
Subject: sparc-related comment, to Re: [PATCH V1 07/10] arch/kmap: Ensure kmap_prot visibility
Message-Id: <20200501084446.GG27858@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200430203845.582900-1-ira.weiny@intel.com>
 <20200430203845.582900-8-ira.weiny@intel.com>
In-Reply-To: <20200430203845.582900-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ira.weiny@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Christian Koenig <christian.koenig@amd.com>

> --- a/arch/sparc/mm/highmem.c
> +++ b/arch/sparc/mm/highmem.c
> @@ -33,6 +33,7 @@
>  #include <asm/vaddrs.h>
>  
>  pgprot_t kmap_prot;
> +EXPORT_SYMBOL(kmap_prot);

Btw, I don't see why sparc needs this as a variable, as there is just
a single assignment to it.

If sparc is sorted out we can always make it a define, and use a define
for kmap_prot that defaults to PAGE_KERNEL, avoiding a little
more duplication.
