From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 09 Nov 2017 06:16:52 +0000
Subject: [PATCH v2 2/2] sparc: pass endianness info to sparse
Message-Id: <20171109061652.14948-3-luc.vanoostenryck@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171109061652.14948-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20171109061652.14948-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

sparc is big-endian only but sparse assumes the same endianness
as the building machine.
This is problematic for code which expect __BYTE_ORDER__ being
correctly predefined by the compiler which sparse can then
pre-process differently from what gcc would, depending on the
building machine endianness.

Fix this by letting sparse know about the architecture endianness.

To: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/sparc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index a42aa114e..08d477faf 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -14,7 +14,7 @@ else
         KBUILD_DEFCONFIG := sparc64_defconfig
 endif
 
-CHECKFLAGS     += -D__sparc__
+CHECKFLAGS     += -D__sparc__ -mbig-endian
 
 ifeq ($(CONFIG_SPARC32),y)
 #####
-- 
2.14.0

