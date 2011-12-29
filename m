From: David Miller <davem@davemloft.net>
Date: Thu, 29 Dec 2011 23:12:36 +0000
Subject: Re: [PATCH 1/2] sparc32: enable different preemptions models
Message-Id: <20111229.181236.157689724253919194.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111229141508.GA3146@merkur.ravnborg.org>
In-Reply-To: <20111229141508.GA3146@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Dec 2011 15:15:08 +0100

> While chasing following warning from kconfig I noticed that the
> kconfig preemption model symbols were all dependent on sparc64.
> 
> warning: (PREEMPT && DEBUG_ATOMIC_SLEEP) selects PREEMPT_COUNT which has unmet direct dependencies (SPARC64)
> 
>>From arch/sparc/Kconfig:
> 
>         if SPARC64
>         source "kernel/Kconfig.preempt"
>         endif
> 
> But looking a bit closer I see nothing obvious why
> sparc32 should not support the various preemption models.
> Drop the "if SPARC64" conditional to enable selection of
> preemption model on sparc32 too.
> 
> Build-tested - but not run-time tested all three models.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
