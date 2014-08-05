From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 05 Aug 2014 13:52:38 +0000
Subject: Re: [PATCH sparc] ldc_connect() should not return EINVAL when handshake is in progress.
Message-Id: <20140805135238.GA8629@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140801135040.GE19031@oracle.com>
In-Reply-To: <20140801135040.GE19031@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (08/04/14 20:22), David Miller wrote:
> 
> In this case I added "sparc64: " for the subsystem prefix when
> commiting your change.

Thanks, I'll keep that in mind for the future- I wasnt sure of
the taxonomy for ldc.

> BTW, you'll probably come to notice that not a lot of work has gone
> into handling hard disconnect failures properly in LDC and the drivers
> that use it.  It's the one area where the LDC framework is very weak.
> Unfortunately a lot of cooperation is required by the drivers
> themselves, because what to do when a LDC connection goes down is
> different in different drivers (networking drivers can drop packets,
> but block drivers have to redo the I/O when the LDC link comes back
> up, for example)

Noted - I've not run into this personally, but we'll add it to the
list.

FWIW, what I'm trying to sort out at the moment is the potential for 
triggering a soft lockup on a peer (i.e, a DoS vector). 
If a node sends a burst of data and then never drains its incoming 
ldc channel, the targetted peer will eventually encounter a 
tx_has_no_space_for()/EWOULDBLOCK from __vnet_tx_trigger/vnet_send_ack 
(and also __vdc_tx_trigger?)  - all of these are infinite loops, 
and vnet_send_ack is particularly vicious because it's actually a 
paradoxical blocking Tx in the Rx path (due to the vnet protocol design, 
I suppose).  

Carefully asserting netif_stop_queue() for __vnet_tx_trigger() might 
possibly help that case (though it flow-controls all ldc_channels, 
instead of just the blocked one), but recovering gracefully
for the other cases needs thought.

--Sowmini
