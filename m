From: Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 12 Jun 2019 00:52:53 +0000
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in a structure
Message-Id: <1560300464.nijubslu3h.astroid@bobo.none>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
        <20190611144102.8848-17-hch@lst.de>
In-Reply-To: <20190611144102.8848-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Khalid Aziz <khalid.aziz@oracle.com>, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, x86@kernel.org

Christoph Hellwig's on June 12, 2019 12:41 am:
> Instead of passing a set of always repeated arguments down the
> get_user_pages_fast iterators, create a struct gup_args to hold them and
> pass that by reference.  This leads to an over 100 byte .text size
> reduction for x86-64.

What does this do for performance? I've found this pattern can be
bad for store aliasing detection.

Thanks,
Nick
