From: Frans Pop <elendil@planet.nl>
Date: Thu, 23 Jul 2009 18:55:18 +0000
Subject: [PATCH] sparc64: list zImage build target in 'make help' output
Message-Id: <200907232055.19176.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <200907162041.53181.elendil@planet.nl>
In-Reply-To: <200907162041.53181.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Jurij Smakov <jurij@wooyd.org>, David Miller <davem@davemloft.net>

The zImage target was added and gets built by default.

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Jurij Smakov <jurij@wooyd.org>
---

While looking at Sam Ravnborg's comments I noticed that the following
should be added on top of Jurij's patch.

David: if you prefer to merge this into the previous patch, that'd be
fine by me.

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 2adc5ea..b588880 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -112,8 +112,9 @@ define archhelp
 endef
 else
 define archhelp
-  echo  '* vmlinux       - Standard sparc64 kernel'
-  echo  '  vmlinux.aout  - a.out kernel for sparc64'
+  echo  '* vmlinux      - standard sparc64 kernel'
+  echo  '* zImage       - stripped and compressed sparc64 kernel ($(boot)/zImage)'
+  echo  '  vmlinux.aout - a.out kernel for sparc64'
   echo  '  tftpboot.img - image prepared for tftp'
 endef
 endif
