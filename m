From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 08:40:02 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080821.014002.250729274.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 21 Aug 2008 11:04:22 +0300 (EEST)

> Othe than stack messages and backtrace selftest, the debugging options 
> in kernel hacking section have not produced anything. Turned on most of 
> them besides ftrace and debug-pagealloc and example code.

Those messages I see in your log come from CONFIG_DEBUG_STACK_USAGE.

Do you have CONFIG_DEBUG_STACK_USAGE enabled too?  That one will
catch stack overflow conditions exactly when they are about to
happen instead of some time later like CONFIG_DEBUG_STACK_USAGE.
