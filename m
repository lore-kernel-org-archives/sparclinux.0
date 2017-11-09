From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 09 Nov 2017 06:16:51 +0000
Subject: [PATCH v2 1/2] sparc: use a common CHECKFLAGS entry for common flags
Message-Id: <20171109061652.14948-2-luc.vanoostenryck@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171109061652.14948-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20171109061652.14948-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

---
 arch/sparc/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 8496a074b..a42aa114e 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -14,12 +14,13 @@ else
         KBUILD_DEFCONFIG := sparc64_defconfig
 endif
 
+CHECKFLAGS     += -D__sparc__
+
 ifeq ($(CONFIG_SPARC32),y)
 #####
 # sparc32
 #
 
-CHECKFLAGS     += -D__sparc__
 LDFLAGS        := -m elf32_sparc
 export BITS    := 32
 UTS_MACHINE    := sparc
@@ -38,7 +39,7 @@ else
 # sparc64
 #
 
-CHECKFLAGS    += -D__sparc__ -D__sparc_v9__ -D__arch64__ -m64
+CHECKFLAGS    += -D__sparc_v9__ -D__arch64__ -m64
 LDFLAGS       := -m elf64_sparc
 export BITS   := 64
 UTS_MACHINE   := sparc64
-- 
2.14.0

