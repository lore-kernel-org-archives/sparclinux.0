From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jan 2011 22:11:07 +0000
Subject: Re: [PATCH] debug: allow to retain boot console via boot option
Message-Id: <20110110.141107.26955747.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1294649883-31614-1-git-send-email-fabbione@fabbione.net>
In-Reply-To: <1294649883-31614-1-git-send-email-fabbione@fabbione.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Fabio M. Di Nitto" <fabbione@fabbione.net>
Date: Mon, 10 Jan 2011 09:58:03 +0100

> On some architectures, the boot process involves de-registering the boot
> console (early boot), initialize drivers and then re-register the console.
> 
> This mechanism introduces a window in which no printk can happen on the console
> and messages are buffered and then printed once the new console is available.
> 
> If a kernel crashes during this window, all it's left on the boot console
> is "console [foo] enabled, bootconsole disabled" making debug of the crash
> rather 'interesting'.
> 
> By adding "keep_bootcon" option, do not unregister the boot console, that
> will allow to printk everything that is happening up to the crash.
> 
> The option is clearly meant only for debugging purposes as it introduces lots
> of duplicated info printed on console, but will make bug report from users
> easier as it doesn't require a kernel build just to figure out where we crash.
> 
> Signed-off-by: Fabio M. Di Nitto <fabbione@fabbione.net>

Acked-by: David S. Miller <davem@davemloft.net>
