From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Thu, 29 Oct 2015 15:57:01 +0000
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <20151029155701.GJ7716@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
In-Reply-To: <20151029115536.GA28090@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 29.10.2015 [04:55:36 -0700], Christoph Hellwig wrote:
> On Wed, Oct 28, 2015 at 01:59:23PM +0000, Busch, Keith wrote:
> > The "new" interface for all the other architectures is the same as the
> > old one we've been using for the last 5 years.
> > 
> > I welcome x86 maintainer feedback to confirm virtual and DMA addresses
> > have the same offset at 4k alignment, but I have to insist we don't
> > break my currently working hardware to force their attention.
> 
> We had a quick cht about this issue and I think we simply should
> default to a NVMe controler page size of 4k everywhere as that's the
> safe default.  This is also what we do for RDMA Memory reigstrations and
> it works fine there for SRP and iSER.

So, would that imply changing just the NVMe driver code rather than
adding the dma_page_shift API at all? What about
architectures that can support the larger page sizes? There is an
implied performance impact, at least, of shifting the IO size down.

Sorry for the continuing questions -- I got lots of conflicting feedback
on the last series and want to make sure v4 is more acceptable.

Thanks,
Nish

