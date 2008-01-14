From: Patrick McHardy <kaber@trash.net>
Date: Mon, 14 Jan 2008 06:09:22 +0000
Subject: Re: sparc oops in ip_fast_csum
Message-Id: <478AFC92.50508@trash.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080105094400.GH27894@ZenIV.linux.org.uk> <E1JBJHA-0000hy-00@gondolin.me.apana.org.au> <20080106020214.GQ27894@ZenIV.linux.org.uk> <20080106041430.GA3784@gondor.apana.org.au>
In-Reply-To: <20080106041430.GA3784@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, m.kozlowski@tuxland.pl, davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Patrick, please have a look at the former.  In fact it's not just
> that ihl may be bogus (which might be harmless as long as the REJECT
> hook only gets called from within the IP stack), I think REJECT would
> also do the wrong thing if the packet had IP options.  So perhaps we
> should just make it create a packet from scratch rather than being
> too clever in reusing the old one.


We currently silently drop packets with IP options in the reject
target. The length check should be fine since its only called
through the IP stack or bridge netfilter, which replicates the
IP stack checks.

But I agree to your suggestion, that will allow us to properly
handle packets with IP options. I'll take care of this.
