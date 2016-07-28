From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2016 05:13:31 +0000
Subject: Re: RFC: using worker threadpool to speed up clear_huge_page() by up to 5x
Message-Id: <20160727.221331.1781806974054327287.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <b869a544-4684-ea9c-a1a6-84cfea3fec56@oracle.com>
In-Reply-To: <b869a544-4684-ea9c-a1a6-84cfea3fec56@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kishore.kumar.pusukuri@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: kpusukur <kishore.kumar.pusukuri@oracle.com>
Date: Sun, 17 Jul 2016 12:35:20 -0700

> We would welcome feedback and discussion of potential problems.
> 
> We would also like to hear ideas for other areas in the kernel where a
> similar technique could be employed. For example, we've also applied
> this idea to copy on write operations for huge pages and it achieves
> around 20x speedup.

I don't know about this.

You can only profitably do this when you have enough physical cpu
resources schedulable, and on the same NUMA node.

By the time you compute the complete answer to that entire condition
you could have completed the hugepage clear.

Also, you should experiment with simply using a dedicated hugepage
clear assembler loop for these chips.  It's really stupid to pay the
transaction cost of going in and out of the clear_user_highpage()
function N times per huge page.
