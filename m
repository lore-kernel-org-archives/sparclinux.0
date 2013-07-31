From: Stephen Boyd <sboyd@codeaurora.org>
Date: Wed, 31 Jul 2013 07:16:30 +0000
Subject: Re: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to architecture independent macro
Message-Id: <20130731071630.GI8868@codeaurora.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
In-Reply-To: <1375187900-17582-3-git-send-email-B44344@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 07/30, Arpit Goel wrote:
> This patch ports PowerPC implementation of spin_event_timeout() for generic
> use. Architecture specific implementation can be added to asm/delay.h, which
> will override the generic linux implementation.
> 
> Signed-off-by: Arpit Goel <B44344@freescale.com>
> ---

We use something similar internally but it's tied specifically to
readl.

>  
> +#ifndef spin_event_timeout
> +/**
> + * spin_event_timeout - spin until a condition gets true or a timeout elapses
> + * @condition: a C expression to evalate
> + * @timeout: timeout, in microseconds
> + * @delay: the number of microseconds to delay between each evaluation of
> + *         @condition
> + *
> + * The process spins until the condition evaluates to true (non-zero) or the
> + * timeout elapses.  The return value of this macro is the value of
> + * @condition when the loop terminates. This allows you to determine the cause
> + * of the loop terminates.  If the return value is zero, then you know a
> + * timeout has occurred.
> + *
> + * This primary purpose of this macro is to poll on a hardware register
> + * until a status bit changes.  The timeout ensures that the loop still
> + * terminates even if the bit never changes.  The delay is for devices that
> + * need a delay in between successive reads.
> + *
> + * gcc will optimize out the if-statement if @delay is a constant.
> + *
> + * This is copied from PowerPC based spin_event_timeout() implementation
> + * and modified for generic usecase.
> + */
> +#define spin_event_timeout(condition, timeout, delay)		\
> +({								\
> +	typeof(condition) __ret;				\
> +	unsigned long __loops = timeout/USECS_PER_JIFFY;	\
> +	unsigned long __start = jiffies;			\
> +	while (!(__ret = (condition)) &&			\
> +		time_before(jiffies, __start + __loops + 1))	\
> +		if (delay)					\
> +			udelay(delay);				\
> +		else						\
> +			schedule();				\
> +	if (!__ret)						\
> +		__ret = (condition);				\
> +	__ret;							\
> +})

What do you do here if jiffies aren't incrementing (i.e
interrupts are disabled). The time_before() check won't work
there and it would be nice if we were able to use this in such
situations. I think powerpc gets around this by reading the
hardware timer directly?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
