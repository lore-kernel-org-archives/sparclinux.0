From: Mark Salter <msalter@redhat.com>
Date: Sat, 14 Dec 2013 16:59:33 +0000
Subject: [PATCH 07/10] sparc: select ARCH_MIGHT_HAVE_PC_SERIO
Message-Id: <1387040376-26906-8-git-send-email-msalter@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1387040376-26906-1-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Architectures which might use an i8042 for serial IO to keyboard,
mouse, etc should select ARCH_MIGHT_HAVE_PC_SERIO.

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
---
 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index d4f7a6a..034a680 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,6 +13,7 @@ config SPARC
 	bool
 	default y
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select OF
 	select OF_PROMTREE
 	select HAVE_IDE
-- 
1.8.3.1

