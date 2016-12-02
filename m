From: David Miller <davem@davemloft.net>
Date: Fri, 02 Dec 2016 17:31:36 +0000
Subject: Re: sunvnet: Question on tx control in original code
Message-Id: <20161202.123136.2213737487146542268.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <161e538d-f353-2075-280b-50767e6ec8d8@oracle.com>
In-Reply-To: <161e538d-f353-2075-280b-50767e6ec8d8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 30 Nov 2016 17:25:30 -0800

> Near the bottom of sunvnet_common.c:sunvnet_start_xmit_common(), about
> line 1423, just after the ldc_start_done: label is a curious 'if'
> block
> 
>         if (unlikely(vnet_tx_dring_avail(dr) < 1)) {
>                 netif_tx_stop_queue(txq);
>                 if (vnet_tx_dring_avail(dr) > VNET_TX_WAKEUP_THRESH(dr))
>                         netif_tx_wake_queue(txq);
>         }
> 
> In order to get into the if-block there needs to be a 0 or negative
> return from vnet_tx_dring_avail(), yet then we're checking it again,
> with no discernible delay, for a positive value.  I don't see how we
> could get to the netif_tx_wake_queue() call - shouldn't there be some
> delay, or perhaps something that might bump the underlying channel
> before checking for more available space?

This is the canonical way to deal with a race condition that exists in
pretty much every modern networking driver that does transmit without
holding onto any real locks.

Between the initial vnet_tx_dring_avail() test and the
netif_tx_stop_queue() call, a TX event can arrive and thus make TX
ring space available again.

Thus without the re-check, we could lose a wakeup.

If you scan a bunch of drivers, you'll find this construct is common,
for example tg3_start_xmit() has:

	tnapi->tx_prod = entry;
	if (unlikely(tg3_tx_avail(tnapi) <= (MAX_SKB_FRAGS + 1))) {
		netif_tx_stop_queue(txq);

		/* netif_tx_stop_queue() must be done before checking
		 * checking tx index in tg3_tx_avail() below, because in
		 * tg3_tx(), we update tx index before checking for
		 * netif_tx_queue_stopped().
		 */
		smp_mb();
		if (tg3_tx_avail(tnapi) > TG3_TX_WAKEUP_THRESH(tnapi))
			netif_tx_wake_queue(txq);
	}

Hope this helps.
