From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 30 Apr 2013 21:46:05 +0000
Subject: Re: [PATCH] lib: add weak __clzsi2()/__clzdi2() functions
Message-Id: <20130430144605.1a99a7397702b332ee818fc8@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1367214005-14302-1-git-send-email-chanho.min@lge.com>
	<CAMuHMdWk4oi_KCmZv7hLZ7JSwy=meziKPBMQ1HJiJR9W8AdrDg@mail.gmail.com>
In-Reply-To: <CAMuHMdWk4oi_KCmZv7hLZ7JSwy=meziKPBMQ1HJiJR9W8AdrDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chanho Min <chanho.min@lge.com>, Kyungsik Lee <kyungsik.lee@lge.com>, Yann Collet <yann.collet.73@gmail.com>, Bob Pearson <rpearson@systemfabricworks.com>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Next <linux-next@vger.kernel.org>

On Mon, 29 Apr 2013 09:20:25 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, Apr 29, 2013 at 7:40 AM, Chanho Min <chanho.min@lge.com> wrote:
> > Some architectures need __clzsi2() or __clzdi2() for __builtin_clz and
> > It causes build failure. They can be implemented using the fls() and
> > overridden by linking arch-specific versions may not be implemented yet.
> >
> > Reference: https://lkml.org/lkml/2013/4/18/603
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Chanho Min <chanho.min@lge.com>
> 
> Thanks, this fixes the link error on m68k, so
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

It doesn't work for alpha (gcc-4.4.4):

ERROR: "__ctzdi2" [lib/lz4/lz4hc_compress.ko] undefined!
ERROR: "__ctzdi2" [lib/lz4/lz4_compress.ko] undefined!

akpm3:/usr/src/25> nm vmlinux|grep ctzd
akpm3:/usr/src/25> 

I assume the linker threw the code away.


How's about we stop using __builtin_ctz[ll]() altogether?  Use N-fls()?

btw, this:

int __weak __clzsi2(int val)
{
       return BITS_PER_LONG - fls(val);
}

looks wrong.  It will give a different result for 32- and 64-bit.
