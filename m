From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 18 Jan 2011 10:29:02 +0000
Subject: Re: [PATCH 4/4 V2] sparc/leon: Add LEON dma_ops.
Message-Id: <20110118102902.GA11942@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294909535-6290-5-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1294909535-6290-5-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 18, 2011 at 10:25:24AM +0100, Kristoffer Glembo wrote:
> Hi,
> 
> 
> Sam Ravnborg wrote:
> > 
> > I have failed to see what is the difference between pci32_alloc_coherent()
> > and the LEON variant of sbus_alloc_coherent().
> 
> Yes the only difference it the setting of the name in the resource. Maybe it does not warrant the messy code.
> 
> >  
> > Likewise for this. It looks equal to pci32_free_coherent().
> > 
> 
> Yes this case is actually totally equal.
> 
> For me it is no problem using the pci versions. I tried using the sbus versions on advice from Dave but maybe it was not very successful :)
> 
> 
> > Please investigate if you can use pci32_unmap_sg.
> > If this is the case you can reuse pci32_dma_ops direct.
> > As you can use pci32_map_sg() I would assume you can also
> > use the counterpart for unmap..
> > 
> 
> Yes I can remove it. It was pretty unnecessary.
I look forward for next version.

Note: I review this with only limited knowledge of the DMA stuff etc.
      So you shall (as always) treat the input as such.

	Sam
