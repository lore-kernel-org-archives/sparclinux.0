From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 24 Jul 2020 06:23:59 +0000
Subject: Re: [PATCH] drm/drm_fb_helper: fix fbdev with sparc64
Message-Id: <20200724062359.GA612640@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200709193016.291267-1-sam@ravnborg.org>
 <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
 <20200713162159.GR3278063@phenom.ffwll.local>
 <1ed6bd2a-6f8f-ca69-3244-03402874d5a3@suse.de>
 <20200714084141.GW3278063@phenom.ffwll.local>
 <a3fdd8b9-bf2b-dcd7-63b7-91f379865a6c@suse.de>
 <CAPM=9tyoJhvudNake+w=e4S9dQ8MT_bQEF9USuj=_vHBRLzA8Q@mail.gmail.com>
In-Reply-To: <CAPM=9tyoJhvudNake+w=e4S9dQ8MT_bQEF9USuj=_vHBRLzA8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dri-devel <dri-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

 Hi Dave.
 On Fri, Jul 24, 2020 at 02:53:30PM +1000, Dave Airlie wrote:
> On Tue, 14 Jul 2020 at 18:56, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Hi
> >
> > Am 14.07.20 um 10:41 schrieb Daniel Vetter:
> > > On Tue, Jul 14, 2020 at 08:41:58AM +0200, Thomas Zimmermann wrote:
> > >> Hi
> > >>
> > >> Am 13.07.20 um 18:21 schrieb Daniel Vetter:
> > >>> On Fri, Jul 10, 2020 at 08:28:16AM +0200, Thomas Zimmermann wrote:
> > >>>> Hi
> > >>>>
> > >>>> Am 09.07.20 um 21:30 schrieb Sam Ravnborg:
> > >>>>> Mark reported that sparc64 would panic while booting using qemu.
> > >>>>> Mark bisected this to a patch that introduced generic fbdev emulation to
> > >>>>> the bochs DRM driver.
> > >>>>> Mark pointed out that a similar bug was fixed before where
> > >>>>> the sys helpers was replaced by cfb helpers.
> > >>>>>
> > >>>>> The culprint here is that the framebuffer reside in IO memory which
> > >>>>> requires SPARC ASI_PHYS (physical) loads and stores.
> > >>>>>
> > >>>>> The current bohcs DRM driver uses a shadow buffer.
> > >>>>> So all copying to the framebuffer happens in
> > >>>>> drm_fb_helper_dirty_blit_real().
> > >>>>>
> > >>>>> The fix is to replace the memcpy with memcpy_toio() from io.h.
> > >>>>>
> > >>>>> memcpy_toio() uses writeb() where the original fbdev code
> > >>>>> used sbus_memcpy_toio(). The latter uses sbus_writeb().
> > >>>>>
> > >>>>> The difference between writeb() and sbus_memcpy_toio() is
> > >>>>> that writeb() writes bytes in little-endian, where sbus_writeb() writes
> > >>>>> bytes in big-endian. As endian does not matter for byte writes they are
> > >>>>> the same. So we can safely use memcpy_toio() here.
> > >>>>>
> > >>>>> For many architectures memcpy_toio() is a simple memcpy().
> > >>>>> One sideeffect that is unknow is if this has any impact on other
> > >>>>> architectures.
> > >>>>> So far the analysis tells that this change is OK for other arch's.
> > >>>>> but testing would be good.
> > >>>>>
> > >>>>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > >>>>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > >>>>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > >>>>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > >>>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > >>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
> > >>>>> Cc: "David S. Miller" <davem@davemloft.net>
> > >>>>> Cc: sparclinux@vger.kernel.org
> > >>>>
> > >>>> So this actually is a problem in practice. Do you know how userspace
> > >>>> handles this?
> > >>>>
> > >>>> For this patch
> > >>>>
> > >>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > >>>>
> > >>>> but I'd like to have someone with more architecture expertise ack this
> > >>>> as well.
> > >>>>
> > >>>> Best regards
> > >>>> Thomas
> > >>>>
> > >>>>> ---
> > >>>>>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
> > >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > >>>>> index 5609e164805f..4d05b0ab1592 100644
> > >>>>> --- a/drivers/gpu/drm/drm_fb_helper.c
> > >>>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
> > >>>>> @@ -399,7 +399,7 @@ static void drm_fb_helper_dirty_blit_real(struct drm_fb_helper *fb_helper,
> > >>>>>   unsigned int y;
> > >>>>>
> > >>>>>   for (y = clip->y1; y < clip->y2; y++) {
> > >>>>> -         memcpy(dst, src, len);
> > >>>>> +         memcpy_toio(dst, src, len);
> > >>>
> > >>> I don't think we can do this unconditionally, there's fbdev-helper drivers
> > >>> using shmem helpers, and for shmem memcpy_toio is wrong. We need a switch
> > >>> to fix this properly I think.
> > >>
> > >> I once has a patch set for this problem, but it didn't make it. [1]
> > >>
> > >> Buffers can move between I/O and system memory, so a simple flag would
> > >> not work. I'd propose this
> > >>
> > >> bool drm_gem_is_iomem(struct drm_gem_object *obj)
> > >> {
> > >>      if (obj->funcs && obj->funcs->is_iomem)
> > >>              return obj->funcs->is_iomem(obj);
> > >>      return false;
> > >> }
> > >>
> > >> Most GEM implmentations wouldn't bother, but VRAM helpers could set the
> > >> is_iomem function and return the current state. Fbdev helpers can then
> > >> pick the correct memcpy_*() function.
> > >
> > > Hm wasn't the (long term at least) idea to add the is_iomem flag to the
> > > vmap functions? is_iomem is kinda only well-defined if there's a vmap of
> > > the buffer around (which also pins it), or in general when the buffer is
> > > pinned. Outside of that an ->is_iomem function doesn't make much sense.
> >
> > Oh. From how I understood the original discussion, you shoot down the
> > idea because sparse would not support it well?
> >
> > The other idea was to add an additional vmap_iomem() helper that returns
> > an__iomem pointer. Can we try that?
> >
> Did we get anywhere with this yet?

A few on the work I did so far.
Using qemu the original reported bug was fixed only be replacing a
memcpy with memcpy_toio.
But this looks like only a half solution as we would still use the sys_*
variants to copy data to the framebuffer, and tye do not cope with
frambuffer in dedicated IO memory.

But I have not managed to get it work wiht qemu when using the cfb_*
variants. I end up in a deadlock waiting for the console lock.
So far my debuggin have not told me why I lock up the boot waiting for
the console lock and I am stuck on that.

I could send the patch memcpy => memcpy_toio but I am afraid it may not
work on real HW as we do not cover the sys_* => cfb_*

	Sam
