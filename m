From: Frans Pop <elendil@planet.nl>
Date: Wed, 22 Jul 2009 17:07:39 +0000
Subject: Re: [PATCH,resend] sparc64: build compressed image (zImage) by default
Message-Id: <200907221907.40698.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <200907162041.53181.elendil@planet.nl> <20090716201601.GA6038@merkur.ravnborg.org>
In-Reply-To: <20090716201601.GA6038@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Jurij Smakov <jurij@wooyd.org>, David Miller <davem@davemloft.net>

On Thursday 16 July 2009, Sam Ravnborg wrote:
> On Thu, Jul 16, 2009 at 08:41:52PM +0200, Frans Pop wrote:
> > From: Jurij Smakov <jurij@wooyd.org>
> > Subject: sparc64: build compressed image (zImage) by default
> >
> > Besides creating the uncompressed vmlinux image for sparc64, also
> > create a compressed zImage. This is more consistent with other
> > architectures and required to make the 'deb-pkg' target work.
> >
> > Signed-off-by: Jurij Smakov <jurij@wooyd.org>
> > Signed-off-by: Frans Pop <elendil@planet.nl>
>
> Hmmm..
> This path does the following:
> 1) zImage becomes default for sparc and sparc64
> 2) fixes zImage on sparc64 (it dod not work before)
> 3) On sparc zImage is a stripped version of vmlinux, on sparc64 it is a
> gzipped not-stripped version of vmlinux - so it introduces a
> significantly different zImage.

If I read arch/sparc/boot/Makefile correctly then the sparc64 image _is_ 
stripped as the zImage target calls $(obj)/image which does the strip.
So the difference is less than you suggest.

> Could we agree on the _same_ format for zImage on sparc and sparc64 and
> then apply that patch?

I vaguely recall from Debian work that loading compressed kernels caused 
problems on sparc32 hardware (due to insufficient memory?), which could 
justify the difference. But I may be wrong.

Cheers,
FJP
