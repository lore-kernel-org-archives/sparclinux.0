From: Christoph Hellwig <hch@lst.de>
Date: Fri, 21 Jun 2019 08:15:01 +0000
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in a structure
Message-Id: <20190621081501.GA17718@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-17-hch@lst.de> <1560300464.nijubslu3h.astroid@bobo.none> <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com> <1561032202.0qfct43s2c.astroid@bobo.none> <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
In-Reply-To: <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>, James Hogan <jhogan@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Thu, Jun 20, 2019 at 10:21:46AM -0700, Linus Torvalds wrote:
> Hmm. Honestly, I've never seen anything like that in any kernel profiles.
> 
> Compared to the problems I _do_ see (which is usually the obvious
> cache misses, and locking), it must either be in the noise or it's
> some problem specific to whatever CPU you are doing performance work
> on?
> 
> I've occasionally seen pipeline hiccups in profiles, but it's usually
> been either some serious glass jaw of the core, or it's been something
> really stupid we did (or occasionally that the compiler did: one in
> particular I remember was how there was a time when gcc would narrow
> stores when it could, so if you set a bit in a word, it would do it
> with a byte store, and then when you read the whole word afterwards
> you'd get a major pipeline stall and it happened to show up in some
> really hot paths).

I've not seen any difference in the GUP bench output here ar all.

But I'm fine with skipping this patch for now, I have a potential
series I'm looking into that would benefit a lot from it, but we
can discusss it in that context and make sure all the other works gets in
in time.
