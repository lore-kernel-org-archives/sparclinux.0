From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 19:14:04 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20150323.151404.1989243978087546169.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150323.125537.767987027704780801.davem@davemloft.net>
	<CA+55aFx0Sw4xWGNdVhcOqH2XN=Q=CNgCLS7Ru3m2Lf_T88nKHA@mail.gmail.com>
	<CA+55aFzXDxicQRZNEDaLruxackq-6NkkYk5gM1L6Ak38ggJKrQ@mail.gmail.com>
In-Reply-To: <CA+55aFzXDxicQRZNEDaLruxackq-6NkkYk5gM1L6Ak38ggJKrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Mar 2015 10:12:30 -0700

> Oh well. I'm actually somewhat surprised this didn't hit anything
> else. Doesn't networking also end up doing overlapping memmove() on
> the skb data occasionally?

The only case I can think of is when {en,de}capsulating VLANs in
software.

But those are really small header sized copies, and would never
trigger the unrolled loop which requires len >= 128.

A quick grep shows something similar for wireless WEP/WPA, but not
only are these small copies too but I don't have any wireless on
any of my sparc boxes :-)

It really is just SLAB/SLUB with large NR_CPU configurations.
