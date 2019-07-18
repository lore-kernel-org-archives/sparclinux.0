From: David Miller <davem@davemloft.net>
Date: Thu, 18 Jul 2019 21:14:05 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <20190718.141405.1070121094691581998.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de>
	<20190625143715.1689-10-hch@lst.de>
	<20190717215956.GA30369@altlinux.org>
In-Reply-To: <20190717215956.GA30369@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ldv@altlinux.org
Cc: hch@lst.de, khalid.aziz@oracle.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, matorola@gmail.com, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Thu, 18 Jul 2019 00:59:56 +0300

> So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> (thanks to Anatoly for bisecting) and introduced a regression: 
> futex.test from the strace test suite now causes an Oops on sparc64
> in futex syscall.
> 
> Here is a heavily stripped down reproducer:

Does not reproduce for me on a T4-2 machine.

So this problem might depend on the type of system you are on,
I suspect it's one of those "pre-Niagara vs. Niagara and later"
situations because that's the dividing line between two set of
wildly different TLB and cache management methods.

What kind of machine are you on?
