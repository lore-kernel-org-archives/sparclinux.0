From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 15 Feb 2005 16:49:58 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or
Message-Id: <20050215084958.1f68b39b.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl>
	<200502150741.01702.adaplas@hotpop.com>
	<200502150722.24770.aragorn@tiscali.nl>
	<200502152010.22880.adaplas@hotpop.com>
In-Reply-To: <200502152010.22880.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: adaplas@hotpop.com, aragorn@tiscali.nl, debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, 15 Feb 2005 20:10:21 +0800
"Antonino A. Daplas" <adaplas@hotpop.com> wrote:

> Okay.  It seems that in the working kernel, the default mode, 1152x900, was
> taken from the prom (since there is no 1152x900 in the mode database) if you
> did not specify any boot mode option.
> 
> In the non-working version, without the boot mode option, the default_var
> was used (which is only 640x480) or taken from the mode database if you
> specified a boot mode.

I think the bug is in the changes made to the fb_find_mode() calls
in the !CONFIG_PPC case.  That looked suspicious to me the first time
I scanned the atyfb driver diffs in 2.6.11

First of all, a file global declared as "static char *mode" is asking for
all sorts of trouble.  It's very easy to use such a simple name as
a function local variable, thus making the global one invisible.

I reviewed the driver and there are no cases of local variables named
"mode" right now, but this is still asking for trouble in the future.
It should be thus renamed.

Now let's get back to the fb_find_mode() call in aty_init().  The old
code for the non-CONFIG_PPC case did this:

#ifdef __sparc__
	if (mode_option) {
		if (!fb_find_mode(...))
			var = default_var;
	} else
		var = default_var;
#else
	if (!fb_find_mode(...))
		var = default_var;
#endif

The new code calls fb_find_mode() always, this is wrong for Sparc's
desired behavior:

	if (!fb_find_mode(...))
		var = default_var;

On sparc, when "mode" is NULL, we should always use default_var as
setup by PROM probed values.

Here is the fix:

=== drivers/video/aty/atyfb_base.c 1.82 vs edited ==--- 1.82/drivers/video/aty/atyfb_base.c	2005-01-04 18:48:32 -08:00
+++ edited/drivers/video/aty/atyfb_base.c	2005-02-15 08:19:00 -08:00
@@ -2511,7 +2511,15 @@
 		}
 	} else
 #endif /* !CONFIG_PPC */
-	if (!fb_find_mode(&var, info, mode, NULL, 0, &defmode, 8))
+	if (
+#if defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
+	   /* On Sparc, unless the user gave a specific mode
+	    * specification, use the PROM probed values in
+	    * default_var.
+	    */
+	    !mode ||
+#endif
+	    !fb_find_mode(&var, info, mode, NULL, 0, &defmode, 8))
 		var = default_var;
 
 	if (noaccel)
