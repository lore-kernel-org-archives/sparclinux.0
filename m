From: David Miller <davem@davemloft.net>
Date: Mon, 19 Apr 2010 19:56:41 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100419.125641.58434854.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 19 Apr 2010 21:52:47 +0200

> On Mon, Apr 19, 2010 at 01:15:55AM -0700, David Miller wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Mon, 19 Apr 2010 00:56:13 -0700 (PDT)
>> 
>> > Another idea is to decrement the ->disabled counter after the
>> > local_irq_restore().  Yes, we might lose IRQ handler traces which
>> > occur between the local_irq_restore() and the counter decrment, but we
>> > would also be completely immune to recursion problems.
>> 
>> So I just gave this a try and I still get the crashes I've
>> been seeing with the non-graph function tracer, oh well :-)
> 
> 
> Are you using the pause_graph_tracing() thing on the function
> tracer? If so it won't work as it only applies to the function
> graph tracer.

No, I simply moved the atomic_dec() below the local_irq_restore()
as stated in the first paragraph above :-)
