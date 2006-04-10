From: Brad Roberts <braddr@puremagic.com>
Date: Mon, 10 Apr 2006 06:10:35 +0000
Subject: Re: niagara kernel boot problems
Message-Id: <Pine.LNX.4.64.0604092308280.5795@bellevue.puremagic.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0604092227300.5795@bellevue.puremagic.com>
In-Reply-To: <Pine.LNX.4.64.0604092227300.5795@bellevue.puremagic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 9 Apr 2006, David S. Miller wrote:

> From: Brad Roberts <braddr@puremagic.com>
> Date: Sun, 9 Apr 2006 22:40:41 -0700 (PDT)
> 
> > I just got a t2000 from sun as part of their try/buy program partially due 
> > to the news about the successful linux bootup.  I've got to admit that I'm 
> > an extreme newbie to sun hardware and rather than learn my way around 
> > solaris I want to stick in the warm comfy zone of linux and debian-based 
> > distributions.
> > 
> > In the process of booting, I'm hitting a problem:
> ...
> > Can anyone shine some light or point me at what I failed to find through 
> > the usually rather trusty google?  Up to now, I've really only ever delt 
> > with x86 hardware.
> 
> Where in the world did you get the kernel from?
> 
> Nothing debian currently ships will work, Ubuntu (which is debian
> based) does work, so please try the current Dapper Drake sparc install
> images.

Right.. I'm using the ubuntu kernel from here:

http://ports.ubuntu.com/ubuntu-ports/dists/dapper/main/installer-sparc/current/images/sparc64/netboot/2.6/boot.img

Notice the line:

[    0.000000] Linux version 2.6.15-20-sparc64 (buildd@artigas) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu3)) #1 Tue Apr 4 17:55:03 UTC 2006

from the boot.
