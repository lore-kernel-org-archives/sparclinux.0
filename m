From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 20 Oct 2016 00:00:12 +0000
Subject: Re: [PATCH v2 1/2] watchdog: Introduce arch_watchdog_nmi_enable and arch_watchdog_nmi_disable
Message-Id: <20161019170012.6006d06d9326e62a8059fd08@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1476391082-77928-1-git-send-email-babu.moger@oracle.com>
        <1476391082-77928-2-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1476391082-77928-2-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: mingo@kernel.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

On Thu, 13 Oct 2016 13:38:01 -0700 Babu Moger <babu.moger@oracle.com> wrote:

> Currently we do not have a way to enable/disable arch specific
> watchdog handlers if it was implemented by any of the architectures.
> 
> This patch introduces new functions arch_watchdog_nmi_enable and
> arch_watchdog_nmi_disable which can be used to enable/disable architecture
> specific NMI watchdog handlers. These functions are defined as weak as
> architectures can override their definitions to enable/disable nmi
> watchdog behaviour.
> 
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -676,8 +660,13 @@ static void watchdog_nmi_disable(unsigned int cpu)
>  }
>  
>  #else
> -static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
> -static void watchdog_nmi_disable(unsigned int cpu) { return; }
> +/*
> + * These two functions are mostly architecture specific
> + * defining them as weak here.
> + */
> +int __weak arch_watchdog_nmi_enable(unsigned int cpu) { return 0; }
> +void __weak arch_watchdog_nmi_disable(unsigned int cpu) { return; }
> +
>  #endif /* CONFIG_HARDLOCKUP_DETECTOR */

This is a strange way of using __weak.

Take a look at (one of many examples) kernel/module.c:module_alloc(). 
We simply provide a default implementation and some other compilation
unit can override (actually replace) that at link time.  No strange
ifdeffing needed.

And I'm not really understanding the interaction with
CONFIG_HARDLOCKUP_DETECTOR here.  I haven't really worked out why the
code is all this way but it seems....  odd?


