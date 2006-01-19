From: Jim Gifford <maillist@jg555.com>
Date: Thu, 19 Jan 2006 00:32:43 +0000
Subject: Re: Build Issue - Sparc64
Message-Id: <43CEDE2B.7050705@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <43C6A8A3.9090100@jg555.com>
In-Reply-To: <43C6A8A3.9090100@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
> index 1dc3650..059b0d0 100644
> --- a/arch/sparc64/kernel/process.c
> +++ b/arch/sparc64/kernel/process.c
> @@ -164,6 +164,7 @@ void machine_restart(char * cmd)
>  	panic("Reboot failed!");
>  }
>  
> +#ifdef CONFIG_COMPAT
>  static void show_regwindow32(struct pt_regs *regs)
>  {
>  	struct reg_window32 __user *rw;
> @@ -189,6 +190,9 @@ static void show_regwindow32(struct pt_r
>  	       r_w.ins[0], r_w.ins[1], r_w.ins[2], r_w.ins[3],
>  	       r_w.ins[4], r_w.ins[5], r_w.ins[6], r_w.ins[7]);
>  }
> +#else
> +#define show_regwindow32(regs)	do { } while (0)
> +#endif
>  
>  static void show_regwindow(struct pt_regs *regs)
>  {
>   
Worked like a champ. Thank you.

-- 
----
Jim Gifford
maillist@jg555.com

