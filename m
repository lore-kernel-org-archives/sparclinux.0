From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 06 Oct 2017 16:54:52 +0000
Subject: [PATCH v3 4/5] sparc64: SPARC optimised __fls function
Message-Id: <1507308893-9218-5-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com, sam@ravnborg.org

Defined SPARC optimised __fls using lzcnt opcode.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/lib/NG4fls.S |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/lib/NG4fls.S b/arch/sparc/lib/NG4fls.S
index 5ed7da9..34ad371 100644
--- a/arch/sparc/lib/NG4fls.S
+++ b/arch/sparc/lib/NG4fls.S
@@ -18,3 +18,13 @@ ENTRY(NG4fls)
 	retl
 	 sub	%g3, %g2, %o0
 ENDPROC(NG4fls)
+
+ENTRY(__NG4fls)
+	brz,pn	%o0, 1f
+	LXCNT_O0_G2	!lzcnt	%o0, %g2
+	mov	63, %g3
+	sub	%g3, %g2, %o0
+1:
+	retl
+	 nop
+ENDPROC(__NG4fls)
-- 
1.7.1

