From: David Miller <davem@davemloft.net>
Date: Fri, 19 May 2017 02:31:13 +0000
Subject: Re: [PATCH 4/6] arch/sparc: Enable queued rwlocks for SPARC
Message-Id: <20170518.223113.1783186374793423172.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
        <1495154170-854693-5-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495154170-854693-5-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: babu.moger@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 18 May 2017 18:36:08 -0600

> @@ -82,6 +82,7 @@ config SPARC64
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select HAVE_NMI
> +	select ARCH_USE_QUEUED_RWLOCKS
>  

If you are selecting this on SPARC64 all the time, then:

> @@ -94,6 +94,7 @@ static inline void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long fla
>  	: "memory");
>  }
>  
> +#ifndef CONFIG_QUEUED_RWLOCKS
>  /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */

You can remove this segment of ifdef'd code altogether since it is in
a sparc64 specific header file.
