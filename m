From: David Miller <davem@davemloft.net>
Date: Fri, 30 Oct 2015 01:49:55 +0000
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <20151029.184955.728736673434401711.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
In-Reply-To: <20151029155701.GJ7716@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Thu, 29 Oct 2015 08:57:01 -0700

> So, would that imply changing just the NVMe driver code rather than
> adding the dma_page_shift API at all? What about
> architectures that can support the larger page sizes? There is an
> implied performance impact, at least, of shifting the IO size down.
> 
> Sorry for the continuing questions -- I got lots of conflicting feedback
> on the last series and want to make sure v4 is more acceptable.

In the long term I would be very happy to see us having a real interface
for this stuff, just my opinion...
