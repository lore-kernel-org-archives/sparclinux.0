From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 27 Apr 2020 06:25:00 +0000
Subject: Re: [PATCH 4/5] arch/kmap_atomic: Consolidate duplicate code
Message-Id: <20200427062500.GA32152@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200426055406.134198-1-ira.weiny@intel.com>
 <20200426055406.134198-5-ira.weiny@intel.com>
 <20200426072642.GB22024@infradead.org>
 <20200427011630.GC135929@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200427011630.GC135929@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ira Weiny <ira.weiny@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Sun, Apr 26, 2020 at 06:16:30PM -0700, Ira Weiny wrote:
> > That might require to support
> > kmap_atomic_prot everywhere first, which sounds like a really good
> > idea anyway, and would avoid the need for strange workaround in drm.
> 
> Having a kmap_atomic_prot() seems like a good idea.  But I'm not exactly sure
> why CONFIG_x86 is being called out specifically in the DRM code?

Probably because it only existed on x86 back then.  And drm has a
tendency of working around core problems with hacks instead of doing
the fairly easy fixups.
