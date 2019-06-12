From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2019 01:09:24 +0000
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in a structure
Message-Id: <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-17-hch@lst.de>
 <1560300464.nijubslu3h.astroid@bobo.none>
In-Reply-To: <1560300464.nijubslu3h.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Khalid Aziz <khalid.aziz@oracle.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>

On Tue, Jun 11, 2019 at 2:55 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> What does this do for performance? I've found this pattern can be
> bad for store aliasing detection.

I wouldn't expect it to be noticeable, and the lack of argument
reloading etc should make up for it. Plus inlining makes it a
non-issue when that happens.

But I guess we could also at least look at using "restrict", if that
ends up helping. Unlike the completely bogus type-based aliasing rules
(that we disable because I think the C people were on some bad bad
drugs when they came up with them), restricted pointers are a real
thing that makes sense.

That said, we haven't traditionally used it, and I don't know how much
it helps gcc. Maybe gcc ignores it entirely? S

               Linus
