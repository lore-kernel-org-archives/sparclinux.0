From: Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 21 Jun 2019 08:29:27 +0000
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in a structure
Message-Id: <1561104674.cxm7sn77rx.astroid@bobo.none>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
        <20190611144102.8848-17-hch@lst.de>
        <1560300464.nijubslu3h.astroid@bobo.none>
        <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
        <1561032202.0qfct43s2c.astroid@bobo.none>
        <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
In-Reply-To: <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>, James Hogan <jhogan@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

Linus Torvalds's on June 21, 2019 3:21 am:
> On Thu, Jun 20, 2019 at 5:19 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> The processor aliasing problem happens because the struct will
>> be initialised with stores using one base register (e.g., stack
>> register), and then same memory is loaded using a different
>> register (e.g., parameter register).
> 
> Hmm. Honestly, I've never seen anything like that in any kernel profiles.
> 
> Compared to the problems I _do_ see (which is usually the obvious
> cache misses, and locking), it must either be in the noise or it's
> some problem specific to whatever CPU you are doing performance work
> on?

No you're right, the performance hit from these flushes is not a
big hit that stands out in cycle counts. I just look at kernel code
for various flushes. Branches not surprisingly are usually the main
culprit, but they're normally not so interesting.

Static alias prediction seems to work well outside this case. It's
interesting, you need both a store ; load sequence that does not
predict well (e.g., using a different base register), and you also
need that load to be executed ahead of the store.

The small stack structure for arguments is the perfect case. Bad
pattern, and load executed right after store. Even then you also need
a reason to delay the store (e.g., source not ready or store queue
full), but those hazards do show up.

Now, even when all that goes wrong, there are dynamic heuristics that
can take over. So if you run a repetitive microbenchmark you won't
see it.

Some CPUs seem to be quite aggressive about giving up and turning off
the alias prediction globally if you take misses (Intel x86 used to do
that IIRC, not sure if they still do). So in that case you wouldn't
even see it show up in one place, everything will just run slightly
slower.

What I worry about is high rate direct IO workloads that see single
flushes in these paths as significant. Or if this thing creeps in to
the kernel too much and just slightly raises global misses enough,
then it will cause disambiguation to be significantly shut down.

Thanks,
Nick
