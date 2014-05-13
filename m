From: Ley Foon Tan <lftan@altera.com>
Date: Tue, 13 May 2014 09:06:37 +0000
Subject: [PATCH 22/25] sparc: Add 32 bit time_t and clock_t
Message-Id: <1399971997-4781-1-git-send-email-lftan@altera.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/sparc/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/posix_types.h b/arch/sparc/include/uapi/asm/posix_types.h
index 156220e..c5eaaef 100644
--- a/arch/sparc/include/uapi/asm/posix_types.h
+++ b/arch/sparc/include/uapi/asm/posix_types.h
@@ -42,6 +42,12 @@ typedef long                   __kernel_daddr_t;
 typedef unsigned short	       __kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #endif /* defined(__sparc__) && defined(__arch64__) */
 
 #include <asm-generic/posix_types.h>
-- 
1.8.2.1

