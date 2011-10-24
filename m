From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 24 Oct 2011 21:47:13 +0000
Subject: Re: 3.0.4 kernel oops in i2c ?
Message-Id: <20111024214713.GA561@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111014144345.GB5070@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20111014144345.GB5070@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Oct 24, 2011 at 04:43:06PM +0200, Hermann Lauer wrote:
> On Mon, Oct 24, 2011 at 03:26:56PM +0200, Josip Rodin wrote:
> > On Fri, Oct 14, 2011 at 04:43:45PM +0200, Hermann Lauer wrote:
> > > when starting 3.0.4 on a V880 a non fatal oops happens when loading
> > > i2c stuff. Proably there is a problem with i2c on the machine,
> > > as the rsc "env" cmd shows "E880_FSP: ERROR getting FP stats ---> 9"
> > > errors. An old 2.6.26-2-sparc64-smp (Debian 2.6.26-26lenny2) kernel
> > > produces no oops.
> > 
> > Can you try the stable Debian 2.6.32 kernel at least?
> > 
> > Anything that helps you reduce the amount of git bisect...
> 
> 2.6.32-5-sparc64-smp (Debian 2.6.32-38) (ben@decadent.org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 SMP Mon Oct 3 09:43:44 UTC 2011
> 
> is starting fine without oops. Thanks for caring,

OK, so if you think a git bisect is still going to be too tedious, do a
binary search through released kernels to narrow it down to a single
release, and then a bisect should be quick enough.

-- 
     2. That which causes joy or happiness.
