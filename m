From: David Miller <davem@davemloft.net>
Date: Mon, 21 Apr 2014 17:32:06 +0000
Subject: Re: [PATCH 24/24] sparc32: fix sparse warnings in leon_smp.c
Message-Id: <20140421.133206.1604887618328419082.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1398100356-19794-24-git-send-email-sam@ravnborg.org>
In-Reply-To: <1398100356-19794-24-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:12:36 +0200

> -void leon_cpu_pre_starting(void *arg);
> -void leon_cpu_pre_online(void *arg);
> +extern void leon_cpu_pre_starting(void *arg);
> +extern void leon_cpu_pre_online(void *arg);
> +extern void leonsmp_ipi_interrupt(void);
> +extern void leon_cross_call_irq(void);

For header files, we are moving away from specifying extern for external
function declarations.

In the networking, we've made this transformation in all of our headers
already, for example.

So if anything, you should be changing things to other way around.
