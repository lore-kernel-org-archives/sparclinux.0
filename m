From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 17 Nov 2004 06:11:17 +0000
Subject: Re: hypersparc dvma aliasing
Message-Id: <20041116221117.65c93cea.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419AB742.1000103@mc.net>
In-Reply-To: <419AB742.1000103@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 16 Nov 2004 20:28:18 -0600
Bob Breuer <breuerr@mc.net> wrote:

> After further testing, it certainly seems that hypersparcs
> have aliasing issues between dvma and physical addresses.
> 
> Here are some results that I get using a minimum of cache
> flushing with 512K of cache, and all dvma areas are cacheable:
> 
> iommu_get_one -- cache(va) = cache(pa):
> va 0xf0777000, pa 0x00777000, dvma 0xf0010000 -- fails
> va 0xf0777000, pa 0x00777000, dvma 0xf0777000 -- works
> 
> iommu_map_dma_area -- cache(va) != cache(addr):
> va 0xfbd66000, addr 0xfff0e000, pba 0xf0066000 -- fails
> va 0xfbd80000, addr 0xfff00000, pba 0xf0000000 -- works
> va 0xfbd66000, addr 0xfff0e000, pba 0xf010e000 -- works

You've certainly disproven all the theories in my previous
email on this topic :-)  Good work Bob!
