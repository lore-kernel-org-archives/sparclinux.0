From: Brad Roberts <braddr@puremagic.com>
Date: Mon, 10 Apr 2006 06:39:38 +0000
Subject: Re: Fw: niagara kernel boot problems
Message-Id: <Pine.LNX.4.64.0604092338150.5795@bellevue.puremagic.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0604092227300.5795@bellevue.puremagic.com>
In-Reply-To: <Pine.LNX.4.64.0604092227300.5795@bellevue.puremagic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 10 Apr 2006, Fabio Massimo Di Nitto wrote:

> Hi David, thanks for the info.
> 
> David S. Miller wrote:
> > This guy is getting an error we weren't getting before.
> > 
> > I think it's probably due to some non-sparc change to the ubuntu
> > tree recently.  His machine is probably very bog standard just
> > like your's and mine.
> > 
> > Please take a look and see if you can reproduce on your box.
> > 
> > 
> 
> > Right.. I'm using the ubuntu kernel from here:
> > 
> > http://ports.ubuntu.com/ubuntu-ports/dists/dapper/main/installer-sparc/current/images/sparc64/netboot/2.6/boot.img
> > 
> > Notice the line:
> > 
> > [    0.000000] Linux version 2.6.15-20-sparc64 (buildd@artigas) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu3)) #1 Tue Apr 4 17:55:03 UTC 2006
> > 
> > from the boot.
> 
> Brad could you be so kind to check the md5sum of the image?
> 
> 931cfa6df882132e80c81ceabf3e248e
> 
> here and it boots just fine.
> 
> Thanks
> Fabio

I did that before posting. :)

931cfa6df882132e80c81ceabf3e248e  boot.img

Either of both of you on irc somewhere so we can be more interactive?

Thanks,
Brad
