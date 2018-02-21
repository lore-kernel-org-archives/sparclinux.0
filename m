From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 17:15:51 +0000
Subject: [PATCH v12 09/11] mm: Allow arch code to override copy_highpage()
Message-Id: <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, anthony.yznaga@oracle.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

Some architectures can support metadata for memory pages and when a
page is copied, its metadata must also be copied. Sparc processors
from M7 onwards support metadata for memory pages. This metadata
provides tag based protection for access to memory pages. To maintain
this protection, the tag data must be copied to the new page when a
page is migrated across NUMA nodes. This patch allows arch specific
code to override default copy_highpage() and copy metadata along
with page data upon migration.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v9:
	- new patch

 include/linux/highmem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 776f90f3a1cd..0690679832d4 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -237,6 +237,8 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 
 #endif
 
+#ifndef __HAVE_ARCH_COPY_HIGHPAGE
+
 static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
@@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
 	kunmap_atomic(vfrom);
 }
 
+#endif
+
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.11.0

