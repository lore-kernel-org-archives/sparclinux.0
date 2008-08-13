From: David Miller <davem@davemloft.net>
Date: Wed, 13 Aug 2008 00:59:48 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <20080812.175948.214598056.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080811.233013.49328708.davem@davemloft.net>
	<20080812.012201.164876122.davem@davemloft.net>
	<Pine.LNX.4.64.0808122051240.31704@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0808122051240.31704@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 12 Aug 2008 20:53:04 -0400 (EDT)

> On Tue, 12 Aug 2008, David Miller wrote:
> 
> > From: David Miller <davem@davemloft.net>
> > Date: Mon, 11 Aug 2008 23:30:13 -0700 (PDT)
> > 
> > > The problem is that CONFIG_STACK_DEBUG doesn't understand
> > > the IRQ stacks at all.
> > > 
> > > I'll see if I can tweak it to handle this.
> > 
> > This patch, on top of my original IRQSTACKS patch for
> > sparc64, seems to get things working for me.
> 
> Thanks, the patch works.

Thanks for testing.  I'm engaged in a few activities right
now related to this:

1) I'm making a final version of this irqstacks patch which
   I'll get into Linus's tree and then submit to -stable.

2) I have a patch which I'm regression testing for gcc which
   gets rid of the 16-byte secondary-reload stack slot.  This
   gcc is emitting 176 byte default stack frames on sparc64.

3) I'm talking with some folks familiar with the V9 ABI about
   the mandatory incoming argument stack slots.  I think they
   can be eliminated in all cases except functions taking
   varargs.  If it cannot be done universally for some
   reason, I'll add a -mkernel option that will eliminate
   them.  This will emit 128 byte default stack frames when
   possible.

So in the end we should hopefully have 128 byte stack frames
coming out of gcc and IRQ stacks in the kernel.
