From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 19 Aug 2004 14:12:13 +0000
Subject: Re: Patch - Sun4d SMP now boots
Message-Id: <20040819141213.GM11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408191358400.2910@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408191358400.2910@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 19, 2004 at 02:32:47PM +0100, Chris Newport wrote:
> I have now applied the patch posted to the list by Pasi Pirhonen
> on 19Nov2003. This needs to be applied AFTER the patches from Thomas.
> More work is needed to get rid of the previously reported compiler
> warnings in the same function before this is fit to be submitted, but
> I will have to leave that to those who understand what they are doing
> <B-).
> This now boots and runs, but is horribly unstable.

Okay, this is great news. I know the spin_lock_bh() is wrong, but it
gets us to a point where we can actually do something and we actually
have enough to reproduce all this.

One major question is *WHY* spin_lock_bh() vs. spin_lock_irqsave()
works. Only trouble there is that we can't see what happens after
spin_lock_irqsave() very easily. One rather large possibility is that
since disabling bh's doesn't disable interrupts, some smp_call_function()
or similar that would deadlock if interrupts weren't disabled suddenly
appears to work and/or works for some limited cases...

This is in my queue also, though preferably some explanation of what's
going on with this (e.g. the real issue, maybe a better fix) will
happen instead.


-- wli
