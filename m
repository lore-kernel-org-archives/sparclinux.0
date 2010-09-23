From: matt mooney <mfm@muteddisk.com>
Date: Thu, 23 Sep 2010 06:51:26 +0000
Subject: [PATCH 15/20] sparc: change to new flag variable
Message-Id: <1285224686-29967-1-git-send-email-mfm@muteddisk.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Replace EXTRA_LDFLAGS with ldflags-y.

Signed-off-by: matt mooney <mfm@muteddisk.com>
---
 arch/sparc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 97e3feb..9a22b4a 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -21,7 +21,7 @@ quiet_cmd_btfix		= BTFIX   $@
 quiet_cmd_sysmap        = SYSMAP  $(obj)/System.map
       cmd_sysmap        = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
 quiet_cmd_image = LD      $@
-      cmd_image = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_$(@F)) -o $@
+      cmd_image = $(LD) $(LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F)) -o $@
 quiet_cmd_strip = STRIP   $@
       cmd_strip = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start $(obj)/image -o $@
 
-- 
1.7.2.1

