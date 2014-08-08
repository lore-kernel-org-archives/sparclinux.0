From: David Miller <davem@davemloft.net>
Date: Fri, 08 Aug 2014 19:59:30 +0000
Subject: Re: soft-lockups in sunvnet
Message-Id: <20140808.125930.1861486906681850217.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140808.114601.1454008888717150216.davem@davemloft.net>
In-Reply-To: <20140808.114601.1454008888717150216.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 8 Aug 2014 14:55:22 -0400

> On (08/08/14 11:46), David Miller wrote:
>> I don't think vnet_walk_rx() is really able to handle any kind of real
>> failures from vnet_send_ack() properly.  If we send one or more
>> VIO_DRING_ACTIVE ACKs and then can't send the VIO_DRING_STOPPED one
>> out, the ring will likely be left in an inconsistent state.
> 
> I just found out last week that you dont actually need to set the
> VIO_ACK_ENABLE (and thus trigger the ACTIVE acks)- evidently the protocol
> is such that the STOPPED ldc message is sufficient. 
> 
> So one patch that I'm working on lining up (after due testing etc)
> is to not set VIO_ACK_ENABLE in vnet_start_xmit- it also helps perf
> slightly because it reduces the trips through ldc (and potentail
> for filling up the ldc ring).

This only works because we free the packet in the ->ndo_start_xmit()
method.  If we didn't do that, and we freed it up at ACK time, we'd
need to force the ACKs in order to guarentee that we release the SKB
in a finite amount of time.

