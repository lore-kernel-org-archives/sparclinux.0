From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 03 Jan 2011 08:55:05 +0000
Subject: Re: [RFC PATCH] sparc: fake idprom for leon
Message-Id: <4D218EE9.7020505@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110102194024.GA31924@merkur.ravnborg.org>
In-Reply-To: <20110102194024.GA31924@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sam,

Thanks for the patch. However we are actually faking the idprom in the bootloader instead. So there is an idprom property. 

We have released a new Linux "distribution" for LEON, see this message on the leon_sparc mailing list:
http://tech.groups.yahoo.com/group/leon_sparc/message/19138

It is a work in progress but it is probably of interest to you. It also includes new patches that has not yet been sent to this mailing list but will be soon.

How the get the MAC address is quite implementation dependent though. Our GRETH ethernet driver supports getting it from idprom, OF tree or as a module parameter. 

Happy hacking,
Kristoffer


Sam Ravnborg wrote:
> Hi Kristoffer & David.
> 
> Following is a very naive implementation of
> a fake idprom for leon.
> 
> This is only for inspiration as I hope
> that it is possible to find the MAC address
> somehow so we present it correct.
> 
> One advantage of using a fake idprom is that all places
> that do access idprom no longer needs to be ifdeffed out.
> Today floppy.h reads idprom unconditionally.
> 
> 	Sam
> 
> diff --git a/arch/sparc/prom/misc_32.c b/arch/sparc/prom/misc_32.c
> index 4d61c54..ee5fe45 100644
> --- a/arch/sparc/prom/misc_32.c
> +++ b/arch/sparc/prom/misc_32.c
> @@ -10,7 +10,9 @@
>  #include <linux/sched.h>
>  #include <linux/module.h>
>  
> +#include <asm/machines.h>
>  #include <asm/openprom.h>
> +#include <asm/idprom.h>
>  #include <asm/oplib.h>
>  #include <asm/auxio.h>
>  #include <asm/system.h>
> @@ -93,6 +95,42 @@ prom_setsync(sfunc_t funcp)
>  	*romvec->pv_synchook = funcp;
>  }
>  
> +#ifdef CONFIG_SPARC_LEON
> +/*
> + * leon do not have idprom support - so fake it.
> + * The machine type is hardcoded to M_LEON
> + * We do not know the ethernet address so it is all-zero.
> + */
> +
> +/* Calculate the IDPROM checksum (xor of the data bytes). */
> +static unsigned char calc_idprom_cksum(struct idprom *idprom)
> +{
> +        unsigned char cksum, i, *ptr = (unsigned char *)idprom;
> +
> +        for (i = cksum = 0; i <= 0x0E; i++)
> +                cksum ^= *ptr++;
> +
> +        return cksum;
> +}
> +
> +unsigned char
> +prom_get_idprom(char *idbuf, int num_bytes)
> +{
> +	struct idprom *idprom;
> +
> +	if (num_bytes < sizeof(struct idprom))
> +		return 0xff;
> +
> +	idprom = (struct idprom *)idbuf;
> +	memset(idprom, 0, sizeof(*idprom));
> +	idprom->id_format = 0x01;
> +	idprom->id_machtype = M_LEON | M_LEON3_SOC;
> +	idprom->id_cksum = calc_idprom_cksum(idprom);
> +
> +	return 0x01;
> +}
> +
> +#else
>  /* Get the idprom and stuff it into buffer 'idbuf'.  Returns the
>   * format type.  'num_bytes' is the number of bytes that your idbuf
>   * has space for.  Returns 0xff on error.
> @@ -109,7 +147,7 @@ prom_get_idprom(char *idbuf, int num_bytes)
>  
>  	return 0xff;
>  }
> -
> +#endif
>  /* Get the major prom version number. */
>  int
>  prom_version(void)
> 
> 

