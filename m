From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 23:58:52 +0000
Subject: [PATCH 3/4] sparc: use new macro for .data.read_mostly section.
Message-Id: <1241135933-9913-4-git-send-email-tabbott@mit.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <1241135933-9913-1-git-send-email-tabbott@mit.edu>
 <1241135933-9913-2-git-send-email-tabbott@mit.edu>
 <1241135933-9913-3-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135933-9913-3-git-send-email-tabbott@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>

.data.read_mostly should not need a separate output section; this
change moves it into the .data section.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/vmlinux.lds.S |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 3fbf650..4760796 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -54,16 +54,13 @@ SECTIONS
 	.data :	{
 		INIT_TASK_DATA(THREAD_SIZE)
 		CACHELINE_ALIGNED_DATA(SMP_CACHE_BYTES)
+		READ_MOSTLY_DATA(SMP_CACHE_BYTES)
 		DATA_DATA
 		CONSTRUCTORS
 	}
 	.data1 : {
 		*(.data1)
 	}
-	. = ALIGN(SMP_CACHE_BYTES);
-	.data.read_mostly : {
-		*(.data.read_mostly)
-	}
 	/* End of data section */
 	_edata = .;
 
-- 
1.6.2.1

