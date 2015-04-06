From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Mon, 06 Apr 2015 01:36:37 +0000
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
Message-Id: <0838dec2-0adf-4e5e-a26c-f0752a0fd2f9@BL2FFO11FD031.protection.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
In-Reply-To: <1428258294.2775.69.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Sun, 2015-04-05 at 11:24AM -0700, Joe Perches wrote:
> These structs can be const, so make them const.
> 
> Miscellanea:
> 
> o Add static to struct uart_ops declaration in bfin_sport_uart
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
[...]

For:
>  drivers/tty/serial/xilinx_uartps.c          | 2 +-

Tested-by: Sören Brinkmann <soren.brinkmann@xilinx.com>

	Sören
