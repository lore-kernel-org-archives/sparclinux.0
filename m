From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Apr 2006 23:14:50 +0000
Subject: Re: Parallel port problems on Sun Ultra10
Message-Id: <20060410.161450.66154943.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1144596830.4439295e52873@imp1-g19.free.fr>
In-Reply-To: <1144596830.4439295e52873@imp1-g19.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christophe Jacquet <jacquetc@free.fr>
Date: Mon, 10 Apr 2006 17:36:48 +0200

> I have a few updates on the problem.
> 
> 1) Here is a rough "stack trace" of the crash:
> It happens in the function parport_write()
> Called from lp.c, function lp_write(), line 343.
> 
> 2) Setting CONFIG_PARPORT_1284 to false solves the issue.

Thanks for tracking this down so far, I'll try to figure out
what's going wrong.
