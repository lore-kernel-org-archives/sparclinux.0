From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 17 Aug 2018 20:08:49 +0000
Subject: Re: [PATCH] sunhme: convert printk to pr_cont
Message-Id: <alpine.LRH.2.02.1808171606520.2385@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.02.1808171510510.31883@file01.intranet.prod.int.rdu2.redhat.com> <20180817125228.25cf47ce@xeon-e3>
In-Reply-To: <20180817125228.25cf47ce@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, netdev@vger.kernel.org



On Fri, 17 Aug 2018, Stephen Hemminger wrote:

> On Fri, 17 Aug 2018 15:12:22 -0400 (EDT)
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > =================================> > --- linux-stable.orig/drivers/net/ethernet/sun/sunhme.c	2018-04-20 18:11:00.000000000 +0200
> > +++ linux-stable/drivers/net/ethernet/sun/sunhme.c	2018-08-13 22:01:08.000000000 +0200
> > @@ -572,21 +572,21 @@ static void display_link_mode(struct hap
> >  {
> >  	printk(KERN_INFO "%s: Link is up using ", hp->dev->name);
> >  	if (hp->tcvr_type = external)
> > -		printk("external ");
> > +		pr_cont("external ");
> >  	else
> > -		printk("internal ");
> > -	printk("transceiver at ");
> > +		pr_cont("internal ");
> > +	pr_cont("transceiver at ");
> >  	hp->sw_lpa = happy_meal_tcvr_read(hp, tregs, MII_LPA);
> >  	if (hp->sw_lpa & (LPA_100HALF | LPA_100FULL)) {
> >  		if (hp->sw_lpa & LPA_100FULL)
> > -			printk("100Mb/s, Full Duplex.\n");
> > +			pr_cont("100Mb/s, Full Duplex.\n");
> >  		else
> > -			printk("100Mb/s, Half Duplex.\n");
> > +			pr_cont("100Mb/s, Half Duplex.\n");
> >  	} else {
> >  		if (hp->sw_lpa & LPA_10FULL)
> > -			printk("10Mb/s, Full Duplex.\n");
> > +			pr_cont("10Mb/s, Full Duplex.\n");
> >  		else
> > -			printk("10Mb/s, Half Duplex.\n");
> > +			pr_cont("10Mb/s, Half Duplex.\n");
> >  	}
> >  }
> 
> Why not just  use a single netdev_info (or drop the useless message altogether).
> 
> I.e
> 	netdev_info(hp->dev, "Link is up using %s transceiver at %dMb/s %s Duplex\n",
> 		(hp->tcvr->type = external) ? "external" : "internal",
> 		(hp->sw_lpa & (LPA_100HALF | LPA_100FULL)) ? 100 : 10,
> 		(hw->sw_lpa & (LPA_100FULL | LPA_10FULL)) ? "Full" : "Half"));

I'm not an expert on networking code - you can change it if it is more 
appropriate this way.

Mikulas
