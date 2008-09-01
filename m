From: David Miller <davem@davemloft.net>
Date: Mon, 01 Sep 2008 03:59:53 +0000
Subject: Re: [-next patch] sparc: remove CONFIG_SUN4
Message-Id: <20080831.205953.174775304.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 31 Aug 2008 19:54:01 +0300

> While doing some easy cleanups on the sparc code I noticed that the
> CONFIG_SUN4 code seems to be worse than the rest - there were some
> "I don't know how it should work, but the current code definitely cannot
> work." places.
> 
> And while I have seen people running Linux on machines like a
> SPARCstation 5 a few years ago I don't recall having seen sun4
> machines, even less ones running Linux.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Applied, thanks a lot Adrian.
