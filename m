From: David Miller <davem@davemloft.net>
Date: Fri, 19 May 2017 02:32:20 +0000
Subject: Re: [PATCH 6/6] arch/sparc: Enable queued spinlock support for SPARC
Message-Id: <20170518.223220.105988940116687879.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
        <1495154170-854693-7-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495154170-854693-7-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: babu.moger@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 18 May 2017 18:36:10 -0600

> @@ -83,6 +83,7 @@ config SPARC64
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select HAVE_NMI
>  	select ARCH_USE_QUEUED_RWLOCKS
> +	select ARCH_USE_QUEUED_SPINLOCKS
>  
>  config ARCH_DEFCONFIG
>  	string

Like the queued spinlock enabling patch, if this will be on
all the time for SPARC64 then:

> diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/spinlock_64.h
> index 562dbd8..e2044e3 100644
> --- a/arch/sparc/include/asm/spinlock_64.h
> +++ b/arch/sparc/include/asm/spinlock_64.h
> @@ -11,6 +11,9 @@
>  #include <asm/processor.h>
>  #include <asm/barrier.h>
>  
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#include <asm/qspinlock.h>
> +#else

This ifdef doesn't make any sense, by definition it will always be on.
