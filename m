From: David Miller <davem@davemloft.net>
Date: Thu, 06 Nov 2008 06:39:42 +0000
Subject: Re: sparc/staging compile error
Message-Id: <20081105.223942.258207193.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081106163626.2306ad75.sfr@canb.auug.org.au>
	<20081106063709.GB7728@kroah.com>
In-Reply-To: <20081106063709.GB7728@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Wed, 5 Nov 2008 22:37:09 -0800

> On Thu, Nov 06, 2008 at 04:36:26PM +1100, Stephen Rothwell wrote:
> > Hi Greg,
> > 
> > Today's tree from Linus gets the following error from a sparc
> > allmodconfig build:
> > 
> > ERROR: "___f_flush_cache_range" [drivers/staging/poch/poch.ko] undefined!
> 
> Odd, is flush_cache_range() not allowed on the sparc platform?

No, just nobody used it from a module before.
