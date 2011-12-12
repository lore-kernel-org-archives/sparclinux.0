From: David Howells <dhowells@redhat.com>
Date: Mon, 12 Dec 2011 15:28:18 +0000
Subject: [PATCH 02/17] UAPI: Don't include linux/compat.h in sparc's asm/siginfo.h
Message-Id: <1323703713-20382-3-git-send-email-dhowells@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Don't include linux/compat.h in sparc's asm/siginfo.h as it leads to a circular
dependency:

	asm/siginfo.h -> linux/compat.h -> asm/siginfo.h

Signed-off-by: David Howells <dhowells@redhat.com>
cc: David S. Miller <davem@davemloft.net>
cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/siginfo.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/siginfo.h b/arch/sparc/include/asm/siginfo.h
index 988e5d8..215900f 100644
--- a/arch/sparc/include/asm/siginfo.h
+++ b/arch/sparc/include/asm/siginfo.h
@@ -16,8 +16,6 @@
 
 #ifdef __KERNEL__
 
-#include <linux/compat.h>
-
 #ifdef CONFIG_COMPAT
 
 struct compat_siginfo;
-- 
1.7.7.4

