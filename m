From: David Miller <davem@davemloft.net>
Date: Fri, 20 Apr 2012 03:56:02 +0000
Subject: Re: [PATCH 1/1] sparc: task_cpu() for stopper thread on sparc32 returns 0
Message-Id: <20120419.235602.266003767868541080.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1334827362-3434-1-git-send-email-konrad@gaisler.com>
	<20120419153428.GB1120@merkur.ravnborg.org>
	<20120420033634.GA13068@zhy>
In-Reply-To: <20120420033634.GA13068@zhy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yong.zhang0@gmail.com
Cc: sam@ravnborg.org, konrad@gaisler.com, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, daniel@gaisler.com

From: Yong Zhang <yong.zhang0@gmail.com>
Date: Fri, 20 Apr 2012 11:36:34 +0800

> diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
> index 1210fde..bb017e7 100644
> --- a/arch/sparc/kernel/leon_smp.c
> +++ b/arch/sparc/kernel/leon_smp.c
> @@ -78,6 +78,8 @@ void __cpuinit leon_callin(void)
>  	local_flush_tlb_all();
>  	leon_configure_cache_smp();
>  
> +	notify_cpu_starting(cpuid);
> +

This is the most reasonable theory I've seen for this
problem :-)

