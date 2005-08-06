From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 06 Aug 2005 15:49:50 +0000
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Message-Id: <20050806.084950.74730249.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <40f323d00508051218c30d7af@mail.gmail.com>
	<20050806.065520.85401639.davem@davemloft.net>
	<20050806150103.GA21821@suse.de>
In-Reply-To: <20050806150103.GA21821@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: olh@suse.de
Cc: bboissin@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Olaf Hering <olh@suse.de>
Date: Sat, 6 Aug 2005 17:01:03 +0200

> So the patch should be reverted? Its only for CONFIG_SWAP=n, rather
> unusual for KDE/GNOME tainted workstations...

Not necessarily, but the header dependencies should be fixed
up somehow.
