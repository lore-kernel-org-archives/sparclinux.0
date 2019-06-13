From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jun 2019 21:07:00 +0000
Subject: Re: [PATCH silo] tilo: fix rootfs size check
Message-Id: <20190613.140700.1064902587962557055.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190604214748.25377-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190604214748.25377-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed,  5 Jun 2019 00:47:48 +0300

> When checking the rootfs size we use the kernel image size instead of the
> rootfs image. Fix that.
> 
> Fixes: 9f151df0eecf ("tilo: sanity check image sizes")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied, thank you.
