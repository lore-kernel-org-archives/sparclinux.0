From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 07 Oct 2020 11:07:05 +0000
Subject: Re: [PATCH 1/3] fbdev/sbuslib: remove FBIOSCURSOR/FBIOGCURSOR leftovers
Message-Id: <CAK8P3a1JdeCxr16+wAnYqLwJBuLqTgS7h-UCoiXD5OijQ-evyg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007074447.797968-1-hch@lst.de> <20201007074447.797968-2-hch@lst.de>
 <CAK8P3a0UHEsND+vJjhtj2GKQpMjMCqD55vQ9+2u-SCrThe3wTw@mail.gmail.com>
 <20201007085911.GA17356@lst.de> <CAK8P3a2w1Q4coFLnW4sDQEC_01uwWWUkuGyqj=r=x3jtB8uhNA@mail.gmail.com>
 <20201007104046.GB24327@lst.de>
In-Reply-To: <20201007104046.GB24327@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, sparclinux <sparclinux@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Wed, Oct 7, 2020 at 12:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Oct 07, 2020 at 11:28:58AM +0200, Arnd Bergmann wrote:
> > The only one I have actually given up on is the atomisp staging driver,
> > which uses an awful hack, copying the x86 implementation of
> > copy_in_user()/compat_alloc_user_space() into the driver.
>
> That is gross.  Just mark the driver as broken for now.

Ah, it seems that Hans has already done that in commit 57e6b6f2303e
("media: atomisp_fops.c: disable atomisp_compat_ioctl32"), which
removes the only reference to this code. In this case, I think a one-line
change to stop building that file would be best, then if anyone ever
wants to fix the bug that Hans and Sakari found, they get to do also
deal with replacing compat_alloc_user_space().

I'll send a patch for that right away, the patch I have in my tree was
so evil that I hadn't dared submit that, but it was useful for
compile-testing the compat_alloc_user_space() removal patch.

   Arnd
