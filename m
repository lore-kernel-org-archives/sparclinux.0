From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jan 2011 02:29:45 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <20110111.182945.200098560.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 12 Jan 2011 02:14:59 +0000

> I just found the problem. Here's a patch that makes the s3fb  driver
> work. Haven't seen any output on the device yet that's to come later.
> Here's a quick patch:
> 
> --- s3fb.c.orig 2011-01-12 02:09:47.339553002 +0000
> +++ s3fb.c      2011-01-12 02:10:01.411553002 +0000
> @@ -383,7 +383,7 @@
>  
>                 memset(&(par->state), 0, sizeof(struct vgastate));
>                 par->state.vgabase = vgabase;
> -               par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS |
> VGA_SAVE_CMAP;
> +               par->state.flags = VGA_SAVE_MODE | VGA_SAVE_CMAP;
>                 par->state.num_crtc = 0x70;
>                 par->state.num_seq = 0x20;
>                 save_vga(&(par->state));

Hmmm, while this change is correct, restore_vga() should skip VGA_SAVE_FONTS
if state->membase is zero, which it ought ot be here.  If state->membase
is zero, then ioremap() will return NULL.  If ioremap() returns NULL then
restore_vga() should cleanup and return 1.

Oh... I see what is happening.  save_vga() sets this value using it's
own heuristics, when VGA_SAVE_FONTS is set, but in a way that won't
work in multi-domain PCI situations.

So we need to set this up in the drivers just like we do for the
'vgabase' member.

I'll work on some patches to fix this.

Thanks.
