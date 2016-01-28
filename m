From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 28 Jan 2016 21:33:21 +0000
Subject: Re: [PATCH 30/31] Add debugger entry points for SPARC
Message-Id: <20160128213321.GA32054@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1454010468-29651-1-git-send-email-jeffmerkey@gmail.com>
In-Reply-To: <1454010468-29651-1-git-send-email-jeffmerkey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeffrey Merkey <jeffmerkey@gmail.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, linux.mdb@gmail.com, sparclinux@vger.kernel.org

Hi Jeff.

> +++ b/arch/sparc/include/asm/kdebug.h
> @@ -5,4 +5,9 @@
>  #else
>  #include <asm/kdebug_32.h>
>  #endif
> +
> +static inline void arch_breakpoint(void)
> +{
> +	asm("ta	$0x7d");
> +}
>  #endif
There seems to be some debugger infrastructure present already for kgdb,
but I assume this cannot be used.
Anyway - trap 0x7d is a debugger trap in sparc32.
If CONFIG_KGDB is not defined then 0x7d is just a regular BAD_TRAP.

For sparc64 trap 0x7d is something different.
I did not conclude what was the right choice for neither.

	Sam
