From: Milton Miller <miltonm@bga.com>
Date: Wed, 18 May 2011 17:03:36 +0000
Subject: Re: [PATCH] of: fix race when matching drivers
Message-Id: <match-use-var@mdm.bga.com>
List-Id: <sparclinux.vger.kernel.org>
References: <BANLkTikhKqcpdadpM3RQdYvDrPn46_v6_Q@mail.gmail.com>
 <20110517.134312.226762699.davem@davemloft.net>
 <alpine.SOC.1.00.1105021259220.6200@math.ut.ee>
 <1305732459_6563@mail4.comsite.net>
 <20110518154517.GA26070@entuzijast.net>
 <20110518162139.GA11027@ponder.secretlab.ca>
In-Reply-To: <20110518162139.GA11027@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>, Josip Rodin <joy@entuzijast.net>
Cc: David Miller <davem@davemloft.net>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, 18 May 2011 about 10:21:39 -0600, Grant Likely wrote:
> On Wed, May 18, 2011 at 05:45:17PM +0200, Josip Rodin wrote:
> > On Wed, May 18, 2011 at 10:27:39AM -0500, Milton Miller wrote:
> > > --- work.git.orig/include/linux/of_device.h	2011-05-18 09:57:01.014386816 -0500
> > > +++ work.git/include/linux/of_device.h	2011-05-18 09:58:27.537431575 -0500
> > > @@ -21,8 +21,15 @@ extern void of_device_make_bus_id(struct
> > >  static inline int of_driver_match_device(struct device *dev,
> > >  					 const struct device_driver *drv)
> > >  {
> > > -	dev->of_match = of_match_device(drv->of_match_table, dev);
> > > -	return dev->of_match != NULL;
> > > +	const struct of_device_id *match;
> > > +
> > > +	match = of_match_device(drv->of_match_table, dev);
> > > +	if (match) {
> > > +		dev->of_match = of_match_device(drv->of_match_table, dev);
> > > +		return 1;
> > > +	}
> > > +
> > > +	return 0;
> > >  }
> > 
> > Err, is there some reason to avoid simply assigning the existing result:
> > dev->of_match = match; ?
> 
> Good point.  I've committed and am currently testing the modified version.
> 
> g.

Sorry about that.  I had intended to do that (hence creating the
variable), but obvioiusly I forgot when I hurried to compile test
and send out the patch.

thanks to Josip for finding and Grant for fixing.

milton
