From: David Miller <davem@davemloft.net>
Date: Mon, 16 Jun 2008 23:45:24 +0000
Subject: Re: [2.6 patch] sparc: remove CONFIG_SUN4
Message-Id: <20080616.164524.13136142.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080610222838.GL11685@cs181133002.pp.htv.fi>
In-Reply-To: <20080610222838.GL11685@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 11 Jun 2008 01:28:38 +0300

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

Applied to sparc-next-2.6, thanks Adrian!
