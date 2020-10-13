From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 13 Oct 2020 05:14:40 +0000
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions; use string size
Message-Id: <8d8eba94-8d6d-fbad-f24a-e65282403833@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
In-Reply-To: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Witten <mfwitten@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi--

Here are a few corrections for the source code.

On 9/4/20 12:40 PM, Michael Witten wrote:
> The following patch improves the quality and correctness of the openprom code.
> 
> I have neither a machine to test the result nor a toolchain to compile it, and
> that is why it is listed currently as an "RFC". Nonetheless, I believe those

what is your host build system?

https://mirrors.edge.kernel.org/pub/tools/crosstool/

> who do have these tools will find the proposed changes useful; I hope you will
> help me iterate this patch into something worthy of merging (or use it as the
> basis for your own changes).
> 
> Sincerely,
> Michael Witten
> 
> --8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--
> 
...

> 
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>   arch/sparc/include/asm/prom.h   |   2 +-
>   arch/sparc/kernel/prom_common.c |  14 +--
>   drivers/sbus/char/openprom.c    | 263 ++++++++++++++++++++++++++++------------
>   3 files changed, 194 insertions(+), 85 deletions(-)
> 


> diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
> index 30b9751aad30..9bc2877aa09a 100644
> --- a/drivers/sbus/char/openprom.c
> +++ b/drivers/sbus/char/openprom.c


> @@ -120,69 +154,109 @@ static int getstrings(struct openpromio __user *info, struct openpromio **opp_p)

> -static int opromgetprop(void __user *argp, struct device_node *dp, struct openpromio *op, int bufsize)
> +static int opromgetprop(void __user *argp, struct device_node *dp, struct openpromio *op, const size_t bufsize)
>   {
>   	const void *pval;
> -	int len;
> +	int pval_size;
>   
>   	if (!dp ||
> -	    !(pval = of_get_property(dp, op->oprom_array, &len)) ||
> -	    len <= 0 || len > bufsize)
> +	    !(pval = of_get_property(dp, op->oprom_array, &pval_size)) ||
> +	    pval_size <= 0 || pval_size > bufsize) {
> +		#ifdef CONFIG_DEBUG_KERNEL
> +			if (WARN_ON(op->oprom_size))
> +				op->oprom_size = 0;
> +		#endif
>   		return copyout(argp, op, sizeof(int));
> +	}
> +
> +	op->oprom_size = pval_size;
> +	memcpy(op->oprom_array, pval, pval_size);
>   
> -	memcpy(op->oprom_array, pval, len);
> -	op->oprom_array[len] = '\0';
> -	op->oprom_size = len;
> +	#ifdef CONFIG_DEBUG_KERNEL
> +		// If the buffer is larger than needed, then
> +		// the contents should be nul-terminated in
> +		// case the PROM erroneously produces a string
> +		// that is not nul-terminated.
> +		if (pval_size < bufsize)
> +			char *const end = op->oprom_array + pval_size;
> +			if (WARN_ON(*end))
> +				*end = 0;

Missing braces above?

> +	#endif
>   
>   	return copyout(argp, op, sizeof(int) + bufsize);
>   }
>   
> -static int opromnxtprop(void __user *argp, struct device_node *dp, struct openpromio *op, int bufsize)
> +static int opromnxtprop(void __user *argp, struct device_node *dp, struct openpromio *op, const size_t bufsize)
>   {
>   	struct property *prop;
> -	int len;
> +	size_t name_size;
> +	unsigned int uint_name_size;
>   
>   	if (!dp)
> -		return copyout(argp, op, sizeof(int));
> +		goto nothing;
> +
>   	if (op->oprom_array[0] = '\0') {
>   		prop = dp->properties;
> -		if (!prop)
> -			return copyout(argp, op, sizeof(int));
> -		len = strlen(prop->name);
>   	} else {
>   		prop = of_find_property(dp, op->oprom_array, NULL);
> +		if (prop)
> +			prop = prop->next;
> +	}
>   
> -		if (!prop ||
> -		    !prop->next ||
> -		    (len = strlen(prop->next->name)) + 1 > bufsize)
> -			return copyout(argp, op, sizeof(int));
> +	if (!prop)
> +		goto nothing;
>   
> -		prop = prop->next;
> -	}
> +	name_size = 1 + strlen(prop->name);
> +
> +	uint_name_size = name_size;
> +	if (unlikely(uint_name_size != name_size))
> +		goto nothing; // overflow
> +
> +	if (name_size > bufsize)
> +		goto nothing;
>   
> -	memcpy(op->oprom_array, prop->name, len);
> -	op->oprom_array[len] = '\0';
> -	op->oprom_size = ++len;
> +	memcpy(op->oprom_array, prop->name, name_size);
> +	op->oprom_size = uint_name_size;
>   
>   	return copyout(argp, op, sizeof(int) + bufsize);
> +
> +nothing:
> +	#ifdef CONFIG_DEBUG_KERNEL
> +		if (WARN_ON(op->oprom_size))
> +			op-oprom_size = 0;

			op->oprom_size = 0;


> +	#endif
> +	return copyout(argp, op, sizeof(int));
>   }
>   




> @@ -301,6 +384,12 @@ static long openprom_sunos_ioctl(struct file * file,
>   	else
>   		bufsize = copyin(argp, &opp);
>   
> +	#ifdef CONFIG_DEBUG_KERNEL
> +		if (WARN_ON(bufsize = 0))
> +			bufsize = -EFAULT;
> +	#enif

	#endif

> +
> +	static_assert(LONG_MIN <= -(SIZE_MAX/2)-1);
>   	if (bufsize < 0)
>   		return bufsize;
>   



HTH.
--
~Randy
