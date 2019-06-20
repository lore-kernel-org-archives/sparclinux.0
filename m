From: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 20 Jun 2019 12:18:51 +0000
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in a structure
Message-Id: <1561032202.0qfct43s2c.astroid@bobo.none>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
        <20190611144102.8848-17-hch@lst.de>
        <1560300464.nijubslu3h.astroid@bobo.none>
        <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
In-Reply-To: <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>, James Hogan <jhogan@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

Linus Torvalds's on June 12, 2019 11:09 am:
> On Tue, Jun 11, 2019 at 2:55 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> What does this do for performance? I've found this pattern can be
>> bad for store aliasing detection.
> 
> I wouldn't expect it to be noticeable, and the lack of argument
> reloading etc should make up for it. Plus inlining makes it a
> non-issue when that happens.

Maybe in isolation. Just seems like a strange pattern to sprinkle
around randomly, I wouldn't like it to proliferate.

I understand in some cases where a big set of parameters or
basically state gets sent around through a lot of interfaces.
Within one file to make lines a bit shorter or save a few bytes
isn't such a strong case.

> 
> But I guess we could also at least look at using "restrict", if that
> ends up helping. Unlike the completely bogus type-based aliasing rules
> (that we disable because I think the C people were on some bad bad
> drugs when they came up with them), restricted pointers are a real
> thing that makes sense.
> 
> That said, we haven't traditionally used it, and I don't know how much
> it helps gcc. Maybe gcc ignores it entirely? S

Ahh, it's not compiler store alias analysis I'm talking about, but
processor (but you raise an interesting point about compiler too,
would be nice if we could improve that in general).

The processor aliasing problem happens because the struct will
be initialised with stores using one base register (e.g., stack
register), and then same memory is loaded using a different
register (e.g., parameter register). Processor's static heuristics
for determining a load doesn't alias with an earlier store doesn't
do so well in that case.

Just about everywhere I've seen those kind of misspeculation and
flushes in the kernel has been this pattern, so I'm wary of it in
performance critical code.

Thanks,
Nick
