From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 07 Aug 2014 20:17:08 +0000
Subject: Re: [PATCH sparc] ldc_connect() should not return EINVAL when handshake is in progress.
Message-Id: <20140807201708.GD29191@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140801135040.GE19031@oracle.com>
In-Reply-To: <20140801135040.GE19031@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


(Maybe this discussion belongs in netdev?)

On (08/06/14 23:00), David Miller wrote:
> The scheme used there basically is to mark the carrier off when
> the peer stops sinking packets we are TX'ing to it, and queue
> up a timer.
> 
> If the timer fires, we free up all of the packets in the transmit
> queue so they don't linger forever and take up resources.
> 
> Usually there is some "event" that can let us know that data is
> being sinked again, and we can use that to turn the carrier on
> and start transmitting again.  Otherwise we'll have to poll
> for such things in the timer.

so in the case of sunvnet, there are 2 writes that can block-
either !vnet_tx_dring_avail() (i.e., no descriptor rings) , or 
!tx_has_space_for() (i.e., cannot send the ldc trigger)

vnet_start_xmit() already seems to have most of the smarts to 
handle both failures, the one missing piece is that __vnet_tx_trigger()
should not loop infinitely on the ldc_write, but give up with 
EWOULDBLOCK after some finite number of tries- at that point
vnet_start_xmit() recovers correctly (afaict).

But then there's another problem at the tail of vnet_event()-
if we hit the maybe_tx_wakeup() condition, we try to take the
netif_tx_lock() in the recv-interrupt-context and can deadlock
with dev_watchdog(). 

I could move the contents of maybe_tx_wakeup() into 
vnet_tx_timeout(), and that avoids deadlocks. However I think that now 
matches the description of polling-to-recover-from-blocked-tx above. 
And one side-effect of moving from the synchronous maybe_tx_wakeup()
to the reliance on watchdog-timer to unblock things is that 
things like iperf throughput can fluctuate wildly. But given that
this actually *is* a performance weakness, perhaps its not worth
over-optimizing this case?

Another data-point in favor of not over-optimizing the wrong thing:
in separate experiments, when I try to move the data-handling code in
vnet_event off to a bh-handler, performance improves noticeably- I 
rarely encounter the netif_queue_stopped(), so relying on 
vnet_tx_timeout() for recovery is not an issue with that prototype.

Unless there's a simple way to kick off netif_wake_queue()
from vnet_event(), it seems better to just make vnet_tx_timeout()
do this job.

--Sowmini
