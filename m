From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:18 +0000
Subject: [PATCH 06/21] sparc: Merge asm-sparc{,64}/socket.h
Message-Id: <1212786033-4227-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc64/socket.h |   58 +-----------------------------------------
 1 files changed, 1 insertions(+), 57 deletions(-)

diff --git a/include/asm-sparc64/socket.h b/include/asm-sparc64/socket.h
index 5af688f..13e0d5d 100644
--- a/include/asm-sparc64/socket.h
+++ b/include/asm-sparc64/socket.h
@@ -1,57 +1 @@
-#ifndef _ASM_SOCKET_H
-#define _ASM_SOCKET_H
-
-#include <asm/sockios.h>
-
-/* For setsockopt(2) */
-#define SOL_SOCKET	0xffff
-
-#define SO_DEBUG	0x0001
-#define SO_PASSCRED	0x0002
-#define SO_REUSEADDR	0x0004
-#define SO_KEEPALIVE	0x0008
-#define SO_DONTROUTE	0x0010
-#define SO_BROADCAST	0x0020
-#define SO_PEERCRED	0x0040
-#define SO_LINGER	0x0080
-#define SO_OOBINLINE	0x0100
-/* To add :#define SO_REUSEPORT 0x0200 */
-#define SO_BSDCOMPAT    0x0400
-#define SO_RCVLOWAT     0x0800
-#define SO_SNDLOWAT     0x1000
-#define SO_RCVTIMEO     0x2000
-#define SO_SNDTIMEO     0x4000
-#define SO_ACCEPTCONN	0x8000
-
-#define SO_SNDBUF	0x1001
-#define SO_RCVBUF	0x1002
-#define SO_SNDBUFFORCE	0x100a
-#define SO_RCVBUFFORCE	0x100b
-#define SO_ERROR	0x1007
-#define SO_TYPE		0x1008
-
-/* Linux specific, keep the same. */
-#define SO_NO_CHECK	0x000b
-#define SO_PRIORITY	0x000c
-
-#define SO_BINDTODEVICE 0x000d
-
-#define SO_ATTACH_FILTER	0x001a
-#define SO_DETACH_FILTER        0x001b
-
-#define SO_PEERNAME		0x001c
-#define SO_TIMESTAMP		0x001d
-#define SCM_TIMESTAMP		SO_TIMESTAMP
-
-#define SO_PEERSEC		0x001e
-#define SO_PASSSEC		0x001f
-#define SO_TIMESTAMPNS		0x0021
-#define SCM_TIMESTAMPNS		SO_TIMESTAMPNS
-
-/* Security levels - as per NRL IPv6 - don't actually do anything */
-#define SO_SECURITY_AUTHENTICATION		0x5001
-#define SO_SECURITY_ENCRYPTION_TRANSPORT	0x5002
-#define SO_SECURITY_ENCRYPTION_NETWORK		0x5004
-
-#define SO_MARK			0x0022
-#endif /* _ASM_SOCKET_H */
+#include <asm-sparc/socket.h>
-- 
1.5.4.1.143.ge7e51

