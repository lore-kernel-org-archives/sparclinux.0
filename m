From: David Miller <davem@davemloft.net>
Date: Sun, 09 Oct 2016 00:50:56 +0000
Subject: Re: [linux-review:Tushar-Dave/sparc-Enable-sun4v-hypervisor-PCI-IOMMU-v2-APIs-and-ATU/20161007-13142
Message-Id: <20161008.205056.599443299674868698.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5e91bce7-cf37-a078-b667-b7e58dd2717e@oracle.com>
In-Reply-To: <5e91bce7-cf37-a078-b667-b7e58dd2717e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: tndave <tushar.n.dave@oracle.com>
Date: Sat, 8 Oct 2016 15:49:32 -0700

> I have patches ready that resolve the warning/errors reported by
> kbuild test robot. I will be sending v2 RFC for ATU series.

I largely have no problem with this patch series, and in particular
we were already on borrowed time wrt. making dma_addr_t 64-bit on
sparc64.

It was a nice memory savings while it lasted :-)
