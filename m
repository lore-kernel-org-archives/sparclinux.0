From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 15 Nov 2004 23:56:03 +0000
Subject: Re: initrd testing [possible solution]
Message-Id: <20041115235603.GI3217@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0411032344240.25808@bobcat>
In-Reply-To: <Pine.LNX.4.61.0411032344240.25808@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 14 Nov 2004 23:16:40 -0500 (EST) Jurij Smakov <jurij@wooyd.org> wrote:
> > --- build-sparc32.orig/include/asm-sparc/string.h	2004-08-14 01:36:11.000000000 -0400
> > +++ build-sparc32/include/asm-sparc/string.h	2004-11-14 22:09:49.000000000 -0500
> > @@ -40,6 +40,9 @@
> > 
> >   	if(n <= 32) {
> >   		__builtin_memcpy(to, from, n);
> > +	} else if (((unsigned int) to & 7) != 0) {
> > +		/* Destination is not aligned on the double-word boundary */
> > +		__memcpy(to, from, n);
> >   	} else {
> >   		switch(n) {
> >   		case PAGE_SIZE:

On Mon, Nov 15, 2004 at 03:40:23PM -0800, David S. Miller wrote:
> This patch is perfectly fine, good catch.
> wli, you got this?

Absolutely.

-- wli
