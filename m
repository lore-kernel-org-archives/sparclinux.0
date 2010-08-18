From: David Miller <davem@davemloft.net>
Date: Wed, 18 Aug 2010 02:14:24 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100817.191424.183031381.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100817.180325.104051399.davem@davemloft.net>
	<AANLkTikQ1dGw0aO10_ZwmVEc-JAVhB==3HS7SrWycE49@mail.gmail.com>
	<AANLkTimZ3rhX2AzPExEGfRCXiFNN-BGOWRKqL241-qNa@mail.gmail.com>
In-Reply-To: <AANLkTimZ3rhX2AzPExEGfRCXiFNN-BGOWRKqL241-qNa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@au.ibm.com, benh@kernel.crashing.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Aug 2010 18:59:17 -0700

> In commit 86fa04b8742ac681d470786f55e2403ada0075b2 you fix the return
> type, but you still have the wrong _argument_ type:
> 
>   extern void atomic64_add(int, atomic64_t *);
>   extern void atomic64_sub(int, atomic64_t *);
>   extern long atomic64_add_ret(int, atomic64_t *);
>   extern long atomic64_sub_ret(int, atomic64_t *);

Thanks, I'll fix that up.

> I merged your pull request, but you've got some fixing up to do,
> methinks. I also really think you need to make your rwsem's use 64-bit
> values on sparc64, because otherwise you can overflow the mmap_sem by
> having more than 65536 threads doing page-faults (on 32-bit, having
> more than 2**16 threads in one process is unlikely to work for other
> reasons, like just pure stack usage, so we don't really care about the
> 32-bit case)

I have a patch to do this already, just need to test it.

You should bug the powerpc folks too :-)
