From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 10 Jan 2009 07:33:21 +0000
Subject: Re: sparc32 broke
Message-Id: <20090110073321.GA3058@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <49669B15.7020107@earthlink.net>
In-Reply-To: <49669B15.7020107@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 09, 2009 at 10:22:04PM -0800, David Miller wrote:
> From: Robert Reif <reif@earthlink.net>
> Date: Fri, 09 Jan 2009 23:19:19 -0500
> 
> > I bisected it down to: ece93487c31607558f4b91f378fcee4b43956dbc
> > sparc: unify signal.h
> 
> Sam, the first thing I notice is that _NSIG_BPW changed.
> 
> It's supposed to be 32 for sparc32 and 64 for sparc64.
> But now it's unconditionally 64 in the unified header.
> This also makes _NSIG_WORDS et al. wrong.

I cannot explain why this happened - it is obviously buggy.

    Sorry!

I will re-review the commit later today after I get some coffee.

Thanks for testing & bisect Robert!

> 
> diff --git a/arch/sparc/include/asm/signal.h b/arch/sparc/include/asm/signal.h
> index 41535e7..047fbd0 100644
> --- a/arch/sparc/include/asm/signal.h
> +++ b/arch/sparc/include/asm/signal.h
> @@ -84,7 +84,7 @@
>  
>  #define __OLD_NSIG	32
>  #define __NEW_NSIG      64
> -#define _NSIG_BPW       64
> +#define _NSIG_BPW       CONFIG_BITS

The real fix should look like this:

#ifdef __arch64__
#define _NSIG_BPW       64
#else
#define _NSIG_BPW       64
#endif

This is required because this header is exported to userspace
where we do not have access to CONFIG_* symbols.

	Sam
