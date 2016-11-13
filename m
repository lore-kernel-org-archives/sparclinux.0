From: David Miller <davem@davemloft.net>
Date: Sun, 13 Nov 2016 17:27:03 +0000
Subject: Re: [mm PATCH v3 17/23] arch/sparc: Add option to skip DMA sync as a part of map and unmap
Message-Id: <20161113.122703.2122997256308305867.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161110113027.76501.63030.stgit@ahduyck-blue-test.jf.intel.com>
	<20161110113544.76501.40008.stgit@ahduyck-blue-test.jf.intel.com>
In-Reply-To: <20161110113544.76501.40008.stgit@ahduyck-blue-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexander.h.duyck@intel.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Thu, 10 Nov 2016 06:35:45 -0500

> This change allows us to pass DMA_ATTR_SKIP_CPU_SYNC which allows us to
> avoid invoking cache line invalidation if the driver will just handle it
> via a sync_for_cpu or sync_for_device call.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
