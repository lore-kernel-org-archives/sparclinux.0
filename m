From: Greg KH <greg@kroah.com>
Date: Wed, 05 Aug 2009 20:43:57 +0000
Subject: Re: [stable] cmd64x: irq 14: nobody cared - system is dreadfully
Message-Id: <20090805204357.GB10788@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200906220843.14337.elendil@planet.nl>
 <200906221604.17915.elendil@planet.nl>
 <20090623.034316.149816033.davem@davemloft.net>
 <200907311609.01387.elendil@planet.nl>
In-Reply-To: <200907311609.01387.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <elendil@planet.nl>
Cc: stable@kernel.org, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, David Miller <davem@davemloft.net>, bzolnier@gmail.com

On Fri, Jul 31, 2009 at 04:08:59PM +0200, Frans Pop wrote:
> On Tuesday 23 June 2009, David Miller wrote:
> > From: Frans Pop <elendil@planet.nl> Date: Mon, 22 Jun 2009:
> > > On Monday 22 June 2009, you wrote:
> > >> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > >> Subject: [PATCH] ide: fix handling of unexpected IRQs vs
> > >> request_irq()
> > >>
> > > Thanks Bart. This does solve the "nobody cared" problem.
> > > Tested-by: Frans Pop <elendil@planet.nl>
> >
> > I've applied this patch to my tree, thanks everyone!
> 
> Please consider the following two patches for the next stable update:
> 
> commit ffc36c7610731115c77700dcc53901920361c235
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ide: fix handling of unexpected IRQs vs request_irq()
> 
> commit 346c17a6cf60375323adfaa4b8a9d841049f890e
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ide: relax DMA info validity checking
> 
> The current 2.6.30 Debian kernel (based on .30.3) is still failing on my
> Sparc Ultra 10 because those patches are missing.

I have queued both of these up now for the next .30-stable release.

thanks,

greg k-h
