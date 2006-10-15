From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 15 Oct 2006 20:05:47 +0000
Subject: sparc32 modpost warnings from init()
Message-Id: <20061015200547.GA4729@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am left with the warnings below in the sparc build of 2.6.19-rc2. They
all originate from init() (init/main.c). This function should definitely
remain in .text and it is fine it calls to .init.text functions.

The patch below against modpost makes it ignore this function, but I am
not sure:
- if this is the correct solution
- if this code should be sparc-specific
Any input on how to get rid of these warnings is welcome.

WARNING: vmlinux - Section mismatch: reference to .init.text:spawn_ksoftirqd from .text between 'init' (at offset 0xc07c) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:spawn_softlockup_task from .text between 'init' (at offset 0xc084) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:sched_init_smp from .text between 'init' (at offset 0xc08c) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:populate_rootfs from .text between 'init' (at offset 0xc094) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:usermodehelper_init from .text between 'init' (at offset 0xc0a4) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:driver_init from .text between 'init' (at offset 0xc0ac) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:sysctl_init from .text between 'init' (at offset 0xc0b4) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc0d4) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc0d8) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc114) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc194) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:prepare_namespace from .text between 'init' (at offset 0xc2e0) and 'try_name'

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: 2.6.19-rc2/scripts/mod/modpost.c
=================================--- 2.6.19-rc2.orig/scripts/mod/modpost.c	2006-10-14 01:15:27.000000000 +0100
+++ 2.6.19-rc2/scripts/mod/modpost.c	2006-10-15 20:43:55.000000000 +0100
@@ -629,6 +629,11 @@
 		    (strcmp(tosec, ".init.text") = 0))
 		return 1;
 	}
+
+	/* Whitelist all references from init() */
+	if (strncmp(atsym, "init", strlen("init")) = 0)
+		return 1;
+
 	return 0;
 }
 
