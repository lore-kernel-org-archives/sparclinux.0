From: Bob Breuer <breuerr@mc.net>
Date: Wed, 17 Nov 2004 02:28:18 +0000
Subject: hypersparc dvma aliasing
Message-Id: <419AB742.1000103@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After further testing, it certainly seems that hypersparcs
have aliasing issues between dvma and physical addresses.

Here are some results that I get using a minimum of cache
flushing with 512K of cache, and all dvma areas are cacheable:

iommu_get_one -- cache(va) = cache(pa):
va 0xf0777000, pa 0x00777000, dvma 0xf0010000 -- fails
va 0xf0777000, pa 0x00777000, dvma 0xf0777000 -- works

iommu_map_dma_area -- cache(va) != cache(addr):
va 0xfbd66000, addr 0xfff0e000, pba 0xf0066000 -- fails
va 0xfbd80000, addr 0xfff00000, pba 0xf0000000 -- works
va 0xfbd66000, addr 0xfff0e000, pba 0xf010e000 -- works


I've got some additional changes that allocate dvma addresses
with the right cache color and allow for less cache flushing.
I will post a patch shortly.

Bob

