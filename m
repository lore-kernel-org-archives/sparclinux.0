From: David Miller <davem@davemloft.net>
Date: Tue, 20 Nov 2007 08:05:23 +0000
Subject: Re: [PATCH 06/59] arch/sparc: Add missing "space"
Message-Id: <20071120.000523.194725858.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1195523331-15303-7-git-send-email-joe@perches.com>
	<20071119.234500.127324508.davem@davemloft.net>
	<1195544916.4675.117.camel@localhost>
In-Reply-To: <1195544916.4675.117.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joe@perches.com
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Mon, 19 Nov 2007 23:48:36 -0800

> On Mon, 2007-11-19 at 23:45 -0800, David Miller wrote:
> > From: Joe Perches <joe@perches.com>
> > Date: Mon, 19 Nov 2007 17:47:58 -0800
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > Please check your patches, for trailing white "space".
> > Adds trailing whitespace.
> > diff:10:		prom_printf("PCIC: Error, cannot map " 
> > Adds trailing whitespace.
> > diff:19:		prom_printf("PCIC: Error, cannot map " 
> > warning: 2 lines add whitespace errors.
> > I've fixed it up this time.
> 
> It doesn't add whitespace, but it does keep the trailing
> whitespace that's already there.

I know that, you should still do sanity checks and fix these kinds of
things up because they trigger errors in my patch applying scripts and
that of many other developers.
