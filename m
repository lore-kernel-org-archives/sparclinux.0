From: Y Song <ys114321@gmail.com>
Date: Sun, 18 Nov 2018 20:20:41 +0000
Subject: Re: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
Message-Id: <CAH3MdRXESr62o2XnQ0L7GGZRfM_GpbFpG2xmk93LDLL2es8y3A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-3-ard.biesheuvel@linaro.org>
 <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
 <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Nov 18, 2018 at 3:55 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 17 Nov 2018 at 23:47, Y Song <ys114321@gmail.com> wrote:
> >
> > On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > All arch overrides of the __weak bpf_jit_free() amount to the same
> > > thing: the allocated memory was never mapped read-only, and so
> > > it does not have to be remapped to read-write before being freed.
> > >
> > > So in preparation of permitting arches to serve allocations for BPF
> > > JIT programs from other regions than the module region, refactor
> > > the existing bpf_jit_free() implementations to use the shared code
> > > where possible, and only specialize the remap and free operations.
> > >
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > >  arch/mips/net/bpf_jit.c           |  7 ++-----
> > >  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
> > >  arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
> > >  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
> > >  kernel/bpf/core.c                 | 15 +++++----------
> > >  5 files changed, 14 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> > > index 1b69897274a1..5696bd7dccc7 100644
> > > --- a/arch/mips/net/bpf_jit.c
> > > +++ b/arch/mips/net/bpf_jit.c
> > > @@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> > >         kfree(ctx.offsets);
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > > index a1ea1ea6b40d..5b5ce4a1b44b 100644
> > > --- a/arch/powerpc/net/bpf_jit_comp.c
> > > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > > @@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> > >         return;
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > > index 84c8f013a6c6..f64f1294bd62 100644
> > > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > > @@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> > >         return fp;
> > >  }
> > >
> > > -/* Overriding bpf_jit_free() as we don't set images read-only. */
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> > > index 01bda6bc9e7f..589950d152cc 100644
> > > --- a/arch/sparc/net/bpf_jit_comp_32.c
> > > +++ b/arch/sparc/net/bpf_jit_comp_32.c
> > > @@ -756,10 +756,7 @@ cond_branch:                       f_offset = addrs[i + filter[i].jf];
> > >         return;
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 1a796e0799ec..29f766dac203 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> > >         return hdr;
> > >  }
> > >
> > > -void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > > +void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       u32 pages = hdr->pages;
> > > -
> > > +       bpf_jit_binary_unlock_ro(hdr);
> > >         module_memfree(hdr);
> > > -       bpf_jit_uncharge_modmem(pages);
> > >  }
> > >
> > > -/* This symbol is only overridden by archs that have different
> > > - * requirements than the usual eBPF JITs, f.e. when they only
> > > - * implement cBPF JIT, do not set images read-only, etc.
> > > - */
> >
> > Do you want to move the above comments to
> > new weak function bpf_jit_binary_free?
> >
>
> Perhaps. But one thing I don't understand, looking at this again, is
> why we have these overrides in the first place. module_memfree() just
> calls vfree(), which takes down the mapping entirely (along with any
> updated permissions), and so remapping it back to r/w right before
> that seems rather pointless imo.
>
> Can we get rid of bpf_jit_binary_unlock_ro() entirely, and along with
> it, all these overrides for the free() path?

Maybe based on current implementation. Just a pure speculation.
module_memfree() can be overwritten by arch specific implementation.
The intention could be restoring the allocated page to its original permission
just in case arch specific implementation of module_memfree()
does different thing than default vfee().
