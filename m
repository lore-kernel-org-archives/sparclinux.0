From: David Miller <davem@davemloft.net>
Date: Sun, 02 Nov 2008 04:42:03 +0000
Subject: Re: 2.6.28-rc2: Unable to handle kernel paging request at
Message-Id: <20081101.214203.39646471.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670811010723u3b271fcaxa7d3bdb251a8b246@mail.gmail.com>
	<Pine.LNX.4.64.0811011837110.20211@blonde.site>
In-Reply-To: <Pine.LNX.4.64.0811011837110.20211@blonde.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hugh@veritas.com
Cc: a.beregalov@gmail.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

From: Hugh Dickins <hugh@veritas.com>
Date: Sat, 1 Nov 2008 18:59:24 +0000 (GMT)

> Alexander Beregalov reports oops in __bzero() called from
> copy_from_user_fixup() called from iov_iter_copy_from_user_atomic(),
> when running dbench on tmpfs on sparc64: its __copy_from_user_inatomic
> and __copy_to_user_inatomic should be avoiding, not calling, the fixups.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

This looks great, applied, thanks Hugh.
