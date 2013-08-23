From: David Miller <davem@davemloft.net>
Date: Fri, 23 Aug 2013 05:23:23 +0000
Subject: Re: [RFC] sparc64: Duplicate kernel text on every NUMA node
Message-Id: <20130822.222323.1624053762400489366.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <8311377178790@web14g.yandex.ru>
In-Reply-To: <8311377178790@web14g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 22 Aug 2013 17:39:50 +0400

> There is an idea to duplicate kernel text on every NUMA node. Node
> access is the fastest, so this should help to execute kernel text a
> little faster.

Interesting change.

What other major architectures do this?
