From: David Miller <davem@davemloft.net>
Date: Fri, 08 Aug 2014 05:26:01 +0000
Subject: Re: [PATCH sparc] ldc_connect() should not return EINVAL when handshake is in progress.
Message-Id: <20140807.222601.2083689260924931879.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140801135040.GE19031@oracle.com>
In-Reply-To: <20140801135040.GE19031@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 7 Aug 2014 16:17:08 -0400

> vnet_start_xmit() already seems to have most of the smarts to 
> handle both failures, the one missing piece is that __vnet_tx_trigger()
> should not loop infinitely on the ldc_write, but give up with 
> EWOULDBLOCK after some finite number of tries- at that point
> vnet_start_xmit() recovers correctly (afaict).

Actually, if we look at the vio_ldc_send() code path, it does it's
own delay loop waiting for ldc_write() to stop signalling -EAGAIN.
It loops up to 1000 times, doing a udelay(1) each iteration.

So firstly the backoff based delay loop in __vnet_tx_trigger() should
probably be removed entirely.

Now, besides taking the error path in vnet_start_xmit() and dropping
the packet, we need to think about what we should do subsequently when
this condition triggers.

We probably want to take the carrier down via netif_carrier_off(), and
then when we see the head pointer advancing (I guess via
vnet_event()'s logic), the networking driver can netif_carrir_on() in
response.

> But then there's another problem at the tail of vnet_event()-
> if we hit the maybe_tx_wakeup() condition, we try to take the
> netif_tx_lock() in the recv-interrupt-context and can deadlock
> with dev_watchdog(). 
> 
> I could move the contents of maybe_tx_wakeup() into 
> vnet_tx_timeout(), and that avoids deadlocks. However I think that now 
> matches the description of polling-to-recover-from-blocked-tx above. 

Indeed, that's a bad deadlock.

You can just use a tasklet to make it execute in a software interrupt
"right now".

> Another data-point in favor of not over-optimizing the wrong thing:
> in separate experiments, when I try to move the data-handling code in
> vnet_event off to a bh-handler, performance improves noticeably- I 
> rarely encounter the netif_queue_stopped(), so relying on 
> vnet_tx_timeout() for recovery is not an issue with that prototype.
> 
> Unless there's a simple way to kick off netif_wake_queue()
> from vnet_event(), it seems better to just make vnet_tx_timeout()
> do this job.

I think just the time it takes to unwind the HW interrupt handler and
enter the software interrupt code path is enough time to let the other
side of the LDC link make a bunch of progresss.

And yes, hitting stop queue conditions less often will improve performance
if only because it means we have less overhead going in and out of stopped
queue state.

Anyways, see my tasklet suggestion above.

Also it's a real pain that one port backing up can head-of-line block
the entire interface.
