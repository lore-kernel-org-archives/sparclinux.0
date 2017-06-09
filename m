From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 09 Jun 2017 19:48:07 +0000
Subject: [PATCH v2 2/2] include: warn for inconsistent endian config definition
Message-Id: <1497037687-107638-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497037687-107638-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1497037687-107638-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, geert@linux-m68k.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, viro@zeniv.linux.org.uk
Cc: mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

We have seen some generic code use config parameter CONFIG_CPU_BIG_ENDIAN
to decide the endianness.

Here are the few examples.
include/asm-generic/qrwlock.h
drivers/of/base.c
drivers/of/fdt.c
drivers/tty/serial/earlycon.c
drivers/tty/serial/serial_core.c

Display warning if CPU_BIG_ENDIAN is not defined on big endian
architecture and also warn if it defined on little endian architectures.

Here is our original discussion
https://lkml.org/lkml/2017/5/24/620

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/byteorder/big_endian.h    |    4 ++++
 include/linux/byteorder/little_endian.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/byteorder/big_endian.h b/include/linux/byteorder/big_endian.h
index 3920414..ffd2159 100644
--- a/include/linux/byteorder/big_endian.h
+++ b/include/linux/byteorder/big_endian.h
@@ -3,5 +3,9 @@
 
 #include <uapi/linux/byteorder/big_endian.h>
 
+#ifndef CONFIG_CPU_BIG_ENDIAN
+#warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
+#endif
+
 #include <linux/byteorder/generic.h>
 #endif /* _LINUX_BYTEORDER_BIG_ENDIAN_H */
diff --git a/include/linux/byteorder/little_endian.h b/include/linux/byteorder/little_endian.h
index 0805737..ba910bb 100644
--- a/include/linux/byteorder/little_endian.h
+++ b/include/linux/byteorder/little_endian.h
@@ -3,5 +3,9 @@
 
 #include <uapi/linux/byteorder/little_endian.h>
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#warning inconsistent configuration, CONFIG_CPU_BIG_ENDIAN is set
+#endif
+
 #include <linux/byteorder/generic.h>
 #endif /* _LINUX_BYTEORDER_LITTLE_ENDIAN_H */
-- 
1.7.1

