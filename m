From: David Miller <davem@davemloft.net>
Date: Fri, 16 Apr 2010 23:17:44 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100416.161744.257659239.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 17 Apr 2010 01:14:12 +0200

> Hmm, just a random idea: do you think it could be due to stack overflows?
> Because the function graph eats more stack by digging to function graph
> handlers, ring buffer, etc...
> 
> It diggs further than what is supposed to happen without tracing.

I have mcount checking for stack-overflow by hand in assembler
during these tests, it even knows about the irq stacks.

And those checks are not triggering.
