From: David Miller <davem@davemloft.net>
Date: Sat, 25 Oct 2014 18:28:22 +0000
Subject: Re: [PATCHv5 3/4] sparc64: Avoid irqsave/restore on vio.lock if in_softirq()
Message-Id: <20141025.142822.141874034124023889.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141022221245.GE17252@oracle.com>
In-Reply-To: <20141022221245.GE17252@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 22 Oct 2014 18:12:45 -0400

> 
> For NAPIfied drivers , there is no need to
> synchronize by doing irqsave/restore on vio.lock in the I/O
> path.
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

Conditional locking is broken locking, and the bug you introduce
here is a good example of why that is.

If the vio->timer has to be triggered when vio_port_up() is
invoked, it will next run fron in_softirq() context regardless
of whether the user is sunvnet or sunvdc.  So it will elide
the locking regardless of who is using this vio context.

Never, ever, use conditional locking.

This locking is harmless overhead in a slow path, just leave
it alone for now.
