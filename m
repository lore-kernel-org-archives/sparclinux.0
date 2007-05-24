From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 May 2007 20:15:42 +0000
Subject: [PATCH/RFC 5/5] sparc64: use INITRAMFS in vmlinux.lds.h
Message-Id: <20070524201542.GG1109@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070524200440.GA1109@uranus.ravnborg.org>
In-Reply-To: <20070524200440.GA1109@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc64/kernel/vmlinux.lds.S |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/sparc64/kernel/vmlinux.lds.S b/arch/sparc64/kernel/vmlinux.lds.S
index 8559d07..2d6fb93 100644
--- a/arch/sparc64/kernel/vmlinux.lds.S
+++ b/arch/sparc64/kernel/vmlinux.lds.S
@@ -117,14 +117,7 @@ SECTIONS
 	}
 	__sun4v_2insn_patch_end = .;
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	. = ALIGN(PAGE_SIZE);
-	__initramfs_start = .;
-	.init.ramfs : {
-		*(.init.ramfs)
-	}
-	__initramfs_end = .;
-#endif
+	INITRAMFS(PAGE_SIZE)
 
 	. = ALIGN(PAGE_SIZE);
 	__per_cpu_start = .;
-- 
1.5.1.rc3.20.gaa453

