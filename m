From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jun 2013 09:14:02 +0000
Subject: Re: [PATCH] sparc32, leon: Remove separate "ticker" timer for SMP
Message-Id: <20130619.021402.635755079704536632.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1370847208-20597-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1370847208-20597-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 10 Jun 2013 08:53:28 +0200

> This reduces the need from two timers to one timer.
> 
> Moreover, without this patch, when the "ticker" timer triggers timer_cs_read via
> tick_periodic it reads the value of the usual timer it can get an wrapped timer
> value without timer_cs_internal_counter having been updated leading to the clock
> going backwards. This effectively hangs one cpu that gets stuck in
> update_wall_time with an offset slightly smaller than 0xffffffffffffffff.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied.
