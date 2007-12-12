From: Bernd Zeimetz <bernd@bzed.de>
Date: Wed, 12 Dec 2007 16:05:55 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <476006E3.9030901@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> I shoule be easily fixed using the patch below.  It records which bits
> we should actually be concerned about, and only tests those specific
> bits in the dispatch status register.
> 
> Could you please give this patch a test?

Tested - the patch seems to fix the problem as the machine is still
alive and working well after several hours of running the buggy aptitude
-u in a loop.

I'll leave the kernel running and make sure the machine gets some more
users and load during the next days.


Thanks for the fix,

Bernd

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
