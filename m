From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 17 Aug 2005 18:33:31 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <20050817.113331.20615613.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Date: Wed, 17 Aug 2005 08:06:06 -0500

> I threw a little printk patch at Jason and we determined that to be 
> correct. In do_netfilter_replace(), on about line 2924, the call
>         krepl = (struct ipt_replace *)kmalloc(kreplsize, GFP_KERNEL);
> results in krepl being NULL after a pile of rules have been added.
> 
> I compiled a statically linked iptables binary and Jason was able to 
> add over 7k rules before he stopped it, the 32 bit iptables bombs 
> before 900 rules.
> 
> As far as changing this behaviour, I plead ignorance.

So how large was kreplsize in the failing call?
