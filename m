From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Fri, 20 Aug 2004 21:07:49 +0000
Subject: Re: Buglet making vmlinux with -j
Message-Id: <20040820210749.GA14507@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200408202156.06459.crn@netunix.com>
In-Reply-To: <200408202156.06459.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Aug 20, 2004 at 02:05:29PM -0700, David S. Miller wrote:

> It's because of all the btfixup stuff in the sparc32
> build machinery, William.
> 
> He doesn't need to give any more description, it is clear
> what the issue is.

Yes, and there's a patch for it I got long ago, I think from Pete who
in turn got it from someone else (feel free to speak up).  I doubt
this was ever integrated, since 2.4 is dead and buried.

diff -ur linux-2.4-export-orig/arch/sparc/Makefile linux-2.4-export-new/arch/sparc/Makefile
--- linux-2.4-export-orig/arch/sparc/Makefile	Sun Feb 16 01:23:12 2003
+++ linux-2.4-export-new/arch/sparc/Makefile	Sun May 18 14:07:02 2003
@@ -45,6 +45,7 @@
 	$(TOPDIR)/arch/sparc/lib/lib.a
 
 # This one has to come last
+_dir_arch/sparc/boot :  $(patsubst %, _dir_%, $(SUBDIRS))
 SUBDIRS += arch/sparc/boot
 CORE_FILES_NO_BTFIX := $(CORE_FILES)
 CORE_FILES += arch/sparc/boot/btfix.o
diff -ur linux-2.4-export-orig/arch/sparc/boot/Makefile linux-2.4-export-new/arch/sparc/boot/Makefile
--- linux-2.4-export-orig/arch/sparc/boot/Makefile	Sun Feb 16 01:24:48 2003
+++ linux-2.4-export-new/arch/sparc/boot/Makefile	Sun May 18 13:55:44 2003
@@ -26,11 +26,14 @@
 BTLIBS := $(CORE_FILES_NO_BTFIX) $(FILESYSTEMS) \
 	$(DRIVERS) $(NETWORKS)
 
-# I wanted to make this depend upon BTOBJS so that a parallel
-# build would work, but this fails because $(HEAD) cannot work
-# properly as it will cause head.o to be built with the implicit
-# rules not the ones in kernel/Makefile.  Someone please fix. --DaveM
-vmlinux.o: dummy
+GENFILES := include/linux/version.h include/linux/compile.h $(foreach dirname, $(CORE_FILES_NO_BTFIX), _dir_$(dir $(dirname)))
+.PHONY : $(GENFILES)
+GENFILES += $(BTOBJS)
+
+$(GENFILES) :
+	$(MAKE) -C $(TOPDIR) $@
+
+vmlinux.o: $(GENFILES)
 	$(LD) -r $(patsubst %,$(TOPDIR)/%,$(BTOBJS)) \
 		--start-group \
 		$(patsubst %,$(TOPDIR)/%,$(BTLIBS)) \



-- 
Keith M Wesolowski
