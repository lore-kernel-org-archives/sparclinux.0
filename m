From: David Miller <davem@davemloft.net>
Date: Sun, 26 May 2013 17:11:49 +0000
Subject: Re: [PATCH v3, part2 11/20] PCI, SPARC: use hotplug-safe iterators to walk PCI buses
Message-Id: <20130526.101149.1610187533096408265.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1369583597-3801-1-git-send-email-jiang.liu@huawei.com>
	<1369583597-3801-12-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369583597-3801-12-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: liuj97@gmail.com
Cc: bhelgaas@google.com, yinghai@kernel.org, jiang.liu@huawei.com, rjw@sisk.pl, gregkh@linuxfoundation.org, guz.fnst@cn.fujitsu.com, toshi.kani@hp.com, myron.stowe@redhat.com, wangyijing@huawei.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org

From: Jiang Liu <liuj97@gmail.com>
Date: Sun, 26 May 2013 23:53:08 +0800

> Enhance SPARC architecture specific code to use hotplug-safe iterators
> to walk PCI buses.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
