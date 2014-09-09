From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 09 Sep 2014 18:37:59 +0000
Subject: [PATCH 3/3 v2] sparc/uapi: Add definition of TIOC[SG]RS485
Message-Id: <1410287879-2368-1-git-send-email-ricardo.ribalda@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Commit: e676253b19b2d269cccf67fdb1592120a0cd0676 (serial/8250: Add
support for RS485 IOCTLs), adds support for RS485 ioctls for 825_core on
all the archs. Unfortunaltely the definition of TIOCSRS485 and
TIOCGRS485 was missing on the ioctls.h file

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
Changelog:

v2: By David Miller:

Follow the ioctl numbering scheme used by the particular
 architecture UAPI file you are editing.

 arch/sparc/include/uapi/asm/ioctls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 897d172..06b3f6c 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -24,6 +24,8 @@
 #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
+#define TIOCGRS485	_IOR('T', 0x41, struct serial_rs485)
+#define TIOCSRS485	_IOWR('T', 0x42, struct serial_rs485)
 
 /* Note that all the ioctls that are not available in Linux have a 
  * double underscore on the front to: a) avoid some programs to
-- 
2.1.0

