From: "Antonino A. Daplas" <adaplas@hotpop.com>
Date: Tue, 15 Feb 2005 12:10:21 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502152010.22880.adaplas@hotpop.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <200502150741.01702.adaplas@hotpop.com> <200502150722.24770.aragorn@tiscali.nl>
In-Reply-To: <200502150722.24770.aragorn@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <aragorn@tiscali.nl>, adaplas@pol.net
Cc: debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 15 February 2005 14:22, Frans Pop wrote:
> Hi Tony,
>
> I've tried your suggestions and the one about using fbset resulted in a
> breakthrough. 'fbset -depth' gave no results, but comparing the output of
> 'fbset -i' from a working kernel and a new one gave me something to try.
>

Okay.  It seems that in the working kernel, the default mode, 1152x900, was
taken from the prom (since there is no 1152x900 in the mode database) if you
did not specify any boot mode option.

In the non-working version, without the boot mode option, the default_var
was used (which is only 640x480) or taken from the mode database if you
specified a boot mode.  Unfortunately, none of the entries in the mode
database nor the default var has the composite sync set to high, which
causes your display to go out of sync.  If I'm going to guess, the 2.6.10
version failed to get the default mode from the prom.

Can you verify if this is the case?  Insert a bunch of printk's in and around this
line "if (node = pcp->prom_node) {" in atyfb_setup_sparc().  For the 2.6.8
kernel, this line is in atyfb_init().

As a workaround, a boot option can be added for csync, hsync and vsync. 

Tony



