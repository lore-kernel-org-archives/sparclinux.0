From: "Antonino A. Daplas" <adaplas@hotpop.com>
Date: Thu, 17 Feb 2005 21:30:39 +0000
Subject: Re: [Linux-fbdev-devel] Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502180530.41332.adaplas@hotpop.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <200502170724.36195.adaplas@hotpop.com> <200502171516.14390.aragorn@tiscali.nl>
In-Reply-To: <200502171516.14390.aragorn@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <aragorn@tiscali.nl>, adaplas@pol.net
Cc: "David S. Miller" <davem@davemloft.net>, debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Thursday 17 February 2005 22:16, Frans Pop wrote:
> On Thursday 17 February 2005 00:24, Antonino A. Daplas wrote:
> > > Try this patch and let me know.
> > >
> > > video=atyfb:comp_sync:<n>,vert_sync:<n>,hor_sync:<n>
> > >
> > > n = 0 (low), 1 (high)
>
> I've tested with the following combinations:
> - append="video=atyfb:comp_sync:1,1024x768@70"
>   Works perfectly: csync is high and good display.
> - append="video=atyfb:comp_sync:1,hor_sync:1,vert_sync:0,1024x768@70"
>   csync is high, but for some reason not hsync; display is good.

Okay, it seems that overriding the vsync and hsync settings is useless in
atyfb as it has its own algo to do that:

	if(vdisplay < 400) {
		h_sync_pol = 1;
		v_sync_pol = 0;
	} else if(vdisplay < 480) {
		h_sync_pol = 0;
		v_sync_pol = 1;
	} else if(vdisplay < 768) {
		h_sync_pol = 0;
		v_sync_pol = 0;
	} else {
		h_sync_pol = 1;
		v_sync_pol = 1;
	}

I'll trim the patch for csync only.

> - append="video=atyfb:1024x768@70,comp_sync:1"
>   Same results as first test.
>
> The sync settings were checked with 'fbset -i'.
>
> > BTW, the mode string should always be the last parameter, ie;
> >
> > video=atyfb:comp_sync:1,1024x768@70
>
> Hmmm. Wonder why you say that (considering the result of my last test).

My mistake then.  Thanks for verifying.

>
> Should these new options also be documented in Documentation/fb/?

I'll add this and fix a few buglets when I push upstream.

Tony


