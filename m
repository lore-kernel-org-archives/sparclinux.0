From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 10 Jul 2020 19:10:01 +0000
Subject: Re: [PATCH] drm/drm_fb_helper: fix fbdev with sparc64
Message-Id: <18725e54-517d-75dc-282d-96d27e34d8b8@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200709193016.291267-1-sam@ravnborg.org>
 <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
In-Reply-To: <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org
Cc: sparclinux@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 10/07/2020 07:28, Thomas Zimmermann wrote:

Hi Sam,

Thanks again for the patch. I've spotted some small typos that you may like to fix if
you repost the patch:

> Hi
> 
> Am 09.07.20 um 21:30 schrieb Sam Ravnborg:
>> Mark reported that sparc64 would panic while booting using qemu.
>> Mark bisected this to a patch that introduced generic fbdev emulation to
>> the bochs DRM driver.
>> Mark pointed out that a similar bug was fixed before where
>> the sys helpers was replaced by cfb helpers.
>> The culprint here is that the framebuffer reside in IO memory which

Typo here: culprit

>> requires SPARC ASI_PHYS (physical) loads and stores.
>>
>> The current bohcs DRM driver uses a shadow buffer.

And another here: bochs

>> So all copying to the framebuffer happens in
>> drm_fb_helper_dirty_blit_real().

How about this as an alternative to the above paragraphs which might be a bit easier
to read:

Recent kernels have been reported to panic using the bochs_drm framebuffer under
qemu-system-sparc64 which was bisected to commit 7a0483ac4ffc "drm/bochs: switch to
generic drm fbdev emulation". The backtrace indicates that the shadow framebuffer
copy in drm_fb_helper_dirty_blit_real() is trying to access the real framebuffer
using a virtual address rather than use an IO access typically implemented using a
physical (ASI_PHYS) access on SPARC.

>> The fix is to replace the memcpy with memcpy_toio() from io.h.
>>
>> memcpy_toio() uses writeb() where the original fbdev code
>> used sbus_memcpy_toio(). The latter uses sbus_writeb().
>>
>> The difference between writeb() and sbus_memcpy_toio() is
>> that writeb() writes bytes in little-endian, where sbus_writeb() writes
>> bytes in big-endian. As endian does not matter for byte writes they are
>> the same. So we can safely use memcpy_toio() here.
>>
>> For many architectures memcpy_toio() is a simple memcpy().
>> One sideeffect that is unknow is if this has any impact on other

side-effect

>> architectures.
>> So far the analysis tells that this change is OK for other arch's.
>> but testing would be good.
>>
>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
> 
> So this actually is a problem in practice. Do you know how userspace
> handles this?
> 
> For this patch
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> but I'd like to have someone with more architecture expertise ack this
> as well.

Agreed. All my testing is using the bochs_drm framebuffer under qemu-system-sparc64
(a sun4u machine) so it would be nice to get an ACK from Dave or someone else who can
vouch for this on real hardware.


ATB,

Mark.
