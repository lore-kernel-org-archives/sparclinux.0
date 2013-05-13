From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 13 May 2013 15:37:21 +0000
Subject: Re: [PATCH] arch: sparc: kernel: use devm_ioremap_resource()
Message-Id: <20130513153721.GA18836@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1368367807-1263-1-git-send-email-laurent.navet@gmail.com> <20130512152829.GA17866@merkur.ravnborg.org> <CAH7P7NjHK+QQ1E1ygCG0u=oEL1=Dty__OAZfYA1bitPm_cY3Yw@mail.gmail.com>
In-Reply-To: <CAH7P7NjHK+QQ1E1ygCG0u=oEL1=Dty__OAZfYA1bitPm_cY3Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Navet <laurent.navet@gmail.com>
Cc: davem@davemloft.net, daniel@gaisler.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 13, 2013 at 01:43:17PM +0200, Laurent Navet wrote:
> The same is done almost everywhere in kernel tree :
> 
> e.g :
> http://lxr.free-electrons.com/source/drivers/staging/iio/adc/mxs-lradc.c#L928
> http://lxr.free-electrons.com/source/drivers/gpio/gpio-mxs.c#L292
> http://lxr.free-electrons.com/source/drivers/iommu/tegra-smmu.c#L1181
> http://lxr.free-electrons.com/source/drivers/rtc/rtc-spear.c#L388
> http://lxr.free-electrons.com/source/drivers/i2c/busses/i2c-imx.c#L514
> http://lxr.free-electrons.com/source/sound/soc/kirkwood/kirkwood-i2s.c#L475
> 
> and so on...  all theses functions return an int.

I was confusing PTR_ERR() and ERR_PTR(),
so path looks ok.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
