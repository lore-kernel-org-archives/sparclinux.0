From: David Miller <davem@davemloft.net>
Date: Thu, 09 Jul 2015 08:00:45 +0000
Subject: Re: [RFC Patch V1 07/12] sparc, PCI: Use helper functions to access fields in struct msi_desc
Message-Id: <20150709.010045.1327001449508270216.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <1436428847-8886-8-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-8-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Thu,  9 Jul 2015 16:00:42 +0800

> Use helper functions to access fields in struct msi_desc, so we could
> easily refine struct msi_desc later.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
