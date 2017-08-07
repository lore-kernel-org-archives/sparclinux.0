From: David Miller <davem@davemloft.net>
Date: Mon, 07 Aug 2017 04:11:29 +0000
Subject: Re: [PATCH v1 07/13] sparc64: vcc: Enable LDC event processing engine
Message-Id: <20170806.211129.1639660390915696585.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <06dccdc7a1d8ce6aa507f1b164185cd508d4055e.1501781770.git.jag.raman@oracle.com>
In-Reply-To: <06dccdc7a1d8ce6aa507f1b164185cd508d4055e.1501781770.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Thu,  3 Aug 2017 13:43:59 -0400

> Enable event processing engine to handle LDC events
> 
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/tty/vcc.c |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index 84a8dd7..8f4afdb 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -443,8 +443,39 @@ static void vcc_tx_timer(unsigned long index)
>  	vcc_put(port, false);
>  }
>  
> +/**
> + * vcc_event() - LDC event processing engine
> + * @arg: VCC private data
> + * @event: LDC event
> + *
> + * Handles LDC events for VCC
> + */
>  static void vcc_event(void *arg, int event)
>  {
> +	struct vcc_port *port = (struct vcc_port *)arg;

Casts from void to other pointer types is never necessary, that's the
entire point of a void pointer.

So please remove this cast.

Please audit your entire submission for this issue.

Thanks.
