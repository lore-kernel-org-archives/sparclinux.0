From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 05 Jan 2018 17:58:34 +0000
Subject: Re: [PATCH v7 07/10] kernel/jump_label: abstract jump_entry member accessors
Message-Id: <20180105175834.vqgpsme7itsdg54u@armageddon.cambridge.arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-8-ard.biesheuvel@linaro.org>
In-Reply-To: <20180102200549.22984-8-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 02, 2018 at 08:05:46PM +0000, Ard Biesheuvel wrote:
> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
> index e12d7d096fc0..7b05b404063a 100644
> --- a/arch/arm/include/asm/jump_label.h
> +++ b/arch/arm/include/asm/jump_label.h
> @@ -45,5 +45,32 @@ struct jump_entry {
>  	jump_label_t key;
>  };
>  
> +static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
> +{
> +	return entry->code;
> +}
> +
> +static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
> +{
> +	return (struct static_key *)((unsigned long)entry->key & ~1UL);
> +}
> +
> +static inline bool jump_entry_is_branch(const struct jump_entry *entry)
> +{
> +	return (unsigned long)entry->key & 1UL;
> +}
> +
> +static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
> +{
> +	return entry->code = 0;
> +}
> +
> +static inline void jump_entry_set_module_init(struct jump_entry *entry)
> +{
> +	entry->code = 0;
> +}
> +
> +#define jump_label_swap		NULL

Is there any difference between these functions on any of the
architectures touched? Even with the relative offset, arm64 and x86
looked the same to me (well, I may have missed some detail).

-- 
Catalin
