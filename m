From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 04 May 2020 11:18:51 +0000
Subject: Re: [PATCH V2 11/11] drm: Remove drm specific kmap_atomic code
Message-Id: <CAKMK7uF4fd3upBYSQEzs==Nx7osn=wZPnxoKLKm9HTxwU_sZ+w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200504010912.982044-1-ira.weiny@intel.com>
 <20200504010912.982044-12-ira.weiny@intel.com>
In-Reply-To: <20200504010912.982044-12-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ira Weiny <ira.weiny@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, arcml <linux-snps-arc@lists.infradead.org>, linux-xtensa@linux-xtensa.org, Dan Williams <dan.j.williams@intel.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christian Koenig <christian.koenig@amd.com>

On Mon, May 4, 2020 at 3:09 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> kmap_atomic_prot() is now exported by all architectures.  Use this
> function rather than open coding a driver specific kmap_atomic.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

I'm assuming this lands through some other tree or a topic branch or whatev=
er.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c    | 56 ++--------------------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 16 ++++----
>  include/drm/ttm/ttm_bo_api.h         |  4 --
>  3 files changed, 12 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_=
bo_util.c
> index 52d2b71f1588..f09b096ba4fd 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -257,54 +257,6 @@ static int ttm_copy_io_page(void *dst, void *src, un=
signed long page)
>         return 0;
>  }
>
> -#ifdef CONFIG_X86
> -#define __ttm_kmap_atomic_prot(__page, __prot) kmap_atomic_prot(__page, =
__prot)
> -#define __ttm_kunmap_atomic(__addr) kunmap_atomic(__addr)
> -#else
> -#define __ttm_kmap_atomic_prot(__page, __prot) vmap(&__page, 1, 0,  __pr=
ot)
> -#define __ttm_kunmap_atomic(__addr) vunmap(__addr)
> -#endif
> -
> -
> -/**
> - * ttm_kmap_atomic_prot - Efficient kernel map of a single page with
> - * specified page protection.
> - *
> - * @page: The page to map.
> - * @prot: The page protection.
> - *
> - * This function maps a TTM page using the kmap_atomic api if available,
> - * otherwise falls back to vmap. The user must make sure that the
> - * specified page does not have an aliased mapping with a different cach=
ing
> - * policy unless the architecture explicitly allows it. Also mapping and
> - * unmapping using this api must be correctly nested. Unmapping should
> - * occur in the reverse order of mapping.
> - */
> -void *ttm_kmap_atomic_prot(struct page *page, pgprot_t prot)
> -{
> -       if (pgprot_val(prot) =3D=3D pgprot_val(PAGE_KERNEL))
> -               return kmap_atomic(page);
> -       else
> -               return __ttm_kmap_atomic_prot(page, prot);
> -}
> -EXPORT_SYMBOL(ttm_kmap_atomic_prot);
> -
> -/**
> - * ttm_kunmap_atomic_prot - Unmap a page that was mapped using
> - * ttm_kmap_atomic_prot.
> - *
> - * @addr: The virtual address from the map.
> - * @prot: The page protection.
> - */
> -void ttm_kunmap_atomic_prot(void *addr, pgprot_t prot)
> -{
> -       if (pgprot_val(prot) =3D=3D pgprot_val(PAGE_KERNEL))
> -               kunmap_atomic(addr);
> -       else
> -               __ttm_kunmap_atomic(addr);
> -}
> -EXPORT_SYMBOL(ttm_kunmap_atomic_prot);
> -
>  static int ttm_copy_io_ttm_page(struct ttm_tt *ttm, void *src,
>                                 unsigned long page,
>                                 pgprot_t prot)
> @@ -316,13 +268,13 @@ static int ttm_copy_io_ttm_page(struct ttm_tt *ttm,=
 void *src,
>                 return -ENOMEM;
>
>         src =3D (void *)((unsigned long)src + (page << PAGE_SHIFT));
> -       dst =3D ttm_kmap_atomic_prot(d, prot);
> +       dst =3D kmap_atomic_prot(d, prot);
>         if (!dst)
>                 return -ENOMEM;
>
>         memcpy_fromio(dst, src, PAGE_SIZE);
>
> -       ttm_kunmap_atomic_prot(dst, prot);
> +       kunmap_atomic(dst);
>
>         return 0;
>  }
> @@ -338,13 +290,13 @@ static int ttm_copy_ttm_io_page(struct ttm_tt *ttm,=
 void *dst,
>                 return -ENOMEM;
>
>         dst =3D (void *)((unsigned long)dst + (page << PAGE_SHIFT));
> -       src =3D ttm_kmap_atomic_prot(s, prot);
> +       src =3D kmap_atomic_prot(s, prot);
>         if (!src)
>                 return -ENOMEM;
>
>         memcpy_toio(dst, src, PAGE_SIZE);
>
> -       ttm_kunmap_atomic_prot(src, prot);
> +       kunmap_atomic(src);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_blit.c
> index bb46ca0c458f..94d456a1d1a9 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> @@ -374,12 +374,12 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_=
line_data *d,
>                 copy_size =3D min_t(u32, copy_size, PAGE_SIZE - src_page_=
offset);
>
>                 if (unmap_src) {
> -                       ttm_kunmap_atomic_prot(d->src_addr, d->src_prot);
> +                       kunmap_atomic(d->src_addr);
>                         d->src_addr =3D NULL;
>                 }
>
>                 if (unmap_dst) {
> -                       ttm_kunmap_atomic_prot(d->dst_addr, d->dst_prot);
> +                       kunmap_atomic(d->dst_addr);
>                         d->dst_addr =3D NULL;
>                 }
>
> @@ -388,8 +388,8 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_li=
ne_data *d,
>                                 return -EINVAL;
>
>                         d->dst_addr =3D
> -                               ttm_kmap_atomic_prot(d->dst_pages[dst_pag=
e],
> -                                                    d->dst_prot);
> +                               kmap_atomic_prot(d->dst_pages[dst_page],
> +                                                d->dst_prot);
>                         if (!d->dst_addr)
>                                 return -ENOMEM;
>
> @@ -401,8 +401,8 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_li=
ne_data *d,
>                                 return -EINVAL;
>
>                         d->src_addr =3D
> -                               ttm_kmap_atomic_prot(d->src_pages[src_pag=
e],
> -                                                    d->src_prot);
> +                               kmap_atomic_prot(d->src_pages[src_page],
> +                                                d->src_prot);
>                         if (!d->src_addr)
>                                 return -ENOMEM;
>
> @@ -499,9 +499,9 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
>         }
>  out:
>         if (d.src_addr)
> -               ttm_kunmap_atomic_prot(d.src_addr, d.src_prot);
> +               kunmap_atomic(d.src_addr);
>         if (d.dst_addr)
> -               ttm_kunmap_atomic_prot(d.dst_addr, d.dst_prot);
> +               kunmap_atomic(d.dst_addr);
>
>         return ret;
>  }
> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
> index 0a9d042e075a..de1ccdcd5703 100644
> --- a/include/drm/ttm/ttm_bo_api.h
> +++ b/include/drm/ttm/ttm_bo_api.h
> @@ -668,10 +668,6 @@ int ttm_bo_mmap_obj(struct vm_area_struct *vma, stru=
ct ttm_buffer_object *bo);
>  int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
>                 struct ttm_bo_device *bdev);
>
> -void *ttm_kmap_atomic_prot(struct page *page, pgprot_t prot);
> -
> -void ttm_kunmap_atomic_prot(void *addr, pgprot_t prot);
> -
>  /**
>   * ttm_bo_io
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
