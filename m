From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Mar 2019 15:38:17 +0000
Subject: [PATCH] y2038: fix socket.h header inclusion
Message-Id: <20190311153857.563743-1-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, Laura Abbott <labbott@redhat.com>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

Referencing the __kernel_long_t type caused some user space applications
to stop compiling when they had not already included linux/posix_types.h,
e.g.

s/multicast.c -o ext/sockets/multicast.lo
In file included from /builddir/build/BUILD/php-7.3.3/main/php.h:468,
                 from /builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c:27:
/builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c: In function 'zm_startup_sockets':
/builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c:776:40: error: '__kernel_long_t' undeclared (first use in this function)
  776 |  REGISTER_LONG_CONSTANT("SO_SNDTIMEO", SO_SNDTIMEO, CONST_CS | CONST_PERSISTENT);

It is safe to include that header here, since it only contains kernel
internal types that do not conflict with other user space types.

It's still possible that some related build failures remain, but those
are likely to be for code that is not already y2038 safe.

Reported-by: Laura Abbott <labbott@redhat.com>
Fixes: a9beb86ae6e5 ("sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/uapi/asm/socket.h  | 2 +-
 arch/mips/include/uapi/asm/socket.h   | 2 +-
 arch/parisc/include/uapi/asm/socket.h | 2 +-
 arch/sparc/include/uapi/asm/socket.h  | 2 +-
 include/uapi/asm-generic/socket.h     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 0d0fddb7e738..976e89b116e5 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -2,8 +2,8 @@
 #ifndef _UAPI_ASM_SOCKET_H
 #define _UAPI_ASM_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 /*
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index eb9f33f8a8b3..d41765cfbc6e 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -10,8 +10,8 @@
 #ifndef _UAPI_ASM_SOCKET_H
 #define _UAPI_ASM_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /*
  * For setsockopt(2)
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 16e428f03526..66c5dd245ac7 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -2,8 +2,8 @@
 #ifndef _UAPI_ASM_SOCKET_H
 #define _UAPI_ASM_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	0xffff
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 88fe4f978aca..9265a9eece15 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -2,8 +2,8 @@
 #ifndef _ASM_SOCKET_H
 #define _ASM_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	0xffff
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index c8b430cb6dc4..8c1391c89171 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -2,8 +2,8 @@
 #ifndef __ASM_GENERIC_SOCKET_H
 #define __ASM_GENERIC_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	1
-- 
2.20.0
