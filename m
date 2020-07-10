From: Dave Airlie <airlied@gmail.com>
Date: Fri, 10 Jul 2020 21:11:54 +0000
Subject: Re: [PATCH] drm/drm_fb_helper: fix fbdev with sparc64
Message-Id: <CAPM=9twjJs2mnNzxSQDBrOmDyp5iqM3ANhLwQ9N5kWEAKC0aZQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200709193016.291267-1-sam@ravnborg.org>
 <14ce41c4-d683-1551-9f21-37b054f5752c@suse.de>
 <18725e54-517d-75dc-282d-96d27e34d8b8@ilande.co.uk>
In-Reply-To: <18725e54-517d-75dc-282d-96d27e34d8b8@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>

> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >
> > but I'd like to have someone with more architecture expertise ack this
> > as well.
>
> Agreed. All my testing is using the bochs_drm framebuffer under qemu-system-sparc64
> (a sun4u machine) so it would be nice to get an ACK from Dave or someone else who can
> vouch for this on real hardware.

I'm not sure there exists real hardware that would come down this
path, I believe the last sparc64 with a GPU is a mach64, or maybe an
r128 card.

Otherwise I think using the memcpy io should be fine here on all architectures.

Dave.
