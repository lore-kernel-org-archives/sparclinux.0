From: Florian Westphal <fw@strlen.de>
Date: Mon, 17 Jun 2019 20:11:04 +0000
Subject: Re: [netfilter-core] [sparc64] possible circular locking / deadlock
Message-Id: <20190617201104.qv2tm5oezluyg4nv@breakpoint.cc>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqy=pCbwg6Lyio=GQ6gckR5B5Y=YQ1URPO0qn3YPAnUc0A@mail.gmail.com>
 <alpine.DEB.2.20.1906171656030.27371@blackhole.kfki.hu>
In-Reply-To: <alpine.DEB.2.20.1906171656030.27371@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Anatoly Pugachev <matorola@gmail.com>, Sparc kernel list <sparclinux@vger.kernel.org>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, debian-sparc <debian-sparc@lists.debian.org>

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu> wrote:
> >                -> #0 (&table[i].mutex){+.+.}:
> > [   11.698157]        lock_acquire+0x1a4/0x1c0
> > [   11.698165]        __mutex_lock+0x48/0x920
> > [   11.698173]        mutex_lock_nested+0x1c/0x40
> > [   11.698181]        nfnl_lock+0x24/0x40 [nfnetlink]
> > [   11.698196]        ip_set_nfnl_get_byindex+0x19c/0x280 [ip_set]
> > [   11.698207]        set_match_v1_checkentry+0x14/0xc0 [xt_set]
> 
> set_match_v1_checkentry() from ipset always assumed that it's called via 
> the old xtables/setsockopt interface. Thus it calls 
> ip_set_nfnl_get_byindex() which is then calls 
> nfnl_lock(NFNL_SUBSYS_IPSET). Here comes the circular dependency.

But isnt it a false positive?

> > [   11.698359]        CPU0                    CPU1
> > [   11.698366]        ----                    ----
> > [   11.698372]   lock(&net->nft.commit_mutex);
> > [   11.698381]                                lock(&table[i].mutex);
> > [   11.698390]                                lock(&net->nft.commit_mutex);
> > [   11.698400]   lock(&table[i].mutex);
> > [   11.698408]

AFAICS CPU0 takes the ipset subsys mutex after taking the nftables
transaction mutex (via checkentry of ipset match), while CPU1 took the
nftables subsys mutex and then the nftables transaction mutex.

The only reason why this splat is generated is because nftables and
ipset subset mutexes are currently the same from lockdep pov.

It looks like we need to extend nfnetlink to place the subsystem mutexes
in different lockdep classes.
