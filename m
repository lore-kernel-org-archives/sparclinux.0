From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 06 May 2020 06:14:10 +0000
Subject: Re: [PATCH V2 10/11] arch/kmap: Define kmap_atomic_prot() for all arch's
Message-Id: <20200506061410.GE5192@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200504010912.982044-1-ira.weiny@intel.com>
 <20200504010912.982044-11-ira.weiny@intel.com>
In-Reply-To: <20200504010912.982044-11-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ira.weiny@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Sun, May 03, 2020 at 06:09:11PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> To support kmap_atomic_prot(), all architectures need to support
> protections passed to their kmap_atomic_high() function.  Pass
> protections into kmap_atomic_high() and change the name to
> kmap_atomic_high_prot() to match.
> 
> Then define kmap_atomic_prot() as a core function which calls
> kmap_atomic_high_prot() when needed.
> 
> Finally, redefine kmap_atomic() as a wrapper of kmap_atomic_prot() with
> the default kmap_prot exported by the architectures.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
