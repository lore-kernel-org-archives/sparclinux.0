From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 06:25:19 +0000
Subject: [PATCH 2.6] Fix mxcc warning
Message-Id: <1109917519.17038.87.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-2s/dddLs24T+jv59DQFH"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-2s/dddLs24T+jv59DQFH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Peter Jones uncovered this one while we were debugging the framebuffer
issues. There are some references to -1 in the mxcc asm code, which
should be 0xffffffff.

This patch gets rid of the -1s.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-2s/dddLs24T+jv59DQFH
Content-Disposition: attachment; filename=linux-2.6.11-sparc-mxccwarning.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-mxccwarning.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/include/asm-sparc/mxcc.h.BAD	2005-03-04 01:19:11.326652955 -0500
+++ linux-2.6.11/include/asm-sparc/mxcc.h	2005-03-04 01:19:33.092344067 -0500
@@ -115,8 +115,8 @@ extern __inline__ unsigned long mxcc_get
 {
 	unsigned long mxcc_control;
 
-	__asm__ __volatile__("set -1, %%g2\n\t"
-			     "set -1, %%g3\n\t"
+	__asm__ __volatile__("set 0xffffffff, %%g2\n\t"
+			     "set 0xffffffff, %%g3\n\t"
 			     "stda %%g2, [%1] %2\n\t"
 			     "lda [%3] %2, %0\n\t" :
 			     "=r" (mxcc_control) :

--=-2s/dddLs24T+jv59DQFH--

