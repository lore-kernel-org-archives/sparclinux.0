From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed, 21 Dec 2016 17:16:41 +0000
Subject: Re: [PATCH] sparc64: shut down to OBP correctly
Message-Id: <20161221171641.GA28792@ubuette>
List-Id: <sparclinux.vger.kernel.org>
References: <1482340333-65764-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1482340333-65764-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 21 Dec 16 09:12, Larry Bassel wrote:
> Orabug: 24789774

My apologies -- this line likely should not be in this patch -- I'm sending
a v2.

Larry

> 
> The command "shutdown -h -H now" should shut down the system to
> OBP, however the machine was incorrectly being powered off instead
> (on both LDOM and bare metal).
> 
> The "exit" command to the OBP must be run and then a hard
> loop to prevent return to the kernel.
> 
> Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
> ---
>  arch/sparc/prom/misc_64.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
> index 53a696d..aa80788 100644
> --- a/arch/sparc/prom/misc_64.c
> +++ b/arch/sparc/prom/misc_64.c
> @@ -115,16 +115,11 @@ void notrace prom_halt(void)
>  {
>  	unsigned long args[3];
>  
> -#ifdef CONFIG_SUN_LDOMS
> -	if (ldom_domaining_enabled)
> -		ldom_power_off();
> -#endif
> -again:
>  	args[0] = (unsigned long) "exit";
>  	args[1] = 0;
>  	args[2] = 0;
>  	p1275_cmd_direct(args);
> -	goto again; /* PROM is out to get me -DaveM */
> +	while (1);
>  }
>  
>  void prom_halt_power_off(void)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
