From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2017 19:58:50 +0000
Subject: Re: [PATCH 2/2] sparc64: Use cpu_poke to resume idle cpu
Message-Id: <20170720.125850.1894569815191415786.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
        <1499545424-415240-3-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1499545424-415240-3-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vijay.ac.kumar@oracle.com
Cc: sparclinux@vger.kernel.org, rob.gardner@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Sat,  8 Jul 2017 14:23:44 -0600

> diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
> index 2677312..0b070d5 100644
> --- a/arch/sparc/kernel/hvapi.c
> +++ b/arch/sparc/kernel/hvapi.c
> @@ -189,7 +189,7 @@ void __init sun4v_hvapi_init(void)
>  
>  	group = HV_GRP_CORE;
>  	major = 1;
> -	minor = 1;
> +	minor = 6; /* CPU POKE */
>  	if (sun4v_hvapi_register(group, major, &minor))
>  		goto bad;

That CPU POKE comment will not stand the test of time, please remove it.

> +	/* Use cpu poke to resume idle cpu if supported*/

Please put a space at the end of the comment and before the "*/"

> +		/*cpu poke is registered. */

Please put a space at the beginning of the comment.

And you should decide which way you want to consistently write.
Either capitalize the first word and finish the sentence with
a '.', or don't.  Do it the same way each time.

Thanks.
