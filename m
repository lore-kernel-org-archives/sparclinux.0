From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 26 Apr 2020 22:23:34 +0000
Subject: Re: [PATCH 2/5] arch/kmap: Remove redundant arch specific kmaps
Message-Id: <20200426222333.GA135929@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200426055406.134198-1-ira.weiny@intel.com>
 <20200426055406.134198-3-ira.weiny@intel.com>
 <20200426071715.GA22024@infradead.org>
In-Reply-To: <20200426071715.GA22024@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Sun, Apr 26, 2020 at 12:17:15AM -0700, Christoph Hellwig wrote:
> On Sat, Apr 25, 2020 at 10:54:03PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The kmap code for all the architectures is almost 100% identical.
> > 
> > Lift the common code to the core.  Use ARCH_HAS_KMAP to indicate if an
> > arch needs a special kmap.
> 
> Can you add a kmap_flush_tlb hook that csky and mips define, and the
> just entirely consolidate the code instead?

Sure that seems to work.

Ira
