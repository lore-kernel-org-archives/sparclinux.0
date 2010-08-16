From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 16 Aug 2010 20:45:59 +0000
Subject: Re: XVR-600 console not working with e3d [was Re: please restore
Message-Id: <20100816204559.GA7726@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20100815194147.GA26399@orion.carnet.hr>
In-Reply-To: <20100815194147.GA26399@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > >> On Sat, Aug 14, 2010 at 10:09:06AM -0400, Howard Eisenberger wrote:
> > >> > If it helps, I did this with the XVR-600 in my Ultra 60, but the
> > >> > output stops with:
> > >> > 
> > >> > [    0.000000] OF stdout device is: /pci@1f,2000/SUNW,XVR-600@1
> > >> > ...
> > >> > [    0.000000] Console: colour dummy device 80x25
> > >> > [    0.000000] console [tty0] enabled, bootconsole disabled
> 
> OK, so the conclusion from this is that either e3d (sunxvr500) driver needs
> some fixes to support XVR-600, or we need some way of getting the other one
> to activate?
> 
> Cc:ing kernel mailing list in case someone there has better input.
> I found a thread from March this year where Dave was trying and failing
> to reproduce a similar setup - maybe Howard can provide the missing link
> now.

One more thing - Howard, can you please see:
http://lists.debian.org/debian-sparc/2010/03/msg00036.html
That link to a test kernel image in that message still works, so you could
try it and report back.

-- 
     2. That which causes joy or happiness.
