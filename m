From: Olaf Hering <olh@suse.de>
Date: Mon, 22 May 2006 07:11:07 +0000
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Message-Id: <20060522071107.GA7715@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <40f323d00508051218c30d7af@mail.gmail.com> <20050806.065520.85401639.davem@davemloft.net> <20050806150103.GA21821@suse.de> <20050806.084950.74730249.davem@davemloft.net>
In-Reply-To: <20050806.084950.74730249.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: bboissin@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

 On Sat, Aug 06, David S. Miller wrote:

> From: Olaf Hering <olh@suse.de>
> Date: Sat, 6 Aug 2005 17:01:03 +0200
> 
> > So the patch should be reverted? Its only for CONFIG_SWAP=n, rather
> > unusual for KDE/GNOME tainted workstations...
> 
> Not necessarily, but the header dependencies should be fixed
> up somehow.

I think you are right once again.
(Just the time got a bit out of sync.)
