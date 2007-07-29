From: David Miller <davem@davemloft.net>
Date: Sun, 29 Jul 2007 05:53:26 +0000
Subject: Re: [PATCH] v2.6.23-rc1 Sparc32 Serial Port Selection error
Message-Id: <20070728.225326.115910169.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 03:17:39 +0100 (BST)

> Hi David,
> 
> The serial console code selection code needs to select the ports the 
> otherway around. The attached patch fixes the problem.
> 
> --- linux-test/arch/sparc/kernel/prom.c~	2007-07-28 21:02:31.000000000 +0100
> +++ linux-test/arch/sparc/kernel/prom.c	2007-07-29 02:38:54.000000000 +0100
> @@ -460,7 +460,7 @@
>   		strcpy(of_console_path, dp->full_name);
>   		if (!strcmp(type, "serial")) {
>   			strcat(of_console_path,
> -			       (skip ? ":b" : ":a"));
> +			       (skip ? ":a" : ":b"));
>   		}
>   		break;

Thanks for tracking this down, I'll have a look at it more
deeply and apply this.
