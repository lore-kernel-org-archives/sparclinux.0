From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 07 Oct 2020 09:14:27 +0000
Subject: Re: [PATCH 3/3] fbdev/sbuslib: avoid compat_alloc_user_space in fbiogetputcmap
Message-Id: <CAK8P3a0kojDb55g8qG9BUrS+Oh9H5dNqs=JXZ7vsoDb+0-Qr+Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007074447.797968-1-hch@lst.de> <20201007074447.797968-4-hch@lst.de>
In-Reply-To: <20201007074447.797968-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, sparclinux <sparclinux@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Wed, Oct 7, 2020 at 9:44 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Rewrite fbiogetputcmap to call the low-level sbusfb_ioctl_{put,get}cmap
> helpers directly and thus avoid usage of the deprecated
> compat_alloc_user_space API.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is another one that I had already addressed in a somewhat inferior way.
I attempted the same kind of cleanup that you did in patch 2/3 but failed to
convince myself that I had managed to avoid regressions, so my patch just
copy-pasted the native implementation into the compat handler with minor
changes.

Provided that your preparation patch is correct, this version is clearly better
than mine, but again I don't know the state of that patch after Sam had
said he applied it already.

     Arnd
