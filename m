From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 14 Jul 2008 02:37:09 +0000
Subject: Re: Remove init_mm export as planned for 2.6.26
Message-Id: <20080714023709.GA12795@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080711201959.GA1007@redhat.com> <20080711193046.89b4b68a.akpm@linux-foundation.org>
In-Reply-To: <20080711193046.89b4b68a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Fri, Jul 11, 2008 at 07:30:46PM -0700, Andrew Morton wrote:
> > -EXPORT_UNUSED_SYMBOL(init_mm); /* will be removed in 2.6.26 */
> >  
> >  /*
> >   * Initial thread structure.
> > 
> 
> grep -r init_mm include/asm-sparc64
> 
> This patch used to break stuff.  I'm not aware that anything was done
> to prevent this.

Dave's patch only unexprts it on x86, which per defintion can't break
sparc64 which is known to need this export.  It would be nice if someone
could do a little audit which architectures require it in addition to
sparc64 and remove it fromm all others.
