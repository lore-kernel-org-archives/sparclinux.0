From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Mon, 04 Apr 2016 04:52:00 +0000
Subject: Re: [PATCH v4 5/5] printk/nmi: flush NMI messages on the system panic
Message-Id: <20160404045200.GE6164@swordfish>
List-Id: <sparclinux.vger.kernel.org>
References: <1459353210-20260-6-git-send-email-pmladek@suse.com>
 <201603310000.dKufp7mg%fengguang.wu@intel.com>
 <20160331123657.GN5522@pathway.suse.cz>
In-Reply-To: <20160331123657.GN5522@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

On (03/31/16 14:36), Petr Mladek wrote:
[..]
>  #ifdef CONFIG_PRINTK_NMI
> +#define deferred_console_in_nmi() in_nmi()
>  #else
> +#define deferred_console_in_nmi() 0
[..]
> +	if (!in_sched && !deferred_console_in_nmi()) {
>  		lockdep_off();
>  		/*
>  		 * Try to acquire and then immediately release the console

or use SCHED level for nmi messages instead of defining deferred_console_in_nmi()?
so !in_sched will work for both SCHED and NMI messages.

	-ss
