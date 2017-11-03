From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 03 Nov 2017 19:26:06 +0000
Subject: [PATCH] sparc64: Fix page table walk for PUD hugepages
Message-Id: <1509737200-103059-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Nitin Gupta <nitin.m.gupta@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Bob Picco <bob.picco@oracle.com>, Allen Pais <allen.pais@oracle.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

For a PUD hugepage entry, we need to propagate bits [32:22]
from virtual address to resolve at 4M granularity. However,
the current code was incorrectly propagating bits [29:19].
This bug can cause incorrect data to be returned for pages
backed with 16G hugepages.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Al Viro <viro@ZenIV.linux.org.uk>

diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index acf55063aa3d..ca0de1646f1e 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -216,7 +216,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	sllx		REG2, 32, REG2;			\
 	andcc		REG1, REG2, %g0;		\
 	be,pt		%xcc, 700f;			\
-	 sethi		%hi(0x1ffc0000), REG2;		\
+	 sethi		%hi(0xffe00000), REG2;		\
 	sllx		REG2, 1, REG2;			\
 	brgez,pn	REG1, FAIL_LABEL;		\
 	 andn		REG1, REG2, REG1;		\
-- 
2.13.1

