From: David Miller <davem@davemloft.net>
Date: Sun, 20 Nov 2016 21:29:32 +0000
Subject: Re: [PATCH 3/3] rtc: sparc: make sun4v explicitly non-modular
Message-Id: <20161120.162932.2149671663687873415.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161031185527.20279-1-paul.gortmaker@windriver.com>
	<20161031185527.20279-4-paul.gortmaker@windriver.com>
In-Reply-To: <20161031185527.20279-4-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paul.gortmaker@windriver.com
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, sparclinux@vger.kernel.org, rtc-linux@googlegroups.com

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 31 Oct 2016 14:55:27 -0400

> The Kconfig currently controlling compilation of this code is:
> 
> drivers/rtc/Kconfig:config RTC_DRV_SUN4V
> drivers/rtc/Kconfig:    bool "SUN4V Hypervisor RTC"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied.
