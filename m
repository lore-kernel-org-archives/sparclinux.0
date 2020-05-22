From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 22 May 2020 01:35:23 +0000
Subject: Re: [PATCH] arch/{mips,sparc,microblaze,powerpc}: Don't enable pagefault/preempt twice
Message-Id: <20200522013523.GO23230@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200507150004.1423069-8-ira.weiny@intel.com>
 <20200518184843.3029640-1-ira.weiny@intel.com>
 <20200519165422.GA5838@roeck-us.net>
 <20200521172704.GF23230@ZenIV.linux.org.uk>
 <bdc8dc64-622c-3b0d-1ae1-48222cf34358@roeck-us.net>
 <20200521224612.GJ23230@ZenIV.linux.org.uk>
 <20200522004618.GA3151350@ZenIV.linux.org.uk>
 <970857bd-bb56-7b2e-833e-ca74a82fa9b5@roeck-us.net>
 <20200522012950.GN23230@ZenIV.linux.org.uk>
In-Reply-To: <20200522012950.GN23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Fri, May 22, 2020 at 02:29:50AM +0100, Al Viro wrote:
> On Thu, May 21, 2020 at 06:11:08PM -0700, Guenter Roeck wrote:
> 
> > Mainline, with:
> > 
> > qemu-system-sparc -M SS-4 -kernel arch/sparc/boot/zImage -no-reboot \
> > 	-snapshot -drive file=rootfs.ext2,format=raw,if=scsi \
> > 	-append "panic=-1 slub_debug=FZPUA root=/dev/sda console=ttyS0"
> > 	-nographic -monitor none
> > 
> > The machine doesn't really matter, though.
> 
> It does, unfortunately - try that with SS-10 and watch what happens ;-/

Ugh...  It's actually something in -m handling: -m 256 passes, -m 512
leads to that panic.
