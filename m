From: "Antonino A. Daplas" <adaplas@hotpop.com>
Date: Wed, 16 Feb 2005 23:24:36 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502170724.36195.adaplas@hotpop.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <200502162310.12703.aragorn@tiscali.nl> <200502170702.58630.adaplas@hotpop.com>
In-Reply-To: <200502170702.58630.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <aragorn@tiscali.nl>, "David S. Miller" <davem@davemloft.net>
Cc: adaplas@pol.net, debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Thursday 17 February 2005 07:02, Antonino A. Daplas wrote:
> On Thursday 17 February 2005 06:10, Frans Pop wrote:
> > On Wednesday 16 February 2005 16:51, David S. Miller wrote:
> > > On Wed, 16 Feb 2005 19:27:57 +0800 Antonino A. Daplas wrote:
> > > > Nope, those are proposed options.  If nobody disagrees, I can easily
> > > > add this for atyfb.
> > >
> > > Please do.
> > >
> > > BTW, for Sparc we may wish to inherit the CSYNC setting from
> > > default_var.
> >
> > Sounds like a nice idea.
> >
> > If you have a patch that you would like to have tested, feel free to mail
> > me.
>
> Try this patch and let me know.
>
> video=atyfb:comp_sync:<n>,vert_sync:<n>,hor_sync:<n>
>
> n = 0 (low), 1 (high)

BTW, the mode string should always be the last parameter, ie;

video=atyfb:comp_sync:1,1024x768@70

Tony


