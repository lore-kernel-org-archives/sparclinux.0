From: David Miller <davem@davemloft.net>
Date: Sat, 08 Jul 2006 20:55:25 +0000
Subject: Re: Sparc driver changes afoot for 2.6.18
Message-Id: <20060708.135525.82123721.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060624.001552.92583040.davem@davemloft.net>
In-Reply-To: <20060624.001552.92583040.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Sat, 08 Jul 2006 14:29:07 -0500

> I just got around to testing these changes on sparc32 with 2.6.18-rc1,
> and it dies early on.
 ...
> I'll keep looking at it and try to figure out where the NULL pointer
> came from.

Thanks bob for testing.

In another email Raymond Burns notes that clock_probe() is invoked
too early.  This may be related to your problem.
