From: Nadav Amit <nadav.amit@gmail.com>
Date: Wed, 12 Jun 2019 01:27:09 +0000
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in a structure
Message-Id: <0441EC80-B09F-4722-B186-E42EB6A83386@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-17-hch@lst.de> <1560300464.nijubslu3h.astroid@bobo.none>
In-Reply-To: <1560300464.nijubslu3h.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Khalid Aziz <khalid.aziz@oracle.com>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>

> On Jun 11, 2019, at 5:52 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> Christoph Hellwig's on June 12, 2019 12:41 am:
>> Instead of passing a set of always repeated arguments down the
>> get_user_pages_fast iterators, create a struct gup_args to hold them and
>> pass that by reference.  This leads to an over 100 byte .text size
>> reduction for x86-64.
> 
> What does this do for performance? I've found this pattern can be
> bad for store aliasing detection.

Note that sometimes such an optimization can also have adverse effect due to
stack protector code that gcc emits when you use such structs.

Matthew Wilcox encountered such a case:
https://patchwork.kernel.org/patch/10702741/
