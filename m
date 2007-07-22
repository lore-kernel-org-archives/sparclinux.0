From: David Miller <davem@davemloft.net>
Date: Sun, 22 Jul 2007 02:22:51 +0000
Subject: Re: sparc64: ERROR: "sys_ioctl" [arch/sparc64/solaris/solaris.ko]
Message-Id: <20070721.192251.122832397.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <7157.1184937882@laptop13.inf.utfsm.cl>
	<20070720161154.GA17382@infradead.org>
In-Reply-To: <20070720161154.GA17382@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@infradead.org
Cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 20 Jul 2007 17:11:54 +0100

> On Fri, Jul 20, 2007 at 09:24:42AM -0400, Horst H. von Brand wrote:
> > When building v2.6.22-3478-g275afca on sparc64 (.config attached) I get:
> > 
> >   MODPOST vmlinux
> >   Building modules, stage 2.
> >   MODPOST 463 modules
> > ERROR: "sys_ioctl" [arch/sparc64/solaris/solaris.ko] undefined!
> 
> Sorry, my fault.
> 
> It looked to me like sparc64 exports sys_ioctl on it's own, but it only
> exports compat_sys_ioctl on it's own.
> 
> Here's the fix:

Applied, thanks!
