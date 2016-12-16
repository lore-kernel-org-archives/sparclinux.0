From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 16 Dec 2016 18:35:24 +0000
Subject: [RFC PATCH 01/14] sparc64: placeholder for needed mmu shared context patching
Message-Id: <1481913337-9331-2-git-send-email-mike.kravetz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Bob Picco <bob.picco@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Julian Calaby <julian.calaby@gmail.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>

MMU shared context patching will be supported on Sun4V platforms with
Niagara 2 or later processors.  There will be a need for kernel patching
based on this criteria.  This 'patch' simply adds a comment as a reminder
and placeholder to add that support.

For now, MMU shared context support will be determined at follows:
- sun4v patching will be used for shared context support.  This is too
  general as most but not all sun4v platforms contain the required
  processors.
- A new config option (CONFIG_SHARED_MMU_CTX) is added

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/sparc/kernel/setup_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 6b7331d..ffda69b 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -276,6 +276,17 @@ void sun_m7_patch_2insn_range(struct sun4v_2insn_patch_entry *start,
 	}
 }
 
+/*
+ * FIXME - TODO
+ *
+ * Shared MMU context support will only be provided on sun4v platforms
+ * with Niagara 2 or later processors.  A patching mechanism for this
+ * this type of support will need to be implemented.  For now, the code
+ * is making the too general assumption of supporting shared context on
+ * all sun4v platforms.  This is a placeholder to add correct support
+ * at a later time.
+ */
+
 static void __init sun4v_patch(void)
 {
 	extern void sun4v_hvapi_init(void);
-- 
2.7.4

