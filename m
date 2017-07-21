From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2017 03:06:55 +0000
Subject: Re: [PATCH v1 0/4] Context domains
Message-Id: <20170721.040655.1839487789481890275.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500601861-203232-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1500601861-203232-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2017 03:50:05 +0100 (WEST)

> Having to allocate a full trap frame just to TLB flush one page or an
> MM is a serious regression.
> 
> Next, allocating a whole new data structure and clearing it out on
> every new address creation is going to be a significant new cost as
> well.

So, just thinking out loud:

1) You can retain the cross call TLB flush assembler by passing in the
   appropriate context value for each individual cpu from the cross
   call dispatcher.

2) If you have some constant bounds on the upper number of context
   domains, you can simply inline them into the existing mmu_context
   structure.  This avoids the memory allocation per mm creation.

You can also make the context domain salting extremely cheap.
Perhaps something like "(cpuid>>x) & y".

No, you won't map cores to context domains so precisely like the
code does now, but you will make up for it in code simplicity and
overall new costs added by these changes for the more common
cases.

I suggest "(cpuid>>x) & y" and a very small number of context domains
(which determines 'y') because we don't need something perfect, we
need something which divides the problem by some order of magnitude.

The hash of locks caught my eye as well.  I think you don't need that
and we really steer clear of hashed spinlock tables in the Linux
kernel because they never scale properly.

Instead, I think you can use something like RCU to provide the
necessary synchronization.  So you could first make sure X isn't
referenced on the local cpu any more, and then do call_rcu() to do the
actual clearing of the bitmap which allows X to be allocated again.

Just some ideas...
