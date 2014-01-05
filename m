From: David Miller <davem@davemloft.net>
Date: Sun, 05 Jan 2014 02:06:36 +0000
Subject: Re: [PATCH] Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."
Message-Id: <20140104.210636.1231115663627654480.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <52AF6A0C.4000400@oracle.com>
In-Reply-To: <52AF6A0C.4000400@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 16 Dec 2013 15:01:00 -0600

> This reverts commit 145e1c0023585e0e8f6df22316308ec61c5066b2.
> 
> This commit broke the behavior of __copy_from_user_inatomic when
> it is only partially successful. Instead of returning the number
> of bytes not copied, it now returns 1. This translates to the
> wrong value being returned by iov_iter_copy_from_user_atomic.
> 
> xfstests generic/246 and LTP writev01 both fail on btrfs and nfs
> because of this.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Applied and queued up for -stable, thanks.

But I wonder about the original bug that Hugh was trying to
fix :-/
