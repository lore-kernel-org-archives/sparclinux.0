From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Thu, 04 Jan 2007 14:21:37 +0000
Subject: [PATCH] Description fix in spec file
Message-Id: <11679204972841-git-send-email-vonbrand@inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 silo.spec |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/silo.spec b/silo.spec
index 2927ce8..2844110 100644
--- a/silo.spec
+++ b/silo.spec
@@ -1,7 +1,7 @@
 Summary: The SILO boot loader for SPARCs.
 Name: silo
 Version: 1.4.13
-Release: 1
+Release: 2
 Copyright: GPL
 ExclusiveArch: sparc
 Group: System Environment/Base
@@ -11,10 +11,13 @@ BuildRoot: /var/tmp/%{name}-root
 
 %description
 The silo package installs the SILO (Sparc Improved LOader) boot
-loader, which you'll need to boot Red Hat Linux on a SPARC.  SILO
+loader, which you'll need to boot Linux on a SPARC.  SILO
 installs onto your system's boot block and can be configured to boot
 Linux, Solaris and SunOS.
 
+The package also includes TILO (Trivial Image LOader), a tool for creating
+TFTP images.
+
 %prep 
 %setup -q -n silo-%{version}
 
@@ -48,6 +51,9 @@ rm -rf $RPM_BUILD_ROOT
 /usr/share/man/man8/silo.8*
  
 %changelog
+* Thu Jan 04 2007 Horst H. von Brand <vonbrand@inf.utfsm.cl> 1.4.13-2
+- Fix RPM description
+
 * Mon May 28 2001 Pieter Krul <pkrul@auxio.org>
 - Updated manpath and added tilo
 
-- 
1.5.0.rc0.gd222

