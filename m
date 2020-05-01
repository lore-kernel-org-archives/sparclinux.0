From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 01 May 2020 08:38:31 +0000
Subject: Re: [PATCH V1 04/10] arch/kunmap: Remove duplicate kunmap implementations
Message-Id: <20200501083831.GD27858@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200430203845.582900-1-ira.weiny@intel.com>
 <20200430203845.582900-5-ira.weiny@intel.com>
In-Reply-To: <20200430203845.582900-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ira.weiny@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Christian Koenig <christian.koenig@amd.com>

On Thu, Apr 30, 2020 at 01:38:39PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> All architectures do exactly the same thing for kunmap(); remove all the
> duplicate definitions and lift the call to the core.
> 
> This also has the benefit of changing kmap_unmap() on a number of
> architectures to be an inline call rather than an actual function.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
