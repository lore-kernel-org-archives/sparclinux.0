From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 14 Jul 2020 08:41:41 +0000
Subject: Re: [PATCH] drm/drm_fb_helper: fix fbdev with sparc64
Message-Id: <20200714084141.GW3278063@phenom.ffwll.local>
List-Id: <sparclinux.vger.kernel.org>
References: <20200709193016.291267-1-sam@ravnborg.org>
 <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
 <20200713162159.GR3278063@phenom.ffwll.local>
 <1ed6bd2a-6f8f-ca69-3244-03402874d5a3@suse.de>
In-Reply-To: <1ed6bd2a-6f8f-ca69-3244-03402874d5a3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>

On Tue, Jul 14, 2020 at 08:41:58AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 13.07.20 um 18:21 schrieb Daniel Vetter:
> > On Fri, Jul 10, 2020 at 08:28:16AM +0200, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 09.07.20 um 21:30 schrieb Sam Ravnborg:
> >>> Mark reported that sparc64 would panic while booting using qemu.
> >>> Mark bisected this to a patch that introduced generic fbdev emulation=
 to
> >>> the bochs DRM driver.
> >>> Mark pointed out that a similar bug was fixed before where
> >>> the sys helpers was replaced by cfb helpers.
> >>>
> >>> The culprint here is that the framebuffer reside in IO memory which
> >>> requires SPARC ASI_PHYS (physical) loads and stores.
> >>>
> >>> The current bohcs DRM driver uses a shadow buffer.
> >>> So all copying to the framebuffer happens in
> >>> drm_fb_helper_dirty_blit_real().
> >>>
> >>> The fix is to replace the memcpy with memcpy_toio() from io.h.
> >>>
> >>> memcpy_toio() uses writeb() where the original fbdev code
> >>> used sbus_memcpy_toio(). The latter uses sbus_writeb().
> >>>
> >>> The difference between writeb() and sbus_memcpy_toio() is
> >>> that writeb() writes bytes in little-endian, where sbus_writeb() writ=
es
> >>> bytes in big-endian. As endian does not matter for byte writes they a=
re
> >>> the same. So we can safely use memcpy_toio() here.
> >>>
> >>> For many architectures memcpy_toio() is a simple memcpy().
> >>> One sideeffect that is unknow is if this has any impact on other
> >>> architectures.
> >>> So far the analysis tells that this change is OK for other arch's.
> >>> but testing would be good.
> >>>
> >>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >>> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >>> Cc: "David S. Miller" <davem@davemloft.net>
> >>> Cc: sparclinux@vger.kernel.org
> >>
> >> So this actually is a problem in practice. Do you know how userspace
> >> handles this?
> >>
> >> For this patch
> >>
> >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>
> >> but I'd like to have someone with more architecture expertise ack this
> >> as well.
> >>
> >> Best regards
> >> Thomas
> >>
> >>> ---
> >>>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb=
_helper.c
> >>> index 5609e164805f..4d05b0ab1592 100644
> >>> --- a/drivers/gpu/drm/drm_fb_helper.c
> >>> +++ b/drivers/gpu/drm/drm_fb_helper.c
> >>> @@ -399,7 +399,7 @@ static void drm_fb_helper_dirty_blit_real(struct =
drm_fb_helper *fb_helper,
> >>>  	unsigned int y;
> >>> =20
> >>>  	for (y =3D clip->y1; y < clip->y2; y++) {
> >>> -		memcpy(dst, src, len);
> >>> +		memcpy_toio(dst, src, len);
> >=20
> > I don't think we can do this unconditionally, there's fbdev-helper driv=
ers
> > using shmem helpers, and for shmem memcpy_toio is wrong. We need a swit=
ch
> > to fix this properly I think.
>=20
> I once has a patch set for this problem, but it didn't make it. [1]
>=20
> Buffers can move between I/O and system memory, so a simple flag would
> not work. I'd propose this
>=20
> bool drm_gem_is_iomem(struct drm_gem_object *obj)
> {
> 	if (obj->funcs && obj->funcs->is_iomem)
> 		return obj->funcs->is_iomem(obj);
> 	return false;
> }
>=20
> Most GEM implmentations wouldn't bother, but VRAM helpers could set the
> is_iomem function and return the current state. Fbdev helpers can then
> pick the correct memcpy_*() function.

Hm wasn't the (long term at least) idea to add the is_iomem flag to the
vmap functions? is_iomem is kinda only well-defined if there's a vmap of
the buffer around (which also pins it), or in general when the buffer is
pinned. Outside of that an ->is_iomem function doesn't make much sense.
-Daniel

>=20
> Best regards
> Thomas
>=20
> [1]
> https://lore.kernel.org/dri-devel/20191106093121.21762-1-tzimmermann@suse=
.de/
>=20
> >=20
> > What Dave Airlie mentioned is just about memcpy_toio vs the sparc bus
> > version, for which we don't have any drivers really. But I do think we
> > need to differentiate between memcpy and memcpy_tio. That's what this
> > entire annoying _cfb_ vs _sys_ business is all about, and also what gem
> > vram helpers have to deal with.
> > -Daniel
> >=20
> >>>  		src +=3D fb->pitches[0];
> >>>  		dst +=3D fb->pitches[0];
> >>>  	}
> >>>
> >>
> >> --=20
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> >> (HRB 36809, AG N=FCrnberg)
> >> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
> >>
> >=20
> >=20
> >=20
> >=20
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >=20
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
