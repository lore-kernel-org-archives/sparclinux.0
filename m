From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 23 Jul 2019 11:31:49 +0000
Subject: [PATCH] sparc: remove unneeded uapi/asm/statfs.h
Message-Id: <20190723113149.14776-1-yamada.masahiro@socionext.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

statfs.h is listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/include/uapi/asm/statfs.h | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/statfs.h

diff --git a/arch/sparc/include/uapi/asm/statfs.h b/arch/sparc/include/uapi/asm/statfs.h
deleted file mode 100644
index 20c8f5bd340e..000000000000
--- a/arch/sparc/include/uapi/asm/statfs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef ___ASM_SPARC_STATFS_H
-#define ___ASM_SPARC_STATFS_H
-
-#include <asm-generic/statfs.h>
-
-#endif
-- 
2.17.1
