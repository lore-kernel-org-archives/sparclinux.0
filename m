From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 06 Jan 2011 14:08:58 +0000
Subject: Re: [PATCH v2] cassini: Use local-mac-address prom property for
Message-Id: <20110106140858.GA15235@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294321167.6193.69.camel@duncow>
In-Reply-To: <1294321167.6193.69.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 06, 2011 at 01:39:27PM +0000, Richard Mortimer wrote:
> Fallback on the local-mac-address prom property if the Cassini device
> does not have an address programmed in the VPD ROM. This uses the same
> technique as implemented by the sungem driver.
> 
> The problem was reported by Frans van Berckel using Debian kernel 2.6.34-7
> on Sun Fire V440. udev was assigning a new eth<n> device name on each reboot
> because the cassini driver was using a random MAC address.
> 
> Fix tested on 2.6.34-7/Sun Fire V440. Compile tested only against 2.6.36
> davem/sparc-2.6.git because Sun Fire V440 does not currently boot recent
> kernels so runtime test is not possible at present.
> 
> Reported-by: Frans van Berckel <fberckel@xs4all.nl>
> Tested-by: Frans van Berckel <fberckel@xs4all.nl>
> Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
> Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>
> ---
>  drivers/net/cassini.c |   20 ++++++++++++++++++++
>  drivers/net/cassini.h |    3 +++
>  2 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/cassini.c b/drivers/net/cassini.c
> index d6b6d6a..08ef2f9 100644
> --- a/drivers/net/cassini.c
> +++ b/drivers/net/cassini.c
> @@ -82,6 +82,10 @@
>  #include <linux/highmem.h>
>  #include <linux/list.h>
>  #include <linux/dma-mapping.h>
> +#if defined(CONFIG_OF)
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#endif

The ifdefs are not required - the files include these already.

	Sam
