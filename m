From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 22 Jan 2017 16:32:35 +0000
Subject: [PATCH 11/20] sparc: migrate exception table users onto extable.h
Message-Id: <20170122163244.11740-12-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

This file was using module.h for search_exception_table.  We've
now separated that content out into its own file "extable.h" so
now move over to that.  Unlike most other instances, we can't
delete the module.h include here since the file needs that for
the within_module_init definition.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sparc/mm/extable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/extable.c b/arch/sparc/mm/extable.c
index 768a11e6bd4f..db214e9931d9 100644
--- a/arch/sparc/mm/extable.c
+++ b/arch/sparc/mm/extable.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 void sort_extable(struct exception_table_entry *start,
-- 
2.11.0

