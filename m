From: David Miller <davem@davemloft.net>
Date: Fri, 08 Aug 2014 18:46:01 +0000
Subject: Re: soft-lockups in sunvnet
Message-Id: <20140808.114601.1454008888717150216.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 8 Aug 2014 14:39:39 -0400

> The tasklet mechanims for kicking of netif_wake_queue works quite
> well, and is simple enough to do. 

So you are able to successfully trigger the tasklet from vnet_event(),
and have that tasklet do the queue wakeups?

> But once I removed the heuristic exponential backoff/retry for
> vnet_send_ack(), I'm freqently not able to send any DRING_STOPPED 
> messages, and that seems to freeze all access even over the switch-port
> to the VM  (even though, afaict, netif_stop_queue has not been called.
> 
> If we can't send the LDC ack from vnet_event, we need to reset
> this peer, but vio_conn_reset() is a no-op. Recovering from here
> is going to be quite sticky.

But removing the backoff logic from __vnet_tx_trigger() does work,
right?

I don't think vnet_walk_rx() is really able to handle any kind of real
failures from vnet_send_ack() properly.  If we send one or more
VIO_DRING_ACTIVE ACKs and then can't send the VIO_DRING_STOPPED one
out, the ring will likely be left in an inconsistent state.
