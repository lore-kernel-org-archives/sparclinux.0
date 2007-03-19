From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Mon, 19 Mar 2007 16:40:36 +0000
Subject: Re: [Systems] Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <45FEBD04.9060907@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
In-Reply-To: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

> Ok, I think the following patch is the bug fix.  I'm running a bunch
> of further stress testing to make sure this is indeed the cause of
> these crashes.
> 
> Let me know if you can still trigger the bug with this patch
> applied, thanks!
> 
> Assuming all goes well I'll push this upstream to Linus and
> also to the -stable 2.6.x branches.
> 
> [SPARC64]: store-init needs trailing membar.
> 
> The manual says that it is required and we actually have crash reports
> where loads see stale data due to not having membars here.
> 
> In one case the networking does:
> 
> 	memset(skb, 0, offsetof(struct sk_buff, truesize));
> 
> and then some code later checks skb->nohdr for zero, but it's still
> the value that was there before the memset().

Been running some intensive network loads on our T2000 for the last 
couple of hours and indeed this patch seems to fix it. Previously it 
would trigger an oops in less than 10 minutes.
Thanks.

-- 
Gustavo Zacarias
Gentoo/SPARC monkey
