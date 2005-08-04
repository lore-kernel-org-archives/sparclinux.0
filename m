From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Date: Thu, 04 Aug 2005 13:48:03 +0000
Subject: [PATCH] Remove errno declaration in drivers/sbus/char/envctrl.c
Message-Id: <20050804134803.GA32109@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

errno is already declarded in linux/errno.h:

drivers/sbus/char/envctrl.c:40: error: static declaration of 'errno' follows non-static declaration
include/linux/unistd.h:4: error: previous declaration of 'errno' was here
make[3]: *** [drivers/sbus/char/envctrl.o] Error 1
make[2]: *** [drivers/sbus/char] Error 2
make[1]: *** [drivers/sbus] Error 2
make: *** [drivers] Error 2


Moreover errno isn't used in this file at all so the following patch
(against latest git tree) just removes it (kernel compiles fine).

Signed-off-by: Mathieu Chouquet-Stringer <mchouque@free.fr>

--- linux-2.6/drivers/sbus/char/envctrl.c	2005-07-25 20:28:43.000000000 -0400
+++ linux-2.6-mat/drivers/sbus/char/envctrl.c	2005-08-04 09:13:48.000000000 -0400
@@ -37,7 +37,6 @@
 #include <asm/uaccess.h>
 #include <asm/envctrl.h>
 
-static int errno;
 #include <asm/unistd.h>
 
 #define ENVCTRL_MINOR	162
