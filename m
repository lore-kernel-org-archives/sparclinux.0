From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 21 May 2019 14:54:32 +0000
Subject: Re: [PATCH] tracing: fix typos in code and comments
Message-Id: <20190521145432.GB3491@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190521144740.22490-1-houweitao@xiaomi.com>
In-Reply-To: <20190521144740.22490-1-houweitao@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: houweitao <houweitaoo@gmail.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, festevam@gmail.com, linus.walleij@linaro.org, baohua@kernel.org, rostedt@goodmis.org, davem@davemloft.net, yamada.masahiro@socionext.com, mingo@redhat.com, linux-imx@nxp.com, kernel@pengutronix.de, jslaby@suse.com, sparclinux@vger.kernel.org, houweitao <houweitao@xiaomi.com>, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Tue, May 21, 2019 at 10:47:40PM +0800, houweitao wrote:
> fix ingore to ignore in kernel; since there are other
> mistakes can be found with "git grep ",fix all
> 
> Signed-off-by: houweitao <houweitao@xiaomi.com>
> ---
>  drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 2 +-
>  drivers/rtc/rtc-sirfsoc.c                        | 2 +-
>  drivers/tty/serial/mxs-auart.c                   | 2 +-
>  drivers/tty/serial/serial_txx9.c                 | 2 +-
>  drivers/tty/serial/sunsab.c                      | 2 +-
>  kernel/trace/trace.c                             | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

You have to split this up into patches for different subsystems, and use
your real name.

thanks,

greg k-h
