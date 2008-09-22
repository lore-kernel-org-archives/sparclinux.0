From: "Eric Brower" <ebrower@gmail.com>
Date: Mon, 22 Sep 2008 04:16:43 +0000
Subject: Re: [PATCH 1/1]: sparc: arch/sparc/kernel/pmc.c -- extra #include?
Message-Id: <ec7cefb0809212116l43d2f457sd162a2b32b343cc0@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080921.002946.171050386.davem@davemloft.net>
In-Reply-To: <20080921.002946.171050386.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

PMC contains a backlight control for the Voyager display; ioctl
support for controlling it was prototyped but never integrated into
the driver, so removal of the miscdevice support is fair.

E

On Sun, Sep 21, 2008 at 12:29 AM, David Miller <davem@davemloft.net> wrote:
>
> I just applied the following patch sent to me privately from David
> Brownell to sparc-next-2.6
>
> From: David Brownell <david-b@pacbell.net>
>
> sparc: arch/sparc/kernel/pmc.c -- extra #include?
>
> I have no SPARC compiler handy to verify, but it looks like this
> is another file that doesn't need <linux/miscdevices.h> ...
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/kernel/pmc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
> index 814eb3c..2afcfab 100644
> --- a/arch/sparc/kernel/pmc.c
> +++ b/arch/sparc/kernel/pmc.c
> @@ -8,7 +8,6 @@
>  #include <linux/fs.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
> -#include <linux/miscdevice.h>
>  #include <linux/pm.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -24,7 +23,6 @@
>  * #define PMC_NO_IDLE
>  */
>
> -#define PMC_MINOR      MISC_DYNAMIC_MINOR
>  #define PMC_OBPNAME    "SUNW,pmc"
>  #define PMC_DEVNAME "pmc"
>
> --
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
E
