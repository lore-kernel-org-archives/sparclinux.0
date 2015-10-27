From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 22:20:10 +0000
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <20151027222010.GD7716@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
In-Reply-To: <20151026.182746.1323901353520152838.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 26.10.2015 [18:27:46 -0700], David Miller wrote:
> From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Date: Fri, 23 Oct 2015 13:54:20 -0700
> 
> > 1) add a generic dma_get_page_shift implementation that just returns
> > PAGE_SHIFT
> 
> I won't object to this patch series, but if I had implemented this I
> would have required the architectures to implement this explicitly,
> one-by-one.  I think it is less error prone and more likely to end
> up with all the architectures setting this correctly.

Well, looks like I should spin up a v4 anyways for the powerpc changes.
So, to make sure I understand your point, should I make the generic
dma_get_page_shift a compile-error kind of thing? It will only fail on
architectures that actually build the NVME driver (as the only caller).
But I'm not sure how exactly to achieve that, if you could give a bit
more detail I'd appreciate it!

Thanks,
Nish

