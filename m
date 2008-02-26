From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Tue, 26 Feb 2008 16:32:59 +0000
Subject: [PATCH 3/3] Fold changes from Aurora into spec
Message-Id: <1204043579-5056-4-git-send-email-vonbrand@inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Changes from 1.4.13-4 to 1.4.13-6 in Aurora Linux are included in this
specfile. The relevant changelog entries are marked (aurora)

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 silo.spec |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/silo.spec b/silo.spec
index caa7676..0cd1116 100644
--- a/silo.spec
+++ b/silo.spec
@@ -1,15 +1,15 @@
 Summary: A boot loader for SPARCs
 Name: silo
 Version: 1.4.13
-Release: 4%{?dist}
-License: GPL
+Release: 7%{?dist}
+License: GPLv2+
 ExclusiveArch: sparc
 Group: System Environment/Base
 URL: http://www.sparc-boot.org
-Source: http://www.sparc-boot.org/pub/silo/silo-%{version}.tar.gz
+Source: http://www.sparc-boot.org/pub/silo/silo-%{version}.tar.bz2
 
-BuildRoot: %{_tmppath}/%{name}-%{version}-root
-BuildPrereq: elftoaout, sed
+BuildRoot:  %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
+BuildRequires: elftoaout, e2fsprogs-devel, sed
 
 %description
 The silo package installs the SILO (Sparc Improved LOader) boot
@@ -24,7 +24,7 @@ TFTP images.
 %setup -q -n silo-%{version}
 
 %build
-make
+make %{?_smp_mflags}
 
 %install
 rm -rf $RPM_BUILD_ROOT
@@ -48,13 +48,25 @@ rm -rf $RPM_BUILD_ROOT
 /boot/silotftp.b
 /boot/second.b
 /boot/generic.b
-/usr/sbin/silocheck
-/usr/share/man/man1/tilo.1*
-/usr/share/man/man1/maketilo.1*
-/usr/share/man/man5/silo.conf.5*
-/usr/share/man/man8/silo.8*
+%{_sbindir}/silocheck
+%{_mandir}/man1/tilo.1*
+%{_mandir}/man1/maketilo.1*
+%{_mandir}/man5/silo.conf.5*
+%{_mandir}/man8/silo.8*
  
 %changelog
+* Mon Feb 25 2008 Horst H. von Brand <vonbrand@inf.utfsm.cl> 1.4.13-7
+- Incorporate changes from Aurora (1.4.13-3 to 1.4.13-6)
+
+* Fri Aug 24 2007 Dennis Gilmore <dennis@ausil.us> 1.4.13-5 (aurora)
+- use %%{?_smp_mflags}
+
+* Thu Aug 16 2007 Dennis Gilmore <dennis@ausil.us> 1.4.13-4 (aurora)
+- use macros in %%files section
+
+* Wed Aug 15 2007 Dennis Gilmore <dennis@ausil.us> 1.4.13-3 (aurora)
+- Fix buildroot
+
 * Tue Jun  5 2007 Horst H. von Brand <vonbrand@inf.utfsm.cl> 1.4.13-4
 - Copyright tag should be License, add URL tag
 - Add %%{?dist} to release
@@ -130,7 +142,7 @@ rm -rf $RPM_BUILD_ROOT
 - fix bug on traversing non-absolute symlinks
 
 * Tue Sep 28 1999 Jakub Jelinek <jakub@redhat.com>
-- don't install silo in %post.
+- don't install silo in %%post.
 
 * Thu Sep 23 1999 Jakub Jelinek <jakub@redhat.com>
 - actually install the new man page.
-- 
1.5.4.3.220.g99d8e

