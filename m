From: David Miller <davem@davemloft.net>
Date: Thu, 07 Aug 2014 06:00:08 +0000
Subject: Re: [PATCH sparc] ldc_connect() should not return EINVAL when handshake is in progress.
Message-Id: <20140806.230008.962010173633271971.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140801135040.GE19031@oracle.com>
In-Reply-To: <20140801135040.GE19031@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 5 Aug 2014 09:52:38 -0400

> FWIW, what I'm trying to sort out at the moment is the potential for 
> triggering a soft lockup on a peer (i.e, a DoS vector). 
> If a node sends a burst of data and then never drains its incoming 
> ldc channel, the targetted peer will eventually encounter a 
> tx_has_no_space_for()/EWOULDBLOCK from __vnet_tx_trigger/vnet_send_ack 
> (and also __vdc_tx_trigger?)  - all of these are infinite loops, 
> and vnet_send_ack is particularly vicious because it's actually a 
> paradoxical blocking Tx in the Rx path (due to the vnet protocol design, 
> I suppose).  
> 
> Carefully asserting netif_stop_queue() for __vnet_tx_trigger() might 
> possibly help that case (though it flow-controls all ldc_channels, 
> instead of just the blocked one), but recovering gracefully
> for the other cases needs thought.

Other virtualization drivers tend to have this issue.  In fact this
was just being discussed over the past week on the netdev list
wrt. the xen-netback driver.

The scheme used there basically is to mark the carrier off when
the peer stops sinking packets we are TX'ing to it, and queue
up a timer.

If the timer fires, we free up all of the packets in the transmit
queue so they don't linger forever and take up resources.

Usually there is some "event" that can let us know that data is
being sinked again, and we can use that to turn the carrier on
and start transmitting again.  Otherwise we'll have to poll
for such things in the timer.
