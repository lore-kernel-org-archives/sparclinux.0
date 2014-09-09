From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 23:40:35 +0000
Subject: Re: [PATCH] sparc: leon: Fix race condition between leon_cycles_offset and timer_interrupt
Message-Id: <20140909.164035.1538611197997884601.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1409324958-22902-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1409324958-22902-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, sam@ravnborg.org, linux-kernel@vger.kernel.org, software@gaisler.com

From: Andreas Larsson <andreas@gaisler.com>
Date: Fri, 29 Aug 2014 17:09:18 +0200

> This makes sure that leon_cycles_offset takes the pending bit into
> account and that leon_clear_clock_irq clears the pending bit. Otherwise,
> if leon_cycles_offset is executed after the timer has wrapped but before
> timer_interrupt has increased timer_cs_internal_counter, time can be
> perceived to go backwards.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied.
