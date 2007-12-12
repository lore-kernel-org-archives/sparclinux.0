From: David Miller <davem@davemloft.net>
Date: Wed, 12 Dec 2007 16:23:59 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071212.082359.211193660.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Wed, 12 Dec 2007 17:05:55 +0100

> Tested - the patch seems to fix the problem as the machine is still
> alive and working well after several hours of running the buggy aptitude
> -u in a loop.
> 
> I'll leave the kernel running and make sure the machine gets some more
> users and load during the next days.

Thanks for testing, let me know if any more issues trigger.
