From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 13 Jul 2020 16:21:59 +0000
Subject: Re: [PATCH] drm/drm_fb_helper: fix fbdev with sparc64
Message-Id: <20200713162159.GR3278063@phenom.ffwll.local>
List-Id: <sparclinux.vger.kernel.org>
References: <20200709193016.291267-1-sam@ravnborg.org>
 <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
In-Reply-To: <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>

On Fri, Jul 10, 2020 at 08:28:16AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 09.07.20 um 21:30 schrieb Sam Ravnborg:
> > Mark reported that sparc64 would panic while booting using qemu.
> > Mark bisected this to a patch that introduced generic fbdev emulation to
> > the bochs DRM driver.
> > Mark pointed out that a similar bug was fixed before where
> > the sys helpers was replaced by cfb helpers.
> >=20
> > The culprint here is that the framebuffer reside in IO memory which
> > requires SPARC ASI_PHYS (physical) loads and stores.
> >=20
> > The current bohcs DRM driver uses a shadow buffer.
> > So all copying to the framebuffer happens in
> > drm_fb_helper_dirty_blit_real().
> >=20
> > The fix is to replace the memcpy with memcpy_toio() from io.h.
> >=20
> > memcpy_toio() uses writeb() where the original fbdev code
> > used sbus_memcpy_toio(). The latter uses sbus_writeb().
> >=20
> > The difference between writeb() and sbus_memcpy_toio() is
> > that writeb() writes bytes in little-endian, where sbus_writeb() writes
> > bytes in big-endian. As endian does not matter for byte writes they are
> > the same. So we can safely use memcpy_toio() here.
> >=20
> > For many architectures memcpy_toio() is a simple memcpy().
> > One sideeffect that is unknow is if this has any impact on other
> > architectures.
> > So far the analysis tells that this change is OK for other arch's.
> > but testing would be good.
> >=20
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
>=20
> So this actually is a problem in practice. Do you know how userspace
> handles this?
>=20
> For this patch
>=20
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
> but I'd like to have someone with more architecture expertise ack this
> as well.
>=20
> Best regards
> Thomas
>=20
> > ---
> >  drivers/gpu/drm/drm_fb_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_h=
elper.c
> > index 5609e164805f..4d05b0ab1592 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -399,7 +399,7 @@ static void drm_fb_helper_dirty_blit_real(struct dr=
m_fb_helper *fb_helper,
> >  	unsigned int y;
> > =20
> >  	for (y =3D clip->y1; y < clip->y2; y++) {
> > -		memcpy(dst, src, len);
> > +		memcpy_toio(dst, src, len);

I don't think we can do this unconditionally, there's fbdev-helper drivers
using shmem helpers, and for shmem memcpy_toio is wrong. We need a switch
to fix this properly I think.

What Dave Airlie mentioned is just about memcpy_toio vs the sparc bus
version, for which we don't have any drivers really. But I do think we
need to differentiate between memcpy and memcpy_tio. That's what this
entire annoying _cfb_ vs _sys_ business is all about, and also what gem
vram helpers have to deal with.
-Daniel

> >  		src +=3D fb->pitches[0];
> >  		dst +=3D fb->pitches[0];
> >  	}
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




> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
