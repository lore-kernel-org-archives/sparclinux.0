From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 06 Aug 2005 13:55:20 +0000
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Message-Id: <20050806.065520.85401639.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <40f323d005080511516a81a7d6@mail.gmail.com>
	<20050805190006.GA6747@suse.de>
	<40f323d00508051218c30d7af@mail.gmail.com>
In-Reply-To: <40f323d00508051218c30d7af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bboissin@gmail.com
Cc: olh@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Benoit Boissinot <bboissin@gmail.com>
Date: Fri, 5 Aug 2005 21:18:38 +0200

> On 8/5/05, Olaf Hering <olh@suse.de> wrote:
> >  On Fri, Aug 05, Benoit Boissinot wrote:
> > 
> > Why does it need swap.h? Do the users of pgtable.h rely on swap.h?
> > 
> sparc is the only architecture to do that, it looks like it uses it
> for boot time linking (BTFIXUP_*). I don't know anything about sparc,
> so i can't fix it.
> 
> (adding sparclinux@vger.kernel.org to the cc list)

It needs to have the swp_entry_t type fully visible in pgtable.h,
we can't work around this using macros.
