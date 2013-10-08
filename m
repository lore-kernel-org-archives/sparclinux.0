From: Mark Salter <msalter@redhat.com>
Date: Tue, 08 Oct 2013 05:10:27 +0000
Subject: [PATCH v2 11/14] sparc: select ARCH_MAY_HAVE_PC_PARPORT
Message-Id: <1381209030-351-12-git-send-email-msalter@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1381209030-351-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1381209030-351-1-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Architectures which support CONFIG_PARPORT_PC should select
ARCH_MAY_HAVE_PC_PARPORT.

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
---
 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 78c4fdb..362229a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -12,6 +12,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_MAY_HAVE_PC_PARPORT if SPARC64 && PCI
 	select OF
 	select OF_PROMTREE
 	select HAVE_IDE
-- 
1.8.3.1

