From: David Miller <davem@davemloft.net>
Date: Sun, 31 Mar 2013 23:31:47 +0000
Subject: Re: [PATCH 3/5] bbc_i2c: fix section mismatch warning
Message-Id: <20130331.193147.290184916307324055.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364679866-29982-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1364679866-29982-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 22:44:24 +0100

> Fix following warning:
> 
> WARNING: drivers/sbus/char/bbc.o(.text+0x674): Section mismatch in reference from the function bbc_i2c_probe() to the function .init.text:T.463()
> The function bbc_i2c_probe() references the function __init T.463().
> This is often because bbc_i2c_probe lacks a __init
> annotation or the annotation of T.463 is wrong.
> 
> bbc_i2c_probe() referenced the inlined attach_one_i2c().
> As probe may be called after init drop __init annotations
> on all functions used by bbc_i2c_probe()
> 
> The warning was seen with a sparc64 defconfig build
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
