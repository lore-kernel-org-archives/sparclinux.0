From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2017 03:45:10 +0000
Subject: Re: [PATCH 0/2] sparc64: Use low latency path to resume idle cpu
Message-Id: <20170721.044510.1044996118554999021.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <dbe44a81-e5fd-3baf-084e-475db05ba397@oracle.com>
        <20170721.035526.1236051430538663900.davem@davemloft.net>
        <3bb6d4bb-ebf1-1a1f-9766-b02a187cbe1e@oracle.com>
In-Reply-To: <3bb6d4bb-ebf1-1a1f-9766-b02a187cbe1e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vijay.ac.kumar@oracle.com
Cc: sparclinux@vger.kernel.org, rob.gardner@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Thu, 20 Jul 2017 22:36:42 -0500

> I can give a try :). But looks to me one thing that will go wrong is
> irq accounting done in __irq_enter() and rcu_irq_enter().

Actually, the bigger problem is that scheduler_ipi() can raise a
software interrupt, and nothing will invoke it.

It's turning quite ugly to avoid the IRQ overhead, I must admit.
So ignore this for now.

In the longer term a probably cleaner way to do this is to have
a special direct version of scheduler_ipi() that invokes all the
necessary work, even the rebalance softirq, directly rather than
indirectly.
