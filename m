From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Sat, 31 Oct 2020 15:05:39 +0000
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
Message-Id: <20201031160539.Horde.n5yNbG9LoUSWqtuPQW_h3w1@messagerie.c-s.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20201029221806.189523375@linutronix.de>
 <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
 <87pn50ob0s.fsf@nanos.tec.linutronix.de>
 <87blgknjcw.fsf@nanos.tec.linutronix.de>
 <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com>
 <87sg9vl59i.fsf@nanos.tec.linutronix.de>
 <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
 <CAK8P3a3FyKTHDSAPCyP8e7UA0LN3OvAatNK_vQ3tnBsdbou4sA@mail.gmail.com>
In-Reply-To: <CAK8P3a3FyKTHDSAPCyP8e7UA0LN3OvAatNK_vQ3tnBsdbou4sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Bristot de Oliveira <bristot@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Max Filippov <jcmvbkbc@gmail.com>, Nick Hu <nickhu@andestech.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Greentime Hu <green.hu@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Paul McKenney <paulmck@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Mel Gorman <mgorman@suse.de>, David Airlie <airlied@linux.ie>, Christoph Hellwig <hch@lst.de>, linux-csky@vger.kernel.org, Russell King <linux@armlinux.org.uk>, the arch/x86 maintainers <x86@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Vincent Chen <deanbo422@gmail.com>, linux-sparc <sparclinux@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>, Linux-MM <linux-mm@kvack.org>, Ben Segall <bsegall@google.com>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-xtensa@linux-xtensa.org, Juri Lelli <juri.lelli@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>


> There are also some users on 10+ year old 32-bit netbooks or
> business laptops, both x86 and Apple G4.
> The longest-lived 32-bit embedded systems with large memory
> (other than Arm) are probably NXP QorIQ P20xx/P40xx used in
> military VME bus systems, and low-end embedded systems based
> on Vortex86.
> I'm less worried about all of these because upstream kernel
> support for ppc32 and x86-32 is already bitrotting and they will
> likely get stuck on the last working kernel before the
> TI/Renesas/NXP Arm systems do.
>

Upstream kernel support for ppc32 is bitrotting, seriously ? What do  
you mean exactly ?

ppc32 is actively supported, with recent addition of support of  
hugepages, kasan, uaccess protection, VMAP stack, etc ...

Christophe
