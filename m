From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 May 2007 20:14:44 +0000
Subject: [PATCH/RFC 4/5] asm-generic: add INITRAMFS to vmlinux.lds.h
Message-Id: <20070524201444.GF1109@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070524200440.GA1109@uranus.ravnborg.org>
In-Reply-To: <20070524200440.GA1109@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Add the definition of initramfs to vmlinux.lds.h
This simplifies arch lds script a bit.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Is these 8 lines really worth it.
I think yes - but no less than this.

	Sam


 include/asm-generic/vmlinux.lds.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5388c41..0e3d2eb 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -140,6 +140,19 @@
 /* for backward compatibility */
 #define RODATA RO_DATA(4096)
 
+/* INITRAMFS is used to hold the filesystem used during early boot. */
+#ifdef CONFIG_BLK_DEV_INITRD
+#define INITRAMFS(align)						\
+	. = ALIGN((align));						\
+	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {		\
+	VMLINUX_SYMBOL(__initramfs_start) = .;				\
+		*(.init.ramfs)						\
+	VMLINUX_SYMBOL(__initramfs_end) = .;				\
+	}
+#else
+#define INITRAMFS(align)
+#endif
+
 #define SECURITY_INIT							\
 	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__security_initcall_start) = .;		\
-- 
1.5.1.rc3.20.gaa453

