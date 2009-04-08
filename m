From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 08 Apr 2009 21:29:50 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408212950.GB10282@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 08, 2009 at 11:21:13PM +0200, Sam Ravnborg wrote:
> On Wed, Apr 08, 2009 at 11:15:14PM +0200, seb@frankengul.org wrote:
> > On Wed, Apr 08, 2009 at 10:59:22PM +0200, Sam Ravnborg wrote:
> > > On Wed, Apr 08, 2009 at 10:07:11PM +0200, seb@frankengul.org wrote:
> > > > Hi,
> > > > I'm not able to boot 2.6.29.1 kernel compiled for V240.
> > > > Kernel just hang.
> > > > I'm attaching the boot.log and the config file used.
> > > > The 2.6.28 works ok.
> > > > Is there something missing.
> > > > It's the third time I'm trying to build the kernel and none did boot.
> > > > 2.6.29 hanged when switch to console.
> > > > 2.6.29.1 goes further but not by much.
> > > > 
> > > > Seb
> > > 
> > > I think it is a know problem.
> > > See http://lkml.org/lkml/2009/4/8/255
> > > 
> > > 	Sam
> > 
> > I saw this, and I already applied this patch. With no luck.
> > Hangs happens at the same place with or without patch.
> > Maybe I need to make clean before rebuilding with the patch applied.
> 
> I do not expect a "make clean" to help.
> And frankly I did not look close at your error report so it
> is most likely another problem.

Looked a bit closer - and it is obviously not the same.
But I found another thread where Hermann Lauer had a similar problem.

David asked:
========> [   50.390776] Brought up 2 CPUs
> [   50.391634] net_namespace: 1552 bytes
> [   50.568542] NET: Registered protocol family 16
>

The next thing that probably should run is the PCI controller
probe.  But I can't say that for certain, so we need more
info.

Please reboot this test kernel with the following added boot
command line options: initcall_debug=1 ignore_loglevel

Let us see the console log output that generates.
========

But reading further in that thread did not result in any
solution..

Try to google for "Sunfire V880 and 480R 2.6.27.x startup hangs"


	Sam
