From: David Miller <davem@davemloft.net>
Date: Tue, 24 Oct 2006 04:20:19 +0000
Subject: Re: Another 2.6.18 regression? (SunBlade1000)
Message-Id: <20061023.212019.03111598.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061024031642.GA4403@droopy.oc.cox.net>
In-Reply-To: <20061024031642.GA4403@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 23 Oct 2006 20:16:43 -0700

> This is a report by Roland Stigge (CC'd), who is trying to run 2.6.18 
> on his SunBlade1000:
> 
>   I also noticed a regression with 2.6.18-1-sparc64, but it looks
>   different from #392078. See screenshot at 
>   http://people.debian.org/~stigge/sun4u.jpg : To prevent this "Cheetah
>   error trap" ... "Irrecoverable deferred error trap", I'm using my old
>   2.6.14-2-sparc64 kernel (didn't try sth. inbetween - considered useful?).
> 
> Roland later reported that the last working kernel for his box is 
> 2.6.16, and that the latest SunBlade 100/150 patch did not help with 
> his problem in any way.

See if disabling the floppy driver fixes the problem.
