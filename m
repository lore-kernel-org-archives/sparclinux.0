From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 10 Aug 2014 19:56:22 +0000
Subject: Re: soft-lockups in sunvnet
Message-Id: <20140810195622.GA11770@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140808.114601.1454008888717150216.davem@davemloft.net>
In-Reply-To: <20140808.114601.1454008888717150216.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


To wrap up this thread..

I just sent out a tentative patch with the first round of fixes
to netdev. These fixes take care of the bare minimum of making
sure we don't soft-lockup when the sink does not receive packets.

I can still see at least 2 areas of improvement, that I'd like
to address separately, since the changes are non-trivial and
have to be done carefully

1. finer granularity of flow-control in vnet_start_xmit(): instead
   of doing a netif_stop_queue() when any single peer is congested,
   try to track flow-control for that peer only, and let the others
   continue Tx/Rx

2. better recovery from vnet_send_ack() failure: I have a somewhat
   odd printk there today, just to let the admin know that help
   is needed. I've tried calling ldc_disconnect() here, but it
   doesn't really reset the peer, though a module-reload fixes it.
   So what's needed is to trigger just the unregister/register of
   the problematic port, and this will need more than a few lines
   of change (I think it has to be triggered by ds?)

I'll take a look at those two over the next few weeks, but didnt
want to hold up these changes hostage while that's happening.

--Sowmini

