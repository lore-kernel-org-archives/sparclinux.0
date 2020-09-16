From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 16 Sep 2020 12:24:05 +0000
Subject: Re: [PATCH 0/3] dma-buf: Flag vmap'ed memory as system or I/O memory
Message-Id: <20200916122405.GQ438822@phenom.ffwll.local>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914112521.1327-1-tzimmermann@suse.de>
 <20200916093756.GC438822@phenom.ffwll.local>
 <0378c326-28c6-371e-45d2-8b81ccbda84f@suse.de>
In-Reply-To: <0378c326-28c6-371e-45d2-8b81ccbda84f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: christian.koenig@amd.com, airlied@linux.ie, mark.cave-ayland@ilande.co.uk, dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk, thierry.reding@gmail.com, kraxel@redhat.com, sparclinux@vger.kernel.org, sam@ravnborg.org, m.szyprowski@samsung.com, jonathanh@nvidia.com, matthew.auld@intel.com, linux+etnaviv@armlinux.org.uk, linux-media@vger.kernel.org, pawel@osciak.com, intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, thomas.hellstrom@intel.com, rodrigo.vivi@intel.com, linux-tegra@vger.kernel.org, mchehab@kernel.org, tfiga@chromium.org, kyungmin.park@samsung.com, davem@davemloft.net

On Wed, Sep 16, 2020 at 12:48:20PM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 16.09.20 um 11:37 schrieb Daniel Vetter:
> > On Mon, Sep 14, 2020 at 01:25:18PM +0200, Thomas Zimmermann wrote:
> >> Dma-buf provides vmap() and vunmap() for retrieving and releasing mapp=
ings
> >> of dma-buf memory in kernel address space. The functions operate with =
plain
> >> addresses and the assumption is that the memory can be accessed with l=
oad
> >> and store operations. This is not the case on some architectures (e.g.,
> >> sparc64) where I/O memory can only be accessed with dedicated instruct=
ions.
> >>
> >> This patchset introduces struct dma_buf_map, which contains the addres=
s of
> >> a buffer and a flag that tells whether system- or I/O-memory instructi=
ons
> >> are required.
> >>
> >> Some background: updating the DRM framebuffer console on sparc64 makes=
 the
> >> kernel panic. This is because the framebuffer memory cannot be accesse=
d with
> >> system-memory instructions. We currently employ a workaround in DRM to
> >> address this specific problem. [1]
> >>
> >> To resolve the problem, we'd like to address it at the most common poi=
nt,
> >> which is the dma-buf framework. The dma-buf mapping ideally knows if I=
/O
> >> instructions are required and exports this information to it's users. =
The
> >> new structure struct dma_buf_map stores the buffer address and a flag =
that
> >> signals I/O memory. Affected users of the buffer (e.g., drivers, frame=
works)
> >> can then access the memory accordingly.
> >>
> >> This patchset only introduces struct dma_buf_map, and updates struct d=
ma_buf
> >> and it's interfaces. Further patches can update dma-buf users. For exa=
mple,
> >> there's a prototype patchset for DRM that fixes the framebuffer proble=
m. [2]
> >>
> >> Further work: TTM, one of DRM's memory managers, already exports an
> >> is_iomem flag of its own. It could later be switched over to exporting=
 struct
> >> dma_buf_map, thus simplifying some code. Several DRM drivers expect th=
eir
> >> fbdev console to operate on I/O memory. These could possibly be switch=
ed over
> >> to the generic fbdev emulation, as soon as the generic code uses struct
> >> dma_buf_map.
> >>
> >> [1] https://lore.kernel.org/dri-devel/20200725191012.GA434957@ravnborg=
.org/
> >> [2] https://lore.kernel.org/dri-devel/20200806085239.4606-1-tzimmerman=
n@suse.de/
> >=20
> > lgtm, imo ready to convert the follow-up patches over to this. But I th=
ink
> > would be good to get at least some ack from the ttm side for the overall
> > plan.
>=20
> Yup, it would be nice if TTM could had out these types automatically.
> Then all TTM-based drivers would automatically support it.
>=20
> >=20
> > Also, I think we should put all the various helpers (writel/readl, mems=
et,
> > memcpy, whatever else) into the dma-buf-map.h helper, so that most code
> > using this can just treat it as an abstract pointer type and never look
> > underneath it.
>=20
> We have some framebuffer helpers that rely on pointer arithmetic, so
> we'd need that too. No big deal wrt code, but I was worried about the
> overhead. If a loop goes over framebuffer memory, there's an if/else
> branch for each access to the memory buffer.

If we make all the helpers static inline, then the compiler should be able
to see that dma_buf_map.is_iomem is always the same, and produced really
optimized code for it by pulling that check out from all the loops.

So should only result in somewhat verbose code of having to call
dma_buf_map pointer arthimetic helpers, but not in bad generated code.
Still worth double-checking I think, since e.g. on x86 the generated code
should be the same for both cases (but maybe the compiler doesn't see
through the inline asm to realize that, so we might end up with 2 copies).
-Daniel


>=20
> Best regards
> Thomas
>=20
> > -Daniel
> >=20
> >>
> >> Thomas Zimmermann (3):
> >>   dma-buf: Add struct dma-buf-map for storing struct dma_buf.vaddr_ptr
> >>   dma-buf: Use struct dma_buf_map in dma_buf_vmap() interfaces
> >>   dma-buf: Use struct dma_buf_map in dma_buf_vunmap() interfaces
> >>
> >>  Documentation/driver-api/dma-buf.rst          |   3 +
> >>  drivers/dma-buf/dma-buf.c                     |  40 +++---
> >>  drivers/gpu/drm/drm_gem_cma_helper.c          |  16 ++-
> >>  drivers/gpu/drm/drm_gem_shmem_helper.c        |  17 ++-
> >>  drivers/gpu/drm/drm_prime.c                   |  14 +-
> >>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c   |  13 +-
> >>  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |  13 +-
> >>  .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  18 ++-
> >>  drivers/gpu/drm/tegra/gem.c                   |  23 ++--
> >>  .../common/videobuf2/videobuf2-dma-contig.c   |  17 ++-
> >>  .../media/common/videobuf2/videobuf2-dma-sg.c |  19 ++-
> >>  .../common/videobuf2/videobuf2-vmalloc.c      |  21 ++-
> >>  include/drm/drm_prime.h                       |   5 +-
> >>  include/linux/dma-buf-map.h                   | 126 ++++++++++++++++++
> >>  include/linux/dma-buf.h                       |  11 +-
> >>  15 files changed, 274 insertions(+), 82 deletions(-)
> >>  create mode 100644 include/linux/dma-buf-map.h
> >>
> >> --
> >> 2.28.0
> >>
> >=20
>=20
> --=20
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
>=20




--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
