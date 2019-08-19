From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2019 05:58:31 +0000
Subject: Re: sparc64: hang from BUG: Bad page state, on older CPU & compiler
Message-Id: <CAHk-=wiCJf2beZwW6E37mnovd860m15Ety+ucgDNK1aPAZme_A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
In-Reply-To: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Aug 18, 2019 at 10:10 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Aug 18, 2019 at 12:39:43PM -0700, David Miller wrote:
> > From: Christoph Hellwig <hch@infradead.org>
> > Date: Sun, 18 Aug 2019 00:01:37 -0700
> >
> > > I think for now we'll simply have to disable HAVE_FAST_GUP for sparc,
> > > until someone who really knows low-level sparc page table handling
> > > finds some time to audit the generic fast gup code and arch hooks.
> >
> > It's a regression, we don't disable features in those circumstances
> > usually right?
>
> Well, it isn't exactly a feature we lost, but an optimization that makes
> operations go faster vs not allowing them.  Them other option would be
> to revert the whole stack of patches, which is the groundwork for
> fixing the get_user_pages vs truncate and co races, so I'm not very
> eager to do that for sparc64.
>
> But in the end Linus will have to decide.

It does sound like we should just disable HAVE_FAST_GUP for sparc. And
yes, it's "only" an optimization, disabling it shouldn't bvreak
anything. get_user_pages_fast() will fall back on the regular
get_user_pages() logic if there is not fast-GUP.

(In fact, even if there *is* fast-GUP, the whole design of fast-GUP is
to fail for any "hard" case, so that fallback is fundamental).

If it was something more generic I'd argue for reverting, but it does
seem to be very sparc-specific, and there just aren't enough sparc
users to argue for the optimization being critical.

I still can't see what might be wrong in the generic code. It's quite
different from the previous sparc64 code, but just about all the
differences are about how it supports a lot more cases (devmap,
5-level page tables, the crazy powepc "hugepd" thing etc), but all of
those differences should just compile away on sparc64.

There are other small differences. For example, the old sparc64
gup_huge_pud() code did this:

        if (!(pud_val(pud) & _PAGE_VALID))
                return 0;

        if (write && !pud_write(pud))
                return 0;

and the generic gup_huge_pud() code instead does

        if (!pud_access_permitted(orig, flags & FOLL_WRITE))
                return 0;

which does the same thing, but expresses it differently (because sparc
doesn't have its own specific one):

  #define pud_access_permitted(pud, write) \
          (pud_present(pud) && (!(write) || pud_write(pud)))

and "pud_present()" for sparc64 is actually defined as

  #define pud_present(pud)            (pud_val(pud) != 0U)

(notice the difference between checking _PAGE_VALID and checking all bits.

Can there be pud values that are non-zero but also not valid? Maybe.
If so, you'd get different results here.

So both versions look sane, but they aren't identical, and there might
be some sparc64 oddity that just triggers here.

The code apparently works for David for his compiler and hardware
configuration. So it's not *entirely* broken even on sparc64. But yes,
without somebody with the resources to understand why some specific
sparc64 situations don't work, I think we just need to disable
FAST_GUP on sparc64.

               Linus
