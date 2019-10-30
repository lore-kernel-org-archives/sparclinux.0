From: Kees Cook <keescook@chromium.org>
Date: Wed, 30 Oct 2019 18:34:35 +0000
Subject: Re: [PATCH] tty: n_hdlc: fix build on SPARC
Message-Id: <201910301131.2739AA83@keescook>
List-Id: <sparclinux.vger.kernel.org>
References: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
In-Reply-To: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, kbuild test robot <lkp@intel.com>

On Mon, Sep 30, 2019 at 07:15:12PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix tty driver build on SPARC by not using __exitdata.
> It appears that SPARC does not support section .exit.data.
> 
> Fixes these build errors:
> 
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 063246641d4a ("format-security: move static strings to const")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Wow. That commit is from 2.5 years ago. Is the SPARC port still alive?

> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/tty/n_hdlc.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- mmotm-2019-0925-1810.orig/drivers/tty/n_hdlc.c
> +++ mmotm-2019-0925-1810/drivers/tty/n_hdlc.c
> @@ -968,6 +968,11 @@ static int __init n_hdlc_init(void)
>  	
>  }	/* end of init_module() */
>  
> +#ifdef CONFIG_SPARC
> +#undef __exitdata
> +#define __exitdata
> +#endif

Shouldn't this be somewhere else? Any other driver wanting to use
__exitdata would need a similar patch. This feels like it should be
handled where __exitdata is normally defined?

-Kees

> +
>  static const char hdlc_unregister_ok[] __exitdata >  	KERN_INFO "N_HDLC: line discipline unregistered\n";
>  static const char hdlc_unregister_fail[] __exitdata > 
> 

-- 
Kees Cook
