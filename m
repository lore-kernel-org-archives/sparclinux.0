From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 21 Sep 2020 06:23:37 +0000
Subject: Re: [patch RFC 01/15] mm/highmem: Un-EXPORT __kmap_atomic_idx()
Message-Id: <20200921062337.GA32081@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200919091751.011116649@linutronix.de>
 <20200919092615.879315697@linutronix.de>
In-Reply-To: <20200919092615.879315697@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, David Airlie <airlied@linux.ie>, Mel Gorman <mgorman@suse.de>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>

On Sat, Sep 19, 2020 at 11:17:52AM +0200, Thomas Gleixner wrote:
> Nothing in modules can use that.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
