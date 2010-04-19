From: David Miller <davem@davemloft.net>
Date: Mon, 19 Apr 2010 08:15:55 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100419.011555.28802719.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 19 Apr 2010 00:56:13 -0700 (PDT)

> Another idea is to decrement the ->disabled counter after the
> local_irq_restore().  Yes, we might lose IRQ handler traces which
> occur between the local_irq_restore() and the counter decrment, but we
> would also be completely immune to recursion problems.

So I just gave this a try and I still get the crashes I've
been seeing with the non-graph function tracer, oh well :-)
