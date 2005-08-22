From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 22 Aug 2005 17:14:51 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <20050822.101451.120979829.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Mon, 22 Aug 2005 14:10:28 -0300

> David S. Miller wrote:
> 
> > You _could_ experiment with making the code there use
> > vmalloc()/vfree() instead, and if you get it working cleanly I'd be
> > happy to add such a patch to fix this.
> 
> Tested with 5000+ rules.
> Does it look clean enough?

Looks good to me, I'll pass this along to the netfilter maintainers.
