From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 31 Jan 2006 04:05:53 +0000
Subject: Re: afbinit failure with 2.6.15 kernels (can no longer load Elite
Message-Id: <20060130.200553.36220050.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1138649666.7197.17.camel@polylepis.inforead.com>
In-Reply-To: <1138649666.7197.17.camel@polylepis.inforead.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 30 Jan 2006 19:15:36 -0800 (PST)

> After looking at the description of the problem, I recalled that I've seen 
> something like this reported on the debian-sparc list. It turns out that 
> we have a bug #346085 [0] filed exactly for this issue, and Ian Viemeister 
> has recently submitted a patch [1] for afbinit which reportedly fixes this 
> problem. I don't have a possibility to test it myself.
> 
> [0] http://bugs.debian.org/346085
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi/afbinit.c.diff?bug46085;msg;att=1

That patch looks good to me.

Ferris can you test that out and say if it works for you
as well?  Thanks.
