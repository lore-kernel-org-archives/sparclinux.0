From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 28 May 2007 23:37:01 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070528233700.GA24422@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 27, 2007 at 07:49:21PM -0700, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Mon, 28 May 2007 01:07:46 +0100
> 
> > On Sat, May 26, 2007 at 03:59:21PM -0700, David Miller wrote:
> > > Alternatively we can have a KCONFIG variable with reversed
> > > logic, like "EMULATED_CMPXCHG" which only the atomically
> > > challenged platforms need to set.
> > 
> > Like this idea, but if we're not going to build DRM I see no
> > point adding the cmpxchg emulation to sparc32. Maybe "NOARCH_CMPXCHG"
> > would be better?
> 
> It is likely that we are going to have generic users of cmpxchg() in
> the kernel in the future (I think the -rt patch set has some which are
> hard to get rid of) at which point we'd probably put the emulated
> cmpxchg() in there anyways.

Good to see someone has a crystal ball handy. So a patch like like this
to solve the DRM issue? With it DRM can no longer be selected.

---
The DRM code depends on an atomic version of cmpxchg(), which is not
available on sparc32. Since other platforms besides sparc32 have
this issue a KCONFIG option is added for it.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Index: 2.6.21_drm/drivers/char/drm/Kconfig
=================================--- 2.6.21_drm.orig/drivers/char/drm/Kconfig	2007-05-26 00:18:45.000000000 +0100
+++ 2.6.21_drm/drivers/char/drm/Kconfig	2007-05-28 23:49:12.000000000 +0100
@@ -6,7 +6,7 @@
 #
 config DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
-	depends on (AGP || AGP=n) && PCI
+	depends on (AGP || AGP=n) && PCI && !EMULATED_CMPXCHG
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
Index: 2.6.21_drm/arch/sparc/Kconfig
=================================--- 2.6.21_drm.orig/arch/sparc/Kconfig	2007-05-23 19:31:01.000000000 +0100
+++ 2.6.21_drm/arch/sparc/Kconfig	2007-05-29 00:03:16.000000000 +0100
@@ -178,6 +178,13 @@
 	bool
 	default n
 
+config EMULATED_CMPXCHG
+	bool
+	default y
+	help
+	  Sparc32 does not have a CAS instruction like sparc64. cmpxchg()
+	  is emulated, and therefore it is not completely atomic.
+
 config SUN_PM
 	bool
 	default y
