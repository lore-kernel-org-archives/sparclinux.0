From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 19 Aug 2004 15:00:08 +0000
Subject: Re: Patch - Sun4d SMP now boots
Message-Id: <20040819150008.GO11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408191358400.2910@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408191358400.2910@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 19 August 2004 3:12 pm, William Lee Irwin III wrote:
>> One major question is *WHY* spin_lock_bh() vs. spin_lock_irqsave()
>> works. Only trouble there is that we can't see what happens after
>> spin_lock_irqsave() very easily. One rather large possibility is that
>> since disabling bh's doesn't disable interrupts, some smp_call_function()
>> or similar that would deadlock if interrupts weren't disabled suddenly
>> appears to work and/or works for some limited cases...

On Thu, Aug 19, 2004 at 03:49:18PM +0100, C.Newport wrote:
> Two possible clues :-
> Other architectures have 2 sets of functions here, one for use before it is
> safe to allow SMP with IRQs.
> sun4d_irq.c is almost certainly involved, and does not appear to deal with
> SMP in a sane manner. Compare with sun4m_irq.c which is much newer.
> This is consistent with the observed failure, the system locks as soon as
> a write to disk happens. Pasi also noted failures as soon as interrupts 
> happen.

Sounds like the analogous rewrite must happen for sun4d, then. I'll look
into that... some kind of sun4d hacking-level access may need to happen,
or someone may have to look into this on my behalf.

-- wli
