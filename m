From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Sun, 20 Nov 2016 21:38:54 +0000
Subject: Re: [PATCH 2/3] rtc: sparc: make starfire explicitly non-modular
Message-Id: <20161120213854.ailkekyemj4hhmbw@piout.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161031185527.20279-1-paul.gortmaker@windriver.com>
 <20161031185527.20279-3-paul.gortmaker@windriver.com>
 <20161120.162919.145900145134940393.davem@davemloft.net>
In-Reply-To: <20161120.162919.145900145134940393.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, a.zummo@towertech.it, sparclinux@vger.kernel.org, rtc-linux@googlegroups.com

Hi Dave,

I already carry both patches in my tree but I would gladly add an ack.

On 20/11/2016 at 16:29:19 -0500, David Miller wrote :
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Mon, 31 Oct 2016 14:55:26 -0400
> 
> > The Kconfig currently controlling compilation of this code is:
> > 
> > drivers/rtc/Kconfig:config RTC_DRV_STARFIRE
> > drivers/rtc/Kconfig:    bool "Starfire RTC"
> > 
> > ...meaning that it currently is not being built as a module by anyone.
> > 
> > Lets remove the couple traces of modular infrastructure use, so that
> > when reading the driver there is no doubt it is builtin-only.
> > 
> > We delete the MODULE_LICENSE tag etc. since all that information
> > was (or is now) contained at the top of the file in the comments.
> > 
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
> > Cc: rtc-linux@googlegroups.com
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Applied.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
