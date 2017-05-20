From: Babu Moger <babu.moger@oracle.com>
Date: Sat, 20 May 2017 00:16:56 +0000
Subject: [PATCH v2 2/7] arch/sparc: Remove the check #ifndef __LINUX_SPINLOCK_TYPES_H
Message-Id: <1495239421-441642-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Remove the un-necessary "ifndef __LINUX_SPINLOCK_TYPES_H" stanza from SPARC.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Suggested-by: David Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/spinlock_types.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/spinlock_types.h b/arch/sparc/include/asm/spinlock_types.h
index 9c454fd..019c085 100644
--- a/arch/sparc/include/asm/spinlock_types.h
+++ b/arch/sparc/include/asm/spinlock_types.h
@@ -1,10 +1,6 @@
 #ifndef __SPARC_SPINLOCK_TYPES_H
 #define __SPARC_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
-# error "please don't include this file directly"
-#endif
-
 typedef struct {
 	volatile unsigned char lock;
 } arch_spinlock_t;
-- 
1.7.1

