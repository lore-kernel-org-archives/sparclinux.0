From: David Miller <davem@davemloft.net>
Date: Fri, 17 Aug 2018 20:21:44 +0000
Subject: Re: [PATCH] sunhme: convert printk to pr_cont
Message-Id: <20180817.132144.829402142627411604.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.02.1808171510510.31883@file01.intranet.prod.int.rdu2.redhat.com>
        <20180817125228.25cf47ce@xeon-e3>
        <alpine.LRH.2.02.1808171606520.2385@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808171606520.2385@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: stephen@networkplumber.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 17 Aug 2018 16:08:49 -0400 (EDT)

> I'm not an expert on networking code - you can change it if it is more 
> appropriate this way.

What Stephen is asking of you doesn't require networking expertiece
and he even gave you an example of how to do it.  All you would need
to do is test is suggestion and make sure it works properly.
