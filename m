From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2011 22:24:49 +0000
Subject: Re: [PATCH] sparc32: support atomic64_t
Message-Id: <20111227.172449.2053633736228802151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111227212850.GA8174@merkur.ravnborg.org>
In-Reply-To: <20111227212850.GA8174@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2011 16:37:29 -0500 (EST)

> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 27 Dec 2011 22:28:50 +0100
> 
>> $size vmlinux (before atomic64_t support)
>>    text    data     bss     dec     hex filename
>> 3578860  134260  108781 3821901  3a514d vmlinux
>> 
>> $size vmlinux (after atomic64_t support)
>>    text    data     bss     dec     hex filename
>> 3579892  130684  108781 3819357  3a475d vmlinux
>> 
>> text increase (3579892 - 3578860) = 1032 bytes
 ...
> The data decreasing is really funny indeed, it should
> increase because of the atomic64_lock[] array in lib/atomic64.c
> 
> And the decrease isn't some trivial amount, it's more than 3K!

I was going to take a good look into this but I actually can't
reproduce this with gcc-4.6.2-7 under debian.

I tried it two ways, with CONFIG_SMP=y (and NR_CPUS2) and
with CONFIG_SMP=n.

First with CONFIG_SMP=n:

without generic atomic64:
   text    data     bss     dec     hex filename
3287520  117100   99768 3504388  357904 vmlinux
with generic atomic64:
   text    data     bss     dec     hex filename
3288317  117100   99768 3505185  357c21 vmlinux

Text increased by 797 bytes, data stayed the same.

Now with CONFIG_SMP=y:

without generic atomic64:
   text    data     bss     dec     hex filename
3470236  126468   98605 3695309  3862cd vmlinux
with generic atomic64:
   text    data     bss     dec     hex filename
3471417  126988   98605 3697010  386972 vmlinux

Text increased by 1181 bytes, data increased by 520 bytes,
as expected.

Hmmm...
