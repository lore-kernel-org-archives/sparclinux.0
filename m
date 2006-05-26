From: "H. Peter Anvin" <hpa@zytor.com>
Date: Fri, 26 May 2006 05:38:20 +0000
Subject: Re: Patch committed to the klibc repository: sparc32-specific option
Message-Id: <e5648c$7v0$1@terminus.zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <447544D9.3080702@zytor.com>
In-Reply-To: <447544D9.3080702@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Followup to:  <447544D9.3080702@zytor.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.sparclinux
> 
> I just committed this patch to the klibc repository.  Posting here as an 
> FYI and for review.
> 

This is the equivalent for sparc32.  Also committed to the klibc repository.

[klibc] sparc32: transfer arch-specific options to /arch.cmd

Boot options which have been obtained in an architecture-specific
fashion have to be copied to /arch.cmd in the rootfs.  This implements
that functionality for sparc32; the code is identical to sparc64 minus
the openprom support for obtaining nfsroot options.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit a998ece20df2928c3bb197bbb9a96ca575d94861
tree 9a85a44945872c18c43031b2d0289111137d252f
parent dd851ddaac9ce9e634c1a062bae13033ccb6fc9f
author H. Peter Anvin <hpa@zytor.com> Thu, 25 May 2006 22:34:47 -0700
committer H. Peter Anvin <hpa@zytor.com> Thu, 25 May 2006 22:34:47 -0700

 arch/sparc/kernel/setup.c |   47 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index 3509e43..ae8f283 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -240,8 +240,6 @@ extern unsigned short ram_flags;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-extern int root_mountflags;
-
 char reboot_command[COMMAND_LINE_SIZE];
 enum sparc_cpu sparc_cpu_model;
 
@@ -328,14 +326,7 @@ void __init setup_arch(char **cmdline_p)
 	}
 	pfn_base = phys_base >> PAGE_SHIFT;
 
-	if (!root_flags)
-		root_mountflags &= ~MS_RDONLY;
 	ROOT_DEV = old_decode_dev(root_dev);
-#ifdef CONFIG_BLK_DEV_INITRD
-	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
-#endif
 
 	prom_setsync(prom_sync_me);
 
@@ -386,6 +377,44 @@ static int __init set_preferred_console(
 }
 console_initcall(set_preferred_console);
 
+/*
+ * Platform-specific configuration commands which don't come from
+ * the actual kernel command line.  Write them into a file in rootfs
+ * so kinit can pick them up.
+ */
+static int __init set_arch_init_commands(void)
+{
+	int fd = sys_open("/arch.cmd", O_WRONLY|O_CREAT|O_APPEND, 0666);
+	char buffer[256];
+	int len = 0;
+
+	if (fd < 0)
+		return fd;
+
+	buffer[0] = 'r';
+	buffer[1] = root_flags ? 'o' : 'w';
+	buffer[2] = '\n';
+	len = 3;
+
+#ifdef CONFIG_BLK_DEV_RAM
+	len += min((int)(sizeof buffer - 1 - len),
+		   snprintf(buffer+len, sizeof buffer - len,
+			    "ramdisk_start=%u\n"
+			    "prompt_ramdisk=%d\n"
+			    "load_ramdisk=%d\n",
+			    ram_flags & RAMDISK_IMAGE_START_MASK,
+			    !!(ram_flags & RAMDISK_PROMPT_FLAG),
+			    !!(ram_flags & RAMDISK_LOAD_FLAG)));
+#endif
+
+	sys_write(fd, buffer, len);
+	sys_close(fd);
+
+	return 0;
+}
+
+late_initcall(set_arch_init_commands);
+
 extern char *sparc_cpu_type;
 extern char *sparc_fpu_type;
