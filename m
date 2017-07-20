From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2017 23:50:58 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <20170720.165058.265705691145031932.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: jane.chu@oracle.com
Date: Thu, 20 Jul 2017 16:42:18 -0700

> While I get a map-unmap test ready to run, I noticed the "rcu_sched
> kthread starved"

I get that with the current tree, it's not due to my patch.

> I'm not sure how your patch could have anything to do with it,

It doesn't.

Ignore the warnings, it happens on my system even when it's idle.

Can you post your map-unmap test?  Maybe we can add it under
tools/testing/selftests/ in the kernel tree.

