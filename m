From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 20 Jun 2005 02:20:34 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <20050619.192034.74747276.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Sun, 19 Jun 2005 20:07:12 -0600

> I've been able to confirm this behavior on 2.4.31 (using
> iptables 1.2.11 and 1.3.1) and was able to load more than 10,000 rules
> in 2.6.12-rc3 before I gave up.

64-bit or 32-bit userland binaries?

He could be hitting the kmalloc() limit via the netfilter
32-bit userland compat code in:

       arch/sparc64/kernel/sys_sparc32.c:do_netfilter_replace()

You have to make sure you replicate the netfilter commands
his system is running, in order to determine where the limit
is actually coming from.
