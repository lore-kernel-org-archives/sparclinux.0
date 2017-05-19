From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 19 May 2017 00:36:05 +0000
Subject: [PATCH 1/6] kernel/locking: Fix compile error with qrwlock.c
Message-Id: <1495154170-854693-2-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Seeing this error on SPARC while compiling qrwlock.c.

  CC      kernel/locking/qrwlock.o
In file included from ./include/asm-generic/qrwlock_types.h:5,
                 from ./arch/sparc/include/asm/qrwlock.h:4,
                 from kernel/locking/qrwlock.c:24:
./arch/sparc/include/asm/spinlock_types.h:5:3: error:
        #error "please don't include this file directly"

Re-arrange the includes in qrwlock_types.h and also include spinlock.h
in qrwlock.c to fix it. This should also help other architectures when
queued rwlock is enabled.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 include/asm-generic/qrwlock_types.h |    6 +++---
 kernel/locking/qrwlock.c            |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwl=
ock_types.h
index 0abc6b6..3988c7d 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -1,9 +1,6 @@
 #ifndef __ASM_GENERIC_QRWLOCK_TYPES_H
 #define __ASM_GENERIC_QRWLOCK_TYPES_H
=20
-#include <linux/types.h>
-#include <asm/spinlock_types.h>
-
 /*
  * The queue read/write lock data structure
  */
@@ -18,4 +15,7 @@
 	.wait_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,	\
 }
=20
+#include <linux/types.h>
+#include <linux/spinlock_types.h>
+
 #endif /* __ASM_GENERIC_QRWLOCK_TYPES_H */
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index cc3ed0c..2655f26 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <linux/spinlock.h>
 #include <asm/qrwlock.h>
=20
 /*
--=20
1.7.1

