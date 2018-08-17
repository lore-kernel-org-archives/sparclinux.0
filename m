From: David Miller <davem@davemloft.net>
Date: Fri, 17 Aug 2018 19:27:51 +0000
Subject: Re: [PATCH] sunhme: convert printk to pr_cont
Message-Id: <20180817.122751.1747676728566408984.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.02.1808171510510.31883@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808171510510.31883@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, netdev@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 17 Aug 2018 15:12:22 -0400 (EDT)

> The kernel adds newlines automatically unless pr_cont is used. This patch
> converts sunhme to use pr_cont, so that the messages are not broken to
> multiple lines.
> 
> The patch also adds "\n" to a few strings that were missing it.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

"stable", are you sure?  What crash or memory corruption does these
added newlines in the kernel log cuase?

I don't think this is appropriate for -stable, sorry.

At best this is net-next material, and that tree is closed right now.

Please resubmit this when the net-next tree opens back up again,
thanks.
