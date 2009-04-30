From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 23:58:50 +0000
Subject: [PATCH 1/4] sparc: use new macro for .data.cacheline_aligned section.
Message-Id: <1241135933-9913-2-git-send-email-tabbott@mit.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <1241135933-9913-1-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135933-9913-1-git-send-email-tabbott@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>

.data.cacheline_aligned should not need a separate output section;
this change moves it into the .data section.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/vmlinux.lds.S |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index fcbbd00..6587e03 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -52,6 +52,7 @@ SECTIONS
 
 	RO_DATA(PAGE_SIZE)
 	.data :	{
+		CACHELINE_ALIGNED_DATA(SMP_CACHE_BYTES)
 		DATA_DATA
 		CONSTRUCTORS
 	}
@@ -59,10 +60,6 @@ SECTIONS
 		*(.data1)
 	}
 	. = ALIGN(SMP_CACHE_BYTES);
-	.data.cacheline_aligned : {
-		*(.data.cacheline_aligned)
-	}
-	. = ALIGN(SMP_CACHE_BYTES);
 	.data.read_mostly : {
 		*(.data.read_mostly)
 	}
-- 
1.6.2.1

