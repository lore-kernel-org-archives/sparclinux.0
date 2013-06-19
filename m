From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jun 2013 09:14:07 +0000
Subject: Re: [PATCH] sparc32, leon: Enable interrupts before going idle to avoid getting stuck
Message-Id: <20130619.021407.407370247412707667.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1370847401-766-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1370847401-766-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 10 Jun 2013 08:56:41 +0200

> This enables interrupts for Leon before having the CPU enter power-down mode.
> 
> Commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092, "sparc: Use generic idle loop",
> gets the CPU stuck on idle for Leon systems. On Leon, disabling interrupts and
> powering down the processor will get the processor stuck waiting for an
> interrupt that will never be reacted to.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied.
