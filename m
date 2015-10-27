From: David Miller <davem@davemloft.net>
Date: Tue, 27 Oct 2015 01:27:46 +0000
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <20151026.182746.1323901353520152838.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 13:54:20 -0700

> 1) add a generic dma_get_page_shift implementation that just returns
> PAGE_SHIFT

I won't object to this patch series, but if I had implemented this I
would have required the architectures to implement this explicitly,
one-by-one.  I think it is less error prone and more likely to end
up with all the architectures setting this correctly.
