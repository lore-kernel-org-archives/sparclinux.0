From: "David S. Miller" <davem@redhat.com>
Date: Wed, 02 Jun 2004 05:40:59 +0000
Subject: Re: RFC: defining sbus dma direction bits in terms of enum
Message-Id: <20040601224059.425f1a9b.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531124455.GA16822@lst.de>
In-Reply-To: <20040531124455.GA16822@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 1 Jun 2004 18:01:46 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, May 31, 2004 at 08:17:23PM -0400, Ben Collins wrote:
> > > @@ -231,7 +227,7 @@
> > >  		case FC_STATUS_ERR_OFFLINE:
> > >  			fc->state = FC_STATE_OFFLINE;
> > >  			dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi),
> > > -					  FC_DMA_BIDIRECTIONAL);
> > > +					  _DMA_BIDIRECTIONAL);
> > >  			printk ("%s: FC is offline\n", fc->name);
> > >  			if (atomic_dec_and_test (&l->todo))
> > >  				up(&l->sem);
> > 
> > Typo? s/_DMA_BIDIRECTIONAL/DMA_BIDIRECTIONAL/
> 
> Thanks.  Dave, can you fix that if/when applying?

I will, I got backlogged today so I'll try to get to all this tomorrow.
Including tcallawa's patch.
