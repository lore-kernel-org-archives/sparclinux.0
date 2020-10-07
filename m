From: Christoph Hellwig <hch@lst.de>
Date: Wed, 07 Oct 2020 10:40:46 +0000
Subject: Re: [PATCH 1/3] fbdev/sbuslib: remove FBIOSCURSOR/FBIOGCURSOR leftovers
Message-Id: <20201007104046.GB24327@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007074447.797968-1-hch@lst.de> <20201007074447.797968-2-hch@lst.de> <CAK8P3a0UHEsND+vJjhtj2GKQpMjMCqD55vQ9+2u-SCrThe3wTw@mail.gmail.com> <20201007085911.GA17356@lst.de> <CAK8P3a2w1Q4coFLnW4sDQEC_01uwWWUkuGyqj=r=x3jtB8uhNA@mail.gmail.com>
In-Reply-To: <CAK8P3a2w1Q4coFLnW4sDQEC_01uwWWUkuGyqj=r=x3jtB8uhNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, sparclinux <sparclinux@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Wed, Oct 07, 2020 at 11:28:58AM +0200, Arnd Bergmann wrote:
> The only one I have actually given up on is the atomisp staging driver,
> which uses an awful hack, copying the x86 implementation of
> copy_in_user()/compat_alloc_user_space() into the driver.

That is gross.  Just mark the driver as broken for now.  Linus agreed
years ago that we don't need to work around staging drivers.  But
it would still be nice to ping the mainainers, as they often have
better ideas how to solve the problem.
