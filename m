From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 24 Nov 2016 22:51:10 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <20161124225110.feak5baqtk7gwvoa@raspberrypi-2.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Thu, Nov 24, 2016 at 11:26:20PM +0100, John Paul Adrian Glaubitz wrote:
> On 11/24/2016 11:05 PM, Aaro Koskinen wrote:
> > The same issue as with silo.
> 
> Don't you think your statements are a bit misleading then? I didn't break anything,
> I changed the default target to 64-bit which is somewhat reasonable in the year
> 2016, isn't it.

You could write the Makefile so that build works even with 32-bit
userspace. I don't think it's unreasonable or rude to demand.

> Or are you going to tell me now that your 333 MHz, 128 MiB RAM Sun
> Ultra 5 is your everyday production machine?

Yes, I'm using Ultra 5 on daily basis. The CPU is 360 MHz and with 512
MiB RAM.

A.
