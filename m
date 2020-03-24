From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 24 Mar 2020 18:04:23 +0000
Subject: Re: [PATCH 1/4] sparc32: mm: Fix argument checking in __srmmu_get_nocache()
Message-Id: <CAKwvOdm9q0wPun0zLcFB0Z5NPec08OpHWp3tJV3-ddFiuU2jQA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200324104005.11279-1-will@kernel.org> <20200324104005.11279-2-will@kernel.org>
 <CAKwvOd=_v__=b6ijFYkxgDsmxakmkxwDWFG48601Gh9cyhj3PA@mail.gmail.com> <20200324175113.GA16742@willie-the-truck>
In-Reply-To: <20200324175113.GA16742@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@android.com>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Matt Fleming <matt@codeblueprint.co.uk>, sparclinux@vger.kernel.org

On Tue, Mar 24, 2020 at 10:51 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Mar 24, 2020 at 10:41:52AM -0700, Nick Desaulniers wrote:
> > On Tue, Mar 24, 2020 at 3:52 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > The 'size' argument to __srmmu_get_nocache() is a number of bytes not
> > > a shift value, so fix up the sanity checking to treat it properly.
> > >
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  arch/sparc/mm/srmmu.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> > > index f56c3c9a9793..a19863cac0c4 100644
> > > --- a/arch/sparc/mm/srmmu.c
> > > +++ b/arch/sparc/mm/srmmu.c
> > > @@ -175,18 +175,18 @@ pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
> > >   */
> > >  static void *__srmmu_get_nocache(int size, int align)
> > >  {
> > > -       int offset;
> > > +       int offset, minsz = 1 << SRMMU_NOCACHE_BITMAP_SHIFT;
> > >         unsigned long addr;
> > >
> > > -       if (size < SRMMU_NOCACHE_BITMAP_SHIFT) {
> > > +       if (size < minsz) {
> > >                 printk(KERN_ERR "Size 0x%x too small for nocache request\n",
> > >                        size);
> > > -               size = SRMMU_NOCACHE_BITMAP_SHIFT;
> > > +               size = minsz;
> > >         }
> > > -       if (size & (SRMMU_NOCACHE_BITMAP_SHIFT - 1)) {
> > > -               printk(KERN_ERR "Size 0x%x unaligned int nocache request\n",
> > > +       if (size & (minsz - 1)) {
> > > +               printk(KERN_ERR "Size 0x%x unaligned in nocache request\n",
> >
> > Was modifying the printk intentional? int vs in ?
>
> Yes, I think "int" is a typo so I just fixed it up while I was here. Do you
> prefer the old way? I couldn't parse it at first, but now you mention it
> I suppose the type of 'size' is int, so *maybe* it makes sense after all!

No preference; the code is validating/updating the `size` which as you
noted is an `int`.

-- 
Thanks,
~Nick Desaulniers
