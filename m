From: David Miller <davem@davemloft.net>
Date: Thu, 06 Dec 2007 08:49:50 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071206.004950.17891881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 16 Nov 2007 22:17:07 +0100

> The sysrq-g output is attached, I hope you can make sense out of it.
> We'll also add some extra workload to the other machines here to try to
> trigger the bug on other CPUs, too.

I just got back from my vacation and started looking at these
dumps.  I think there might be some bug in cheetah_xcall_deliver(),
I'll try to diagnose this some more.

If you cannot reproduce this bug on non-Ultra-III systems that
would help confirm or deny my theory.  Have you been able to
trigger this on your Ultra-II machine for example?  If so, what
do the sysrq-g traces look like there?
