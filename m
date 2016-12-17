From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 17 Dec 2016 01:05:40 +0000
Subject: Re: [PATCH] sbus: char: Move D7S_MINOR to include/linux/miscdevice.h
Message-Id: <CAGRGNgWMYM=mxF+XMfjh1xWvGb56Oz5nBhOf9si47FgMXrm_Sw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161215194703.11195-1-clabbe.montjoie@gmail.com>
In-Reply-To: <20161215194703.11195-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Corentin,

On Fri, Dec 16, 2016 at 6:47 AM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> This patch move the define for D7S_MINOR to include/linux/miscdevice.h.
> It's better that all minor number are in the same place.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/sbus/char/display7seg.c | 1 -
>  include/linux/miscdevice.h      | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
> index 33fbe82..48a5df0 100644
> --- a/drivers/sbus/char/display7seg.c
> +++ b/drivers/sbus/char/display7seg.c
> @@ -22,7 +22,6 @@
>
>  #include <asm/display7seg.h>
>
> -#define D7S_MINOR      193
>  #define DRIVER_NAME    "d7s"
>  #define PFX            DRIVER_NAME ": "
>
> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> index 5385d95..b1ba37aef 100644
> --- a/include/linux/miscdevice.h
> +++ b/include/linux/miscdevice.h
> @@ -33,6 +33,7 @@
>  #define I2O_MINOR              166
>  #define HWRNG_MINOR            183
>  #define MICROCODE_MINOR                184
> +#define D7S_MINOR              193

I was going to say "why not change the name to something more
descriptive" however they're all very abbreviated, so maybe consider a
second patch series to describe what each of these is for?

>  #define VFIO_MINOR             196
>  #define TUN_MINOR              200
>  #define CUSE_MINOR             203

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
