From: David Miller <davem@davemloft.net>
Date: Mon, 07 Aug 2017 04:10:32 +0000
Subject: Re: [PATCH v1 06/13] sparc64: vcc: Add RX & TX timer for delayed LDC operation
Message-Id: <20170806.211032.552299424426494803.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <92bf7beadd3d50f0c6e27578c00c96bfc1bf296e.1501781770.git.jag.raman@oracle.com>
In-Reply-To: <92bf7beadd3d50f0c6e27578c00c96bfc1bf296e.1501781770.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Thu,  3 Aug 2017 13:43:58 -0400

> @@ -52,10 +53,15 @@ struct vcc_port {
>  
>  #define VCC_MAX_PORTS		1024
>  #define VCC_MINOR_START		0	/* must be zero */
> +#define VCC_BUFF_LEN		VIO_VCC_MTU_SIZE
>  
>  #define VCC_CTL_BREAK		-1
>  #define VCC_CTL_HUP		-2
>  
> +#define TIMER_SET(v, x, t)	((v)->x##_timer.expires = (t))
> +#define TIMER_CLEAR(v, x)	((v)->x##_timer.expires = 0)
> +#define TIMER_ACTIVE(v, x)	((v)->x##_timer.expires)

Please, these timer macros just make the code more complicated and
harder to understand.

Just modify and test the timers in the canonical direct way, just like
any other piece of code in the kernel.

And using the expires field is wrong for testing timer state.
Routines like __mod_timer() (and therefore mod_timer(), add_timer(),
etc.) modify it (potentially asynchronously).

You can use timer_pending().  But you must perform appropriate
synchronization with the timer itself and any piece of your code which
deletes, adds, or modifies the timer.

Thanks.
