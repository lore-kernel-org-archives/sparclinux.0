From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 16 Dec 2016 18:35:37 +0000
Subject: [RFC PATCH 14/14] sparc64: add SHARED_MMU_CTX Kconfig option
Message-Id: <1481913337-9331-15-git-send-email-mike.kravetz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Bob Picco <bob.picco@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Julian Calaby <julian.calaby@gmail.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>

Depends on SPARC64 && HUGETLB_PAGE

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/sparc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 165ecdd..f39dcdf 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -155,6 +155,9 @@ config PGTABLE_LEVELS
 	default 4 if 64BIT
 	default 3
 
+config SHARED_MMU_CTX
+	def_bool y if SPARC64 && HUGETLB_PAGE
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
2.7.4

