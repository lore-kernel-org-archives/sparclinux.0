From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 08 Aug 2014 18:39:39 +0000
Subject: soft-lockups in sunvnet (was Re: [PATCH sparc] ldc_connect() should not return EINVAL when handshake
Message-Id: <20140808183939.GB31357@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (08/08/14 10:33), David Miller wrote:
> 
> The problem with not taking the carrier off is that the qdisc layer is
> going to spam messages into the log each time the TX watchdog timer
> goes off.

spamming messages into logs is the lesser of my problems at this point :-)

The tasklet mechanims for kicking of netif_wake_queue works quite
well, and is simple enough to do. 

But once I removed the heuristic exponential backoff/retry for
vnet_send_ack(), I'm freqently not able to send any DRING_STOPPED 
messages, and that seems to freeze all access even over the switch-port
to the VM  (even though, afaict, netif_stop_queue has not been called.

If we can't send the LDC ack from vnet_event, we need to reset
this peer, but vio_conn_reset() is a no-op. Recovering from here
is going to be quite sticky.



