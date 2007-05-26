From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sat, 26 May 2007 19:39:09 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070526193908.GA18103@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, May 25, 2007 at 10:00:36PM -0700, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Sat, 26 May 2007 01:24:40 +0100
> 
> > Hi Kyle,
> > 
> > After some minor fixes this builds, and the DRM drivers also
> > build again. I cannot test this since I do not have a machine with
> > PCI or these cards.
> > Removed your name in the comment, as that went out of fashion after
> > we started using proper versioning systems.
> > 
> > I've got a ppc->sparc32 compiler if that would help...
> 
> So how in the world is something like this going to "work" with DRM?

Work? It's not going to work. DRM checks the architecture in
drm_cpu_valid(), and won't run I guess.

> Userland cannot disable interrupts and it can't take the magic lock
> the kernel uses to provide mutual exclusion for the emulated
> cmpxchg().
> 
> All userland can do is not try to use the atomic operations and always
> go into the kernel, which defeats the entire point of the cmpxchg().
> 
> Unless something %100 inside of the kernel will be the only consumers
> of this, I'd recommend not adding it.  You can't let anything part of
> a userland API try to make use of it, and DRM definitely falls into
> that category.
> 
> Sparc 32-bit barely has PCI let alone 3D graphics cards.
> 
> If it's a build issue, simply disallow DRM to be turned on for
> SPARC32.

LOL, that was my initial approach until I saw Kyle's code.
Here's the patch I was preparing for that:
---

The DRM code does not build clean for sparc32 because it depends on
cmpxchg() which is not available. Even if it would build, it would
not run anyways because of the check in drm_cpu_valid().
So the best solution is to remove DRM for sparc32.

Patch against 2.6.21 attached.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: 2.6.21_drm/drivers/char/drm/Kconfig
=================================--- 2.6.21_drm.orig/drivers/char/drm/Kconfig	2007-05-23 22:35:32.000000000 +0100
+++ 2.6.21_drm/drivers/char/drm/Kconfig	2007-05-23 22:37:25.000000000 +0100
@@ -6,7 +6,7 @@
 #
 config DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
-	depends on (AGP || AGP=n) && PCI
+	depends on (AGP || AGP=n) && PCI && !SPARC32
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
