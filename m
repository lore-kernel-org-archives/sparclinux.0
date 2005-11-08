From: Christoph Hellwig <hch@lst.de>
Date: Tue, 08 Nov 2005 21:00:36 +0000
Subject: Re: [PATCH] cpwatchdog: implement ->compat_ioctl
Message-Id: <20051108210036.GA26033@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107194320.GE32019@lst.de>
In-Reply-To: <20051107194320.GE32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Nov 08, 2005 at 12:58:16PM -0800, Eric Brower wrote:
> I noticed the envctrl.c patch bounds the assignment of .compat_ioctl
> by #ifdef CONFIG_COMPAT but the patch to cpwatchdog.c does not. 
> What's the currently preferred convention?  I'd assume it is
> unnecessary for in-kernel drivers, but I'd appreciate your take.

I'm a bit confused on that aswell as you can see ;-)  Generally
I'm not a big fan of ifdefs, but for some compat_ioctl handlers it
seems to be nessecary because they use contructs not available outside
it.  if envctrl.c compiles without the ifdef and without CONFIG_COMPAT
set feel free to remove it.
