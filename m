From: Paul Mackerras <paulus@samba.org>
Date: Thu, 06 Nov 2008 10:32:49 +0000
Subject: Re: sparc/staging compile error
Message-Id: <18706.51153.342079.586525@cargo.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20081106163626.2306ad75.sfr@canb.auug.org.au>
	<20081106063709.GB7728@kroah.com>
In-Reply-To: <20081106063709.GB7728@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "William L. Irwin" <wli@holomorphy.com>, sparclinux@vger.kernel.org

Greg KH writes:

> On Thu, Nov 06, 2008 at 04:36:26PM +1100, Stephen Rothwell wrote:
> > Hi Greg,
> > 
> > Today's tree from Linus gets the following error from a sparc
> > allmodconfig build:
> > 
> > ERROR: "___f_flush_cache_range" [drivers/staging/poch/poch.ko] undefined!
> 
> Odd, is flush_cache_range() not allowed on the sparc platform?

I'm curious, what is a driver doing calling flush_cache_range()?
What does it expect it to do precisely?

Paul.
