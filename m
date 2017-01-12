From: David Miller <davem@davemloft.net>
Date: Thu, 12 Jan 2017 21:47:31 +0000
Subject: Re: [PATCH] tcp: fix tcp_fastopen unaligned access complaints on sparc
Message-Id: <20170112.164731.720625943370044951.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <131ec7b7-5b74-2545-8bf7-92812443a876@oracle.com>
        <20170112.161852.1469407145449781531.davem@davemloft.net>
        <1484256990.13165.6.camel@edumazet-glaptop3.roam.corp.google.com>
In-Reply-To: <1484256990.13165.6.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.dumazet@gmail.com
Cc: shannon.nelson@oracle.com, rob.gardner@oracle.com, netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 12 Jan 2017 13:36:30 -0800

> val should be an union, so that proper alignment is enforced by one
> member.

Sure, annotating the type so that it is aligned correctly makes
sense.
