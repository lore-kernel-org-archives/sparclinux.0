From: David Miller <davem@davemloft.net>
Date: Mon, 11 Aug 2014 20:58:01 +0000
Subject: Re: soft-lockups in sunvnet
Message-Id: <20140811.135801.1708592923260278265.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140808.114601.1454008888717150216.davem@davemloft.net>
In-Reply-To: <20140808.114601.1454008888717150216.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 10 Aug 2014 15:56:22 -0400

> 1. finer granularity of flow-control in vnet_start_xmit(): instead
>    of doing a netif_stop_queue() when any single peer is congested,
>    try to track flow-control for that peer only, and let the others
>    continue Tx/Rx

The big blocker is that you can't send to other peers if you receive
a packet destined for the stopped peer.

It's just not legal to reorder packets in this manner.
