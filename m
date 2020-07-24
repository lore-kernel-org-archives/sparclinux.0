From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 24 Jul 2020 06:56:20 +0000
Subject: Re: [PATCH] drm/drm_fb_helper: fix fbdev with sparc64
Message-Id: <c153037b-9c62-ce2c-60b1-9ce1e6cbe937@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UoNhuhgd8y0iyS9rbFTQ3jZevNbTlzfLf"
List-Id: <sparclinux.vger.kernel.org>
References: <20200709193016.291267-1-sam@ravnborg.org>
 <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
 <20200713162159.GR3278063@phenom.ffwll.local>
 <1ed6bd2a-6f8f-ca69-3244-03402874d5a3@suse.de>
 <20200714084141.GW3278063@phenom.ffwll.local>
 <a3fdd8b9-bf2b-dcd7-63b7-91f379865a6c@suse.de>
 <CAPM=9tyoJhvudNake+w=e4S9dQ8MT_bQEF9USuj=_vHBRLzA8Q@mail.gmail.com>
In-Reply-To: <CAPM=9tyoJhvudNake+w=e4S9dQ8MT_bQEF9USuj=_vHBRLzA8Q@mail.gmail.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dri-devel <dri-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UoNhuhgd8y0iyS9rbFTQ3jZevNbTlzfLf
Content-Type: multipart/mixed; boundary="7xhbTJCUlprBHMzC4KPIrLubtUNH8uRUl";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dave Airlie <airlied@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Gerd Hoffmann <kraxel@redhat.com>, sparclinux@vger.kernel.org,
 Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <c153037b-9c62-ce2c-60b1-9ce1e6cbe937@suse.de>
Subject: Re: [PATCH] drm/drm_fb_helper: fix fbdev with sparc64
References: <20200709193016.291267-1-sam@ravnborg.org>
 <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
 <20200713162159.GR3278063@phenom.ffwll.local>
 <1ed6bd2a-6f8f-ca69-3244-03402874d5a3@suse.de>
 <20200714084141.GW3278063@phenom.ffwll.local>
 <a3fdd8b9-bf2b-dcd7-63b7-91f379865a6c@suse.de>
 <CAPM=9tyoJhvudNake+w=e4S9dQ8MT_bQEF9USuj=_vHBRLzA8Q@mail.gmail.com>
In-Reply-To: <CAPM=9tyoJhvudNake+w=e4S9dQ8MT_bQEF9USuj=_vHBRLzA8Q@mail.gmail.com>

--7xhbTJCUlprBHMzC4KPIrLubtUNH8uRUl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 24.07.20 um 06:53 schrieb Dave Airlie:
> On Tue, 14 Jul 2020 at 18:56, Thomas Zimmermann <tzimmermann@suse.de> w=
rote:
>>
>> Hi
>>
>> Am 14.07.20 um 10:41 schrieb Daniel Vetter:
>>> On Tue, Jul 14, 2020 at 08:41:58AM +0200, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 13.07.20 um 18:21 schrieb Daniel Vetter:
>>>>> On Fri, Jul 10, 2020 at 08:28:16AM +0200, Thomas Zimmermann wrote:
>>>>>> Hi
>>>>>>
>>>>>> Am 09.07.20 um 21:30 schrieb Sam Ravnborg:
>>>>>>> Mark reported that sparc64 would panic while booting using qemu.
>>>>>>> Mark bisected this to a patch that introduced generic fbdev emula=
tion to
>>>>>>> the bochs DRM driver.
>>>>>>> Mark pointed out that a similar bug was fixed before where
>>>>>>> the sys helpers was replaced by cfb helpers.
>>>>>>>
>>>>>>> The culprint here is that the framebuffer reside in IO memory whi=
ch
>>>>>>> requires SPARC ASI_PHYS (physical) loads and stores.
>>>>>>>
>>>>>>> The current bohcs DRM driver uses a shadow buffer.
>>>>>>> So all copying to the framebuffer happens in
>>>>>>> drm_fb_helper_dirty_blit_real().
>>>>>>>
>>>>>>> The fix is to replace the memcpy with memcpy_toio() from io.h.
>>>>>>>
>>>>>>> memcpy_toio() uses writeb() where the original fbdev code
>>>>>>> used sbus_memcpy_toio(). The latter uses sbus_writeb().
>>>>>>>
>>>>>>> The difference between writeb() and sbus_memcpy_toio() is
>>>>>>> that writeb() writes bytes in little-endian, where sbus_writeb() =
writes
>>>>>>> bytes in big-endian. As endian does not matter for byte writes th=
ey are
>>>>>>> the same. So we can safely use memcpy_toio() here.
>>>>>>>
>>>>>>> For many architectures memcpy_toio() is a simple memcpy().
>>>>>>> One sideeffect that is unknow is if this has any impact on other
>>>>>>> architectures.
>>>>>>> So far the analysis tells that this change is OK for other arch's=
=2E
>>>>>>> but testing would be good.
>>>>>>>
>>>>>>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>>>>>>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>>>> Cc: sparclinux@vger.kernel.org
>>>>>>
>>>>>> So this actually is a problem in practice. Do you know how userspa=
ce
>>>>>> handles this?
>>>>>>
>>>>>> For this patch
>>>>>>
>>>>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>>
>>>>>> but I'd like to have someone with more architecture expertise ack =
this
>>>>>> as well.
>>>>>>
>>>>>> Best regards
>>>>>> Thomas
>>>>>>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/dr=
m_fb_helper.c
>>>>>>> index 5609e164805f..4d05b0ab1592 100644
>>>>>>> --- a/drivers/gpu/drm/drm_fb_helper.c
>>>>>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>>>>>>> @@ -399,7 +399,7 @@ static void drm_fb_helper_dirty_blit_real(str=
uct drm_fb_helper *fb_helper,
>>>>>>>   unsigned int y;
>>>>>>>
>>>>>>>   for (y =3D clip->y1; y < clip->y2; y++) {
>>>>>>> -         memcpy(dst, src, len);
>>>>>>> +         memcpy_toio(dst, src, len);
>>>>>
>>>>> I don't think we can do this unconditionally, there's fbdev-helper =
drivers
>>>>> using shmem helpers, and for shmem memcpy_toio is wrong. We need a =
switch
>>>>> to fix this properly I think.
>>>>
>>>> I once has a patch set for this problem, but it didn't make it. [1]
>>>>
>>>> Buffers can move between I/O and system memory, so a simple flag wou=
ld
>>>> not work. I'd propose this
>>>>
>>>> bool drm_gem_is_iomem(struct drm_gem_object *obj)
>>>> {
>>>>      if (obj->funcs && obj->funcs->is_iomem)
>>>>              return obj->funcs->is_iomem(obj);
>>>>      return false;
>>>> }
>>>>
>>>> Most GEM implmentations wouldn't bother, but VRAM helpers could set =
the
>>>> is_iomem function and return the current state. Fbdev helpers can th=
en
>>>> pick the correct memcpy_*() function.
>>>
>>> Hm wasn't the (long term at least) idea to add the is_iomem flag to t=
he
>>> vmap functions? is_iomem is kinda only well-defined if there's a vmap=
 of
>>> the buffer around (which also pins it), or in general when the buffer=
 is
>>> pinned. Outside of that an ->is_iomem function doesn't make much sens=
e.
>>
>> Oh. From how I understood the original discussion, you shoot down the
>> idea because sparse would not support it well?
>>
>> The other idea was to add an additional vmap_iomem() helper that retur=
ns
>> an__iomem pointer. Can we try that?
>>
> Did we get anywhere with this yet?

Not yet. But I intend to work on it ASAP.

Best regards
Thomas

>=20
> Dave.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--7xhbTJCUlprBHMzC4KPIrLubtUNH8uRUl--

--UoNhuhgd8y0iyS9rbFTQ3jZevNbTlzfLf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8ahhQUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiPmXwf/W5Yjjrg0BIkPRFUi8DFIHNs+8AAD
m807dUpcXqY84uLF7sG57ug9qfVX/rjLTvNjwytQsjretvm/kBa1aeKD9vockdR8
iBhVR08MG9g83gMnj9rzFlWTka+P8w9geHYDC/S90dMCtxHvMQUYoaA0c+40lRLc
yBMfobc1RnPrWzv2W8BFA/YIUaTTfwtDD73T7JpIm9N5rqMkPoIBz4v9ERdLTL/e
+cuxbGFtR2K3ZE6u07q/88E4ohAIcDl2+fG5lcHNSR++p7eizxygEACmbaqQyjOo
ISgHoETr5s1oWBN0OcwWDN5zoN/XErAb4M1w8BCgCyQG41Brm7CWv66PLA==
=n5dj
-----END PGP SIGNATURE-----

--UoNhuhgd8y0iyS9rbFTQ3jZevNbTlzfLf--
