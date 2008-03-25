From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Tue, 25 Mar 2008 21:24:32 +0000
Subject: [PATCH 6/6] Fix specfile to match latest changes
Message-Id: <1206480273-29043-7-git-send-email-vonbrand@inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 silo.spec |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/silo.spec b/silo.spec
index 0cd1116..1ba968e 100644
--- a/silo.spec
+++ b/silo.spec
@@ -1,7 +1,7 @@
 Summary: A boot loader for SPARCs
 Name: silo
 Version: 1.4.13
-Release: 7%{?dist}
+Release: 9%{?dist}
 License: GPLv2+
 ExclusiveArch: sparc
 Group: System Environment/Base
@@ -55,6 +55,9 @@ rm -rf $RPM_BUILD_ROOT
 %{_mandir}/man8/silo.8*
  
 %changelog
+* Mon Mar 24 2008 Horst H. von Brand <vonbrand@inf.utfsm.cl> 1.4.13-9
+- Incorporate changes from Aurora (1.4.13-7 to 1.4.13-8)
+
 * Mon Feb 25 2008 Horst H. von Brand <vonbrand@inf.utfsm.cl> 1.4.13-7
 - Incorporate changes from Aurora (1.4.13-3 to 1.4.13-6)
 
-- 
1.5.5.rc0.16.g02b00

