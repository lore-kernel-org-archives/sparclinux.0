From: David Miller <davem@davemloft.net>
Date: Wed, 17 Apr 2013 22:44:45 +0000
Subject: Re: [PATCH] sparc64: Don't pass a pointer to xcall_flush_tlb_pending
Message-Id: <20130417.184445.2148323167004439141.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <516F0B8A.5070407@oracle.com>
In-Reply-To: <516F0B8A.5070407@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 17 Apr 2013 17:07:26 -0500

> The remote function doesn't operate with a stack, so it can't simply
> call atomic_dec (or atomic_sub) but would need to open code it.
> Possible, but it makes the fix a bit more complicated.

It's not that difficult, I implemented a patch and will post it
after I'm done debugging it.
