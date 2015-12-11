From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 11 Dec 2015 22:57:25 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
In-Reply-To: <20151211124159.GB3729@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 11 Dec 2015 13:41:59 +0100 Petr Mladek <pmladek@suse.com> wrote:

> On Fri 2015-12-11 12:10:02, Geert Uytterhoeven wrote:
> > On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
> > >                      13 =>   8 KB for each CPU
> > >                      12 =>   4 KB for each CPU
> > >
> > > +config NMI_LOG_BUF_SHIFT
> > > +       int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
> > > +       range 10 21
> > > +       default 13
> > > +       depends on PRINTK && HAVE_NMI
> > 
> > Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.
> 
> __h, the NMI buffer is enabled on arm via NEED_PRINTK_NMI.
> 
> The buffer is compiled when CONFIG_PRINTK_NMI is defined. I am going
> to fix it the following way:
> 
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index efcff25a112d..61cfd96a3c96 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
>  	int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
>  	range 10 21
>  	default 13
> -	depends on PRINTK && HAVE_NMI
> +	depends on PRINTK_NMI
>  	help
>  	  Select the size of a per-CPU buffer where NMI messages are temporary
>  	  stored. They are copied to the main log buffer in a safe context

I'm wondering why we're building kernel/printk/nmi.o if HAVE_NMI is not
set.

	obj-$(CONFIG_PRINTK_NMI)		+= nmi.o

and

	config PRINTK_NMI
		def_bool y
		depends on PRINTK
		depends on HAVE_NMI || NEED_PRINTK_NMI

This is a bit messy.  NEED_PRINTK_NMI is an added-on hack for one
particular arm variant.  From the changelog:

   "One exception is arm where the deferred printing is used for
    printing backtraces even without NMI.  For this purpose, we define
    NEED_PRINTK_NMI Kconfig flag.  The alternative printk_func is
    explicitly set when IPI_CPU_BACKTRACE is handled."


- why does arm needs deferred printing for backtraces?

- why is this specific to CONFIG_CPU_V7M?

- can this Kconfig logic be cleaned up a bit?

