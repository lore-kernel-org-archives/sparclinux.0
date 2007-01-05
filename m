From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Fri, 05 Jan 2007 15:14:18 +0000
Subject: [PATCH] Further specfile fixes
Message-Id: <11680100582469-git-send-email-vonbrand@inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 silo.spec |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/silo.spec b/silo.spec
index 2844110..85f7e9f 100644
--- a/silo.spec
+++ b/silo.spec
@@ -1,13 +1,14 @@
-Summary: The SILO boot loader for SPARCs.
+Summary: A boot loader for SPARCs
 Name: silo
 Version: 1.4.13
-Release: 2
+Release: 3
 Copyright: GPL
 ExclusiveArch: sparc
 Group: System Environment/Base
 Source: http://www.sparc-boot.org/pub/silo/silo-%{version}.tar.gz
 
-BuildRoot: /var/tmp/%{name}-root
+BuildRoot: %{_tmppath}/%{name}-%{version}-root
+BuildPrereq: elftoaout, sed
 
 %description
 The silo package installs the SILO (Sparc Improved LOader) boot
@@ -32,8 +33,8 @@ make install DESTDIR=$RPM_BUILD_ROOT
 rm -rf $RPM_BUILD_ROOT
 
 %files
-%defattr(-,root,root)
-%doc docs COPYING ChangeLog
+%defattr(-,root,root,-)
+%doc docs COPYING
 /sbin/silo
 /usr/bin/tilo
 /usr/bin/maketilo
@@ -51,6 +52,11 @@ rm -rf $RPM_BUILD_ROOT
 /usr/share/man/man8/silo.8*
  
 %changelog
+* Fri Jan 05 2007 Horst H. von Brand <vonbrand@inf.utfsm.cl> 1.4.13-3
+- Bring spec into line with Fedora's "Developer's Guide"
+- Add BuildPrereq (if nothing else, it is useful documentation)
+- ChangeLog is no more
+
 * Thu Jan 04 2007 Horst H. von Brand <vonbrand@inf.utfsm.cl> 1.4.13-2
 - Fix RPM description
 
-- 
1.5.0.rc0.g244a7

