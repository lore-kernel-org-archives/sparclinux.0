From: "Antonino A. Daplas" <adaplas@hotpop.com>
Date: Wed, 16 Feb 2005 11:27:57 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502161927.58344.adaplas@hotpop.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <200502152010.22880.adaplas@hotpop.com> <200502160327.47586.aragorn@tiscali.nl>
In-Reply-To: <200502160327.47586.aragorn@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <aragorn@tiscali.nl>, adaplas@pol.net
Cc: debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 16 February 2005 10:27, Frans Pop wrote:
> On Tuesday 15 February 2005 13:10, Antonino A. Daplas wrote:
> > Can you verify if this is the case?  Insert a bunch of printk's in and
> > around this line "if (node = pcp->prom_node) {" in
> > atyfb_setup_sparc().  For the 2.6.8 kernel, this line is in
> > atyfb_init().
>
> Tested that and output is identical for both. That condition you cite is
> true for both kernels and the resolutions are retrieved from prom:
> atyfb (fjp): crtc.vxres 1152
> atyfb (fjp): crtc.vyres 900
>
> > As a workaround, a boot option can be added for csync, hsync and vsync.
>
> Hmm. I looked for the syntax for that, but can't find it.
> I tried
>   video=atyfb:1024x768@70,csync:1
> and
>   video=atyfb:1024x768@70,csync:high
> but both failed miserably.
> (I have checked that csync is sufficient to activate the monitor.)

Nope, those are proposed options.  If nobody disagrees, I can easily add
this for atyfb.

Tony


