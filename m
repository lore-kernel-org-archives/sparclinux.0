From: David Miller <davem@davemloft.net>
Date: Wed, 17 Apr 2013 21:31:27 +0000
Subject: Re: [PATCH] sparc64: Don't pass a pointer to xcall_flush_tlb_pending
Message-Id: <20130417.173127.1051335998167836570.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <516F0B8A.5070407@oracle.com>
In-Reply-To: <516F0B8A.5070407@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I also don't agree with this approach to fix the bug.

I'd much rather we properly synchronize.  One idea is to have
a pendulum which sways every time a remove batch flush is
performed.

The pendulum is a pointer, which points to one of two per-cpu batch
datastructures.  A remote flush is issued by setting an atomic counter
to the number of remote cpus doing the flush in the per-cpu batch
area, each remote cpu decrements the atomic counter.

The submitter also "sways the pendulum" by adjusting the pointer to
other per-cpu batch datastructure.

If a submitter sees that there is a reference count on the per-cpu
batch the pendulum points to, it waits until the counter hits zero.

