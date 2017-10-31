From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 31 Oct 2017 17:22:10 +0000
Subject: [PATCH] sparc: pass endianness info to sparse
Message-Id: <20171031172210.9990-1-luc.vanoostenryck@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

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
 arch/sparc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 8496a074b..ef1598f5a 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -55,6 +55,8 @@ endif
 
 endif
 
+CHECKFLAGS     += -mbig-endian
+
 head-y                 := arch/sparc/kernel/head_$(BITS).o
 
 # See arch/sparc/Kbuild for the core part of the kernel
-- 
2.14.0

