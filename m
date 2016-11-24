From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 24 Nov 2016 22:05:15 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <20161124220515.yxsklogurkqtlm6s@raspberrypi-2.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Thu, Nov 24, 2016 at 10:51:14PM +0100, John Paul Adrian Glaubitz wrote:
> On 11/24/2016 10:23 PM, Aaro Koskinen wrote:
> > This breaks the native build on my Sun Ultra 5 with 32-bit userspace and GCC
> > defaulting to ultrasparc:
> 
> Well, you can just change this part back to "elf32_sparc" and it will work. Might
> even be possible to omit the "-m" option altogether to it will default to -m native.

I think that's your job to try. If you want to "add 64-bit support"
(instead of forcing it to everybody), do the required changes so that
it's still works for everybody without extra fiddling.

> > Also you broke the tilo build...
> 
> Not here. Just tried it again and it builds fine. Can you be more specific?

The same issue as with silo.

A.
