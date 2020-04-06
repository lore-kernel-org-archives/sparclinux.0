From: Matt Turner <mattst88@gmail.com>
Date: Mon, 06 Apr 2020 20:27:16 +0000
Subject: [PATCH] silo: Allow building tilo only
Message-Id: <20200406202716.4008090-1-mattst88@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The bootloader bits are built as 32-bit, which can be difficult to do on
a system with a 64-bit userland since they include system headers.

Specifically, the inclusion of <gnu/stubs-32.h> is problematic since
this header is not provided on a non-multilib build of glibc.

	<gnu/stubs-32.h>, included by
	<gnu/stubs.h>, included by
	<features.h>, included by
	<elf.h> and <setjmp.h>

tilo is built for the host machine and doesn't have this problem.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 Makefile | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 15a0de1..b411020 100644
--- a/Makefile
+++ b/Makefile
@@ -3,27 +3,37 @@ include Rules.make
 
 # These only get built on Linux
 ifeq ($(OPSYS),Linux)
-  SUBDIRS  = common first second first-isofs tilo
+ifneq ($(TILO_ONLY),yes)
+  SUBDIRS  = common first second first-isofs
+endif
+  SUBDIRS += tilo
   MANPAGES = maketilo.1 tilo.1
 endif
 
+ifneq ($(TILO_ONLY),yes)
 # These get built on Linux and Solaris
 MANPAGES += silo.8 silo.conf.5
 SUBDIRS  += silo
+endif
 
 all dep depend clean:
 	@for I in $(SUBDIRS); do $(MAKE) -C $$I $@ || exit 1; done
 
 ifeq ($(OPSYS),$(findstring $(OPSYS),Linux Solaris))
 install:
+ifneq ($(TILO_ONLY),yes)
 	install -d -m755 $(DESTDIR)/etc $(DESTDIR)/sbin $(DESTDIR)/usr/sbin
 	install -m755 silo/silo $(DESTDIR)/sbin
 	install -m755 silo/silocheck $(DESTDIR)/usr/sbin
 	[ -f $(DESTDIR)/etc/silo.conf ] || \
 		install -m644 etc/silo.conf $(DESTDIR)/etc/
+endif
 ifeq ($(OPSYS),Linux)
-	install -d -m755 $(DESTDIR)/boot $(DESTDIR)/usr/bin
+ifneq ($(TILO_ONLY),yes)
+	install -d -m755 $(DESTDIR)/boot
 	install -m644 first/*.b second/*.b first-isofs/*.b $(DESTDIR)/boot/
+endif
+	install -d -m755 $(DESTDIR)/usr/bin
 	install -m755 tilo/maketilo $(DESTDIR)/usr/bin/
 	install -m755 tilo/tilo.sh $(DESTDIR)/usr/bin/tilo
 endif
-- 
2.24.1
