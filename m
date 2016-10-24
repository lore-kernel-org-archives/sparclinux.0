From: David Miller <davem@davemloft.net>
Date: Mon, 24 Oct 2016 18:27:30 +0000
Subject: Re: [net-next PATCH RFC 19/26] arch/sparc: Add option to skip DMA sync as a part of map and unmap
Message-Id: <20161024.142730.1316656811538193943.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161024115737.16276.71059.stgit@ahduyck-blue-test.jf.intel.com>
	<20161024120607.16276.5989.stgit@ahduyck-blue-test.jf.intel.com>
In-Reply-To: <20161024120607.16276.5989.stgit@ahduyck-blue-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexander.h.duyck@intel.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, brouer@redhat.com

From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 24 Oct 2016 08:06:07 -0400

> This change allows us to pass DMA_ATTR_SKIP_CPU_SYNC which allows us to
> avoid invoking cache line invalidation if the driver will just handle it
> via a sync_for_cpu or sync_for_device call.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

This is fine for avoiding the flush for performance reasons, but the
chip isn't going to write anything back unless the device wrote into
the area.
