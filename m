From: David Miller <davem@davemloft.net>
Date: Wed, 22 Jul 2020 01:22:48 +0000
Subject: Re: [PATCH] SPARC: backoff.h: delete a duplicated word
Message-Id: <20200721.182248.277146641003054082.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200721210033.15408-1-rdunlap@infradead.org>
In-Reply-To: <20200721210033.15408-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rdunlap@infradead.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 21 Jul 2020 14:00:33 -0700

> Drop the repeated word "other".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks Randy.

> @David:
> In arch/sparc/include/asm/cpu_type.h, line 12,
> is that duplicated "ploos" correct?
>   sun4u       = 0x03, /* V8 ploos ploos */

Yes, it's a funny way of saying "++" :-)
