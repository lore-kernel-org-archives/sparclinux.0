From: Pete Zaitcev <zaitcev@redhat.com>
Date: Fri, 13 Feb 2004 05:41:55 +0000
Subject: Re: RFC: [sparc32] atomic_t is 32 bits
Message-Id: <20040212214155.0ffb2484.zaitcev@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040213052029.GD22176@foobazco.org>
In-Reply-To: <20040213052029.GD22176@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 12 Feb 2004 21:20:29 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> This patch steals the atomic_t implementation from parisc.  I've also
> left the existing implementation in as atomic24, primarily because
> it's tightly woven into the semaphores.

> +#define ATOMIC_HASH(a)	(&__atomic_hash[(((unsigned long)a)>>8) & (ATOMIC_HASH_SIZE-1)])
> +extern spinlock_t __atomic_hash[ATOMIC_HASH_SIZE];

> +static inline void atomic_set(atomic_t *v, int i)
> +{
> +	unsigned long flags;
> +	spin_lock_irqsave(ATOMIC_HASH(v), flags);
> +
> +	v->counter = i;
> +
> +	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
> +}

This is bigger than what I would leave inline. I have no idea
what willy and prumpf thought when they did it this way.
The Linux code is all infested with atomics, so there may be savings.
Your call though.

The rest looks great.

-- Pete
