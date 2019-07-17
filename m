From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2019 22:04:56 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org>
In-Reply-To: <20190717215956.GA30369@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Christoph Hellwig <hch@lst.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Anatoly Pugachev <matorola@gmail.com>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On Wed, Jul 17, 2019 at 2:59 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> (thanks to Anatoly for bisecting) and introduced a regression:
> futex.test from the strace test suite now causes an Oops on sparc64
> in futex syscall.

Can you post the oops here in the same thread too? Maybe it's already
posted somewhere else, but I can't seem to find anything likely on
lkml at least..

On x86-64, it obviously just causes the (expected) EFAULT error from
the futex call.

Somebody with access to sparc64 probably needs to debug this, but
having the exact oops wouldn't hurt...

             Linus
