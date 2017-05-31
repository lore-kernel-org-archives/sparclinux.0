From: David Miller <davem@davemloft.net>
Date: Wed, 31 May 2017 16:03:30 +0000
Subject: Re: [sparc64] crc32c misbehave
Message-Id: <20170531.120330.169342845867105735.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzgaL4ew6PVek3WBsdwo6GcT0ORx=7h+6p0V3NAr8qF+w@mail.gmail.com>
        <CADxRZqzNTB1n0g1r_2rLsjifHpJ+_x1WPxNOSqEcHbi74jHi5w@mail.gmail.com>
        <20170531.115335.213691069712156732.davem@davemloft.net>
In-Reply-To: <20170531.115335.213691069712156732.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: sparclinux@vger.kernel.org, sandeen@sandeen.net, linux-crypto@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 31 May 2017 11:53:35 -0400 (EDT)

> Can you try something like disabling cpu IRQs around the crc32c() function
> in lib/libcrc32c.c?  Something like:
> 
> 	u32 retval;
> 
> 	local_irq_disable();
> 
> 	shash->tfm = tfm;
> 	shash->flags = 0;
> 	*ctx = crc;
> 
> 	err = crypto_shash_update(shash, address, length);
> 	BUG_ON(err);
> 
> 	retval = *ctx;
> 
> 	local_irq_enable();
> 
> 	return retval;

Actually you would need a spinlock, with IRQs disabled, to properly test
this theory since the TFM is shared across the entire system.

The really suspicious part of your test results is that the corrupted
checksum always evaluates to zero.
