From: David Miller <davem@davemloft.net>
Date: Sun, 05 May 2013 01:32:37 +0000
Subject: Re: [PATCH] sparc32, leon: Do not overwrite previously set irq flow handlers
Message-Id: <20130504.213237.646117576001911507.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 22 Apr 2013 09:23:06 +0200

> This is needed because when scan_of_devices finds the GAISLER_GPTIMER
> core that corresponds to the SMP "ticker" timer, the previously set
> proper irq flow handler gets overwritten with an incorrect one. This
> leads to very flaky timer interrupt handling on some hardware. Proper
> updates to handlers can still be done using leon_update_virq_handling.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied.
