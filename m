From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 19:49:35 +0000
Subject: Re: [2.6 patch] sparc: remove CONFIG_SUN4
Message-Id: <20080829.124935.223214489.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080610222838.GL11685@cs181133002.pp.htv.fi>
In-Reply-To: <20080610222838.GL11685@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Fri, 29 Aug 2008 15:36:32 +0300

> On Mon, Jun 16, 2008 at 04:45:24PM -0700, David Miller wrote:
> > From: Adrian Bunk <bunk@kernel.org>
> > Date: Wed, 11 Jun 2008 01:28:38 +0300
> > 
> > > While doing some easy cleanups on the sparc code I noticed that the
> > > CONFIG_SUN4 code seems to be worse than the rest - there were some
> > > "I don't know how it should work, but the current code definitely cannot
> > > work." places.
> > > 
> > > And while I have seen people running Linux on machines like a
> > > SPARCstation 5 a few years ago I don't recall having seen sun4
> > > machines, even less ones running Linux.
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> > 
> > Applied to sparc-next-2.6, thanks Adrian!
> 
> It seems it got lost somewhere?

I lost it somehow, and I have no idea how it happened,
sorry Adrian it was unintentional :(

> Should I rediff it against the latest sparc-next and resend?

Please, thanks.

