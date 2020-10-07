From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 07 Oct 2020 08:54:19 +0000
Subject: Re: [PATCH 1/3] fbdev/sbuslib: remove FBIOSCURSOR/FBIOGCURSOR leftovers
Message-Id: <CAK8P3a0UHEsND+vJjhtj2GKQpMjMCqD55vQ9+2u-SCrThe3wTw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007074447.797968-1-hch@lst.de> <20201007074447.797968-2-hch@lst.de>
In-Reply-To: <20201007074447.797968-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, sparclinux <sparclinux@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Wed, Oct 7, 2020 at 9:44 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There are no actual implementations of FBIOSCURSOR/FBIOGCURSOR left, so
> don't bother with a compat handler for it, and remove the remaining
> definitions as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I had submitted a similar patch earlier, and Sam Ravnborg applied it to the
drm-misc tree, but it doesn't seem to be in linux-next, so I don't know
what the state is.

My version only removed the compat handling, not the data structures,
so I'm happy to see your version used instead if mine got lost.

Acked-by: Arnd Bergmann <arnd@arndb.de>
