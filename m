From: David Miller <davem@davemloft.net>
Date: Thu, 04 Jan 2007 02:50:05 +0000
Subject: Re: Third Try: [PATCH] cs4231 alsa driver: Fix IRQ and
Message-Id: <20070103.185005.32349028.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <459593A2.2000600@hp.com>
In-Reply-To: <459593A2.2000600@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Chini, Georg" <georg.chini@hp.com>
Date: Wed, 03 Jan 2007 19:32:57 +0100

> Georg Chini wrote:
> 
> >
> > David Miller wrote:
> >
> >> But it seems that nowadays the ISA CS4231 driver is using a value of
> >> "64" for period_bytes_min.  Perhaps the Sparc driver should do that
> >> too :-)
> >>
> >>
> >>  
> >>
> > My machine seems too slow to handle this. With values less
> > than 256 sound will not work properly. I think it starts missing
> > interrupts.
> >
> >
> Wrong again, I had some other problem when I tried 64. It works
> fine, so please change the period_bytes_min to 64.

Great, thanks for testing.  I'll make the change.
