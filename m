From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 08 Aug 2014 18:55:22 +0000
Subject: Re: soft-lockups in sunvnet
Message-Id: <20140808185522.GC31357@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140808.114601.1454008888717150216.davem@davemloft.net>
In-Reply-To: <20140808.114601.1454008888717150216.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (08/08/14 11:46), David Miller wrote:
> Date: Fri, 08 Aug 2014 11:46:01 -0700 (PDT)
> From: David Miller <davem@davemloft.net>
> To: sowmini.varadhan@oracle.com
> Cc: david.stevens@oracle.com, karl.volz@oracle.com,
>  sparclinux@vger.kernel.org
> Subject: Re: soft-lockups in sunvnet
> X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
> 
> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date: Fri, 8 Aug 2014 14:39:39 -0400
> 
> 
> So you are able to successfully trigger the tasklet from vnet_event(),
> and have that tasklet do the queue wakeups?

yes.

> But removing the backoff logic from __vnet_tx_trigger() does work,
> right?

It "works" to the extent that it recovers. You get a lot more 
errors, much more easily, though -  thus throughput sinks. 
I dont know how the heuristics were determined, but they seem to help...
 
> I don't think vnet_walk_rx() is really able to handle any kind of real
> failures from vnet_send_ack() properly.  If we send one or more
> VIO_DRING_ACTIVE ACKs and then can't send the VIO_DRING_STOPPED one
> out, the ring will likely be left in an inconsistent state.

I just found out last week that you dont actually need to set the
VIO_ACK_ENABLE (and thus trigger the ACTIVE acks)- evidently the protocol
is such that the STOPPED ldc message is sufficient. 

So one patch that I'm working on lining up (after due testing etc)
is to not set VIO_ACK_ENABLE in vnet_start_xmit- it also helps perf
slightly because it reduces the trips through ldc (and potentail
for filling up the ldc ring).

--Sowmini

