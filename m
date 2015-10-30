From: David Miller <davem@davemloft.net>
Date: Fri, 30 Oct 2015 09:10:23 +0000
Subject: Re: [PATCH -next] sparc: Populate 'device' for platform device devicetree nodes
Message-Id: <20151030.181023.877331632514498887.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1445819198-13744-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1445819198-13744-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, tomeu.vizoso@collabora.com

From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 25 Oct 2015 17:26:38 -0700

> Since commit 61e82530d80f ("of/platform: Point to struct device from device
> node"), the 'device' pointer in devicetree nodes for platform devices must
> be set for of_find_device_by_node to succeed. This is not the case unless
> the platform device was created using of_platform_device_create(), which
> is not always the case. This causes all sparc images to crash with "Unable
> to handle NULL pointer reference" in functions such as iommu_init(), which
> don't expect of_find_device_by_node() to return NULL.
> 
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> This patch depends on the patch causing the problem (which can not be easily
> reverted). It should probably go through the same tree as that patch,
> or the patches should be merged.

Indeed, please merge this into the tree that added the change in
question:

Acked-by: David S. Miller <davem@davemloft.net>
