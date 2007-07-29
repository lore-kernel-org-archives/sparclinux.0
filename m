From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 08:42:00 +0000
Subject: Re: [PATCH] v2.6.23-rc1 Sparc32 Serial Port Selection error
Message-Id: <Pine.LNX.4.61.0707290932050.30117@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sun, 29 Jul 2007, David Miller wrote:

> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Sun, 29 Jul 2007 08:55:25 +0100 (BST)
>
>> Yes but then you do a !skip-- so 0 -> -1 and 1 -> 0
>
> Indeed.  This is coded in a very non-intuitive manner.  The code
> selecting the string wants to use the original value of "skip", not
> the one modified by the node traversal loop.
>
> Perhaps the following version of the fix is a little clearer.
> What do you think?
>

This also has the advantage that if any sparc32 systems have more than the 
usual two serial console ports, they can be added in relativly easilly. I 
think SBUS serial card I currently have in my SS1 can provide another four 
serial ports for use as console ports, if I put it in the SS2 and write a 
linux driver for it (I have the NetBSD driver source but have not got 
around to porting it yet). The SS1 Prom has an issue with the FCode so the 
extar ports are not available.

> diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
> index e3a5376..39fbd3c 100644
> --- a/arch/sparc/kernel/prom.c
> +++ b/arch/sparc/kernel/prom.c
> @@ -415,7 +415,7 @@ static void __init of_console_init(void)
> 	unsigned long flags;
> 	const char *type;
> 	phandle node;
> -	int skip, fd;
> +	int skip, tmp, fd;
>
> 	of_console_path = prom_early_alloc(256);
>
> @@ -442,8 +442,9 @@ static void __init of_console_init(void)
> 			prom_halt();
> 		}
>
> +		tmp = skip;
> 		for_each_node_by_type(dp, type) {
> -			if (!skip--)
> +			if (!tmp--)
> 				break;
> 		}
> 		if (!dp) {
>
