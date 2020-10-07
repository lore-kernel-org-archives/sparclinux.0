From: Christoph Hellwig <hch@lst.de>
Date: Wed, 07 Oct 2020 07:44:44 +0000
Subject: fbdev sbuslib cleanups
Message-Id: <20201007074447.797968-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi all,

this series cleans up the fbdev sbuslib support, most importantly by
removing usage of the deprecated compat_alloc_user_space API.
