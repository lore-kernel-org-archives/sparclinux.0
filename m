From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 04 Jun 2019 08:23:14 +0000
Subject: [PATCH] sparc: fix unknown type name u_int in uapi header
Message-Id: <20190604082314.25939-1-yamada.masahiro@socionext.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

'u_int' is a shorthand that is only available in the kernel space
because it is defined in include/linux/types.h, which is not exported
to the user space.

You cannot use it in uapi headers even if you include <linux/types.h>

Detected by compile-testing exported headers.

./usr/include/asm/openpromio.h:16:2: error: unknown type name ‘u_int’
  u_int oprom_size;  /* Actual size of the oprom_array. */
  ^~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/include/uapi/asm/openpromio.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/openpromio.h b/arch/sparc/include/uapi/asm/openpromio.h
index 8817f7d1a70c..d4494b679e99 100644
--- a/arch/sparc/include/uapi/asm/openpromio.h
+++ b/arch/sparc/include/uapi/asm/openpromio.h
@@ -4,7 +4,6 @@
 
 #include <linux/compiler.h>
 #include <linux/ioctl.h>
-#include <linux/types.h>
 
 /*
  * SunOS and Solaris /dev/openprom definitions. The ioctl values
@@ -13,7 +12,7 @@
 
 struct openpromio
 {
-	u_int	oprom_size;		/* Actual size of the oprom_array. */
+	unsigned int oprom_size;	/* Actual size of the oprom_array. */
 	char	oprom_array[1];		/* Holds property names and values. */
 };
 
-- 
2.17.1
