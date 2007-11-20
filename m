From: David Miller <davem@davemloft.net>
Date: Tue, 20 Nov 2007 06:09:34 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071119.220934.03199966.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 16 Nov 2007 22:17:07 +0100

> first the good news:
> The U60 here still building and working fine, also I didn't hear any bad
> news from lebrun.d.o.
> 
> the not so good news:
> the v880 (4x US III) here was hit by a stuck process again, after
> running fine for some time now. But the machine didn't freeze, one CPU
> was running at 100%, but otherwise the machine was responsible.
> 
> I think I'll also run a full diag in service mode to make it's not a CPU
> bug.
> The sysrq-g output is attached, I hope you can make sense out of it.
> We'll also add some extra workload to the other machines here to try to
> trigger the bug on other CPUs, too.

I'll look into this when I get a chance, thanks for the report.

I'm leaving for a 2 week trip on Wednesday, so I might not be able
to look into this until early December.

Thanks.
