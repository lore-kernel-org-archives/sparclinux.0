From: Bob Breuer <breuerr@mc.net>
Date: Fri, 12 Nov 2004 03:41:04 +0000
Subject: Re: hme broken on 2.6 hypersparc
Message-Id: <419430D0.9030500@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4192D294.8090305@mc.net>
In-Reply-To: <4192D294.8090305@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I think I have an idea on what is going wrong.

First off, I came across an old publication:
http://www.usenix.org/publications/library/proceedings/sd96/full_papers/chu.txt
In section 5.3, it states that cache aliasing can occur between
DVMA and host memory addresses.  I'm not sure if that is physical
or virtual host addresses, but either way cache aliasing can
happen.  The cache aliasing is most prominent with the hypersparcs
because of the virtually indexed, phyically tagged cache.

Before the iommu rewrite, dvma addresses were pre-allocated and
mapped 1 to 1 with the kernel low memory.  Because of the 1:1
mapping, no cache aliases will ever occur in low memory.

After the iommu rewrite, all dvma addresses are allocated on
the fly.  I suspect that very little consideration was given
to cache aliasing.

I have found two easy ways in a low-memory only hypersparc
machine to make the hme work: 1) revert my srmmu fix, and
2) revert the iommu back to the fixed 1:1 dvma mapping.
Neither fix should be considered correct.

The hme driver uses a consistent dma mapping for it's transmit
descriptors.  If those descriptors are cacheable, they must
not be aliased in the cache.  Fix 1 makes them uncached, and
fix 2 eliminates the cache alias.

Looking on to the esp dma errors, I think there are only 2
reasons why it was failing: A) the iotlb changes were not
seen by the iommu, or B) a cache alias prevented the cpu
from seeing the new data.  Doing a flush_cache_all happens
to fix both possible problems.  Being unfamiliar with the
iommu, it is hard to rule out A.  However, after trying to
figure out the hme problem, I'm leaning toward B as the core
problem here.

After all this, I think that if the dvma address allocation
could be made to actively avoid cache aliasing, it might
fix both problems.

Bob
