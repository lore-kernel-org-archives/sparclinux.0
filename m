From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 11 Nov 2019 18:28:28 +0000
Subject: Re: [PATCH 8/8] Input: input_event: fix struct padding on sparc64
Message-Id: <20191111182828.GC57214@dtor-ws>
List-Id: <sparclinux.vger.kernel.org>
References: <20191108203435.112759-1-arnd@arndb.de>
 <20191108203435.112759-9-arnd@arndb.de>
In-Reply-To: <20191108203435.112759-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-input@vger.kernel.org

Hi Arnd,

On Fri, Nov 08, 2019 at 09:34:31PM +0100, Arnd Bergmann wrote:
> Going through all uses of timeval, I noticed that we screwed up
> input_event in the previous attempts to fix it:
> 
> The time fields now match between kernel and user space, but
> all following fields are in the wrong place.
> 
> Add the required padding that is implied by the glibc timeval
> definition to fix the layout, and add explicit initialization
> to avoid leaking kernel stack data.
> 
> Cc: sparclinux@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: stable@vger.kernel.org
> Fixes: 141e5dcaa735 ("Input: input_event - fix the CONFIG_SPARC64 mixup")
> Fixes: 2e746942ebac ("Input: input_event - provide override for sparc64")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/input/evdev.c       | 3 +++
>  drivers/input/misc/uinput.c | 3 +++
>  include/uapi/linux/input.h  | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index d7dd6fcf2db0..24a90793caf0 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -228,6 +228,9 @@ static void __pass_event(struct evdev_client *client,
>  						event->input_event_sec;
>  		client->buffer[client->tail].input_event_usec >  						event->input_event_usec;
> +#ifdef CONFIG_SPARC64
> +		client->buffer[client->tail].__pad = 0;
> +#endif
>  		client->buffer[client->tail].type = EV_SYN;
>  		client->buffer[client->tail].code = SYN_DROPPED;
>  		client->buffer[client->tail].value = 0;

I do not like ifdefs here, do you think we could write:

		client->buffer[client->tail] = (struct input_event) {
			.input_event_sec = event->input_event_sec,
			.input_event_usec = event->input_event_usec,
			.type = EV_SYN,
			.code = SYN_DROPPED,
		};

to ensure all padded fields are initialized? This is not hot path as we
do not expect queue to overfill too often.

Thanks.

-- 
Dmitry
