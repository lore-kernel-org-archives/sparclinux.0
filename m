From: David Miller <davem@davemloft.net>
Date: Sat, 31 Jan 2015 02:07:02 +0000
Subject: Re: [PATCH] sparc: io_64.h: Replace io function-link macros
Message-Id: <20150130.180702.537095959594952246.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1422543122-21956-1-git-send-email-ricardo.ribalda@gmail.com>
In-Reply-To: <1422543122-21956-1-git-send-email-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ricardo.ribalda@gmail.com
Cc: arnd@arndb.de, will.deacon@arm.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 29 Jan 2015 15:52:02 +0100

> Function like macros cannot be assigned to function pointers. This patch
> convert the function-like macros into object-macros, that the
> precompiler will replace with the name of the final function.
> 
> With this patch this kind of code will work:
> 
> if (priv->mode_big_endian)
> 	priv.read = ioread32be;
> else
> 	priv.read = ioread32;
> 
> Same approach has been taken on asm-generic/io.h
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Fixes: 99082eab63449f9d spi/xilinx: Remove iowrite/ioread wrappers
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
