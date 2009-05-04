From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 04 May 2009 17:51:09 +0000
Subject: Re: [PATCH] igafb: use framebuffer_alloc() to allocate fb_info struct
Message-Id: <20090504175109.GA9489@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090504185956.82408911.krzysztof.h1@poczta.fm>
In-Reply-To: <20090504185956.82408911.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, sparclinux <sparclinux@vger.kernel.org>

Hi Krzysztof.
> diff -urp linux-orig/drivers/video/igafb.c linux-2.6.30/drivers/video/igafb.c
> --- linux-orig/drivers/video/igafb.c	2008-08-09 05:09:03.000000000 +0200
> +++ linux-2.6.30/drivers/video/igafb.c	2009-05-04 00:14:28.000000000 +0200
> @@ -395,17 +395,16 @@ int __init igafb_init(void)
>  	/* We leak a reference here but as it cannot be unloaded this is
>  	   fine. If you write unload code remember to free it in unload */
>  	
> -	size = sizeof(struct fb_info) + sizeof(struct iga_par) + sizeof(u32)*16;
> +	size = sizeof(struct iga_par) + sizeof(u32)*16;
>  
> -        info = kzalloc(size, GFP_ATOMIC);
> +	info = framebuffer_alloc(size, &pdev->dev);

While you are toucing this file it would be nice
with a follow-up patch that tabbified all of the file.
Today it looks like a mixture of tab and space used for indent.

checking the original file...
OK - it looks like the original file consistently used
space for indent and only fixes uses tabs.

	Sam
