From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 01 Jun 2008 07:22:10 +0000
Subject: [PATCH] [SPARC] Merge include/asm-sparc{,64}/openpromio.h
Message-Id: <20080601072210.GA17134@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 32ca8676ae33adf0633a0917dc3334b95b802b73 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 1 Jun 2008 08:29:17 +0200
Subject: [PATCH] [SPARC] Merge include/asm-sparc{,64}/openpromio.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc64/openpromio.h |   70 +-------------------------------------
 1 files changed, 1 insertions(+), 69 deletions(-)

diff --git a/include/asm-sparc64/openpromio.h b/include/asm-sparc64/openpromio.h
index 847ce23..122fabd 100644
--- a/include/asm-sparc64/openpromio.h
+++ b/include/asm-sparc64/openpromio.h
@@ -1,69 +1 @@
-#ifndef	_SPARC64_OPENPROMIO_H
-#define	_SPARC64_OPENPROMIO_H
-
-#include <linux/compiler.h>
-#include <linux/ioctl.h>
-#include <linux/types.h>
-
-/*
- * SunOS and Solaris /dev/openprom definitions. The ioctl values
- * were chosen to be exactly equal to the SunOS equivalents.
- */
-
-struct openpromio
-{
-	u_int	oprom_size;		/* Actual size of the oprom_array. */
-	char	oprom_array[1];		/* Holds property names and values. */
-};
-
-#define	OPROMMAXPARAM	4096		/* Maximum size of oprom_array. */
-
-#define	OPROMGETOPT		0x20004F01
-#define	OPROMSETOPT		0x20004F02
-#define	OPROMNXTOPT		0x20004F03
-#define	OPROMSETOPT2		0x20004F04
-#define	OPROMNEXT		0x20004F05
-#define	OPROMCHILD		0x20004F06
-#define	OPROMGETPROP		0x20004F07
-#define	OPROMNXTPROP		0x20004F08
-#define	OPROMU2P		0x20004F09
-#define	OPROMGETCONS		0x20004F0A
-#define	OPROMGETFBNAME		0x20004F0B
-#define	OPROMGETBOOTARGS	0x20004F0C
-/* Linux extensions */				/* Arguments in oprom_array: */
-#define OPROMSETCUR		0x20004FF0	/* int node - Sets current node */
-#define OPROMPCI2NODE		0x20004FF1	/* int pci_bus, pci_devfn - Sets current node to PCI device's node */
-#define OPROMPATH2NODE		0x20004FF2	/* char path[] - Set current node from fully qualified PROM path */
-
-/*
- * Return values from OPROMGETCONS:
- */
-
-#define OPROMCONS_NOT_WSCONS    0
-#define OPROMCONS_STDIN_IS_KBD  0x1     /* stdin device is kbd */
-#define OPROMCONS_STDOUT_IS_FB  0x2     /* stdout is a framebuffer */
-#define OPROMCONS_OPENPROM      0x4     /* supports openboot */
-
-
-/*
- *  NetBSD/OpenBSD /dev/openprom definitions.
- */
-
-struct opiocdesc
-{
-	int	op_nodeid;		/* PROM Node ID (value-result) */
-	int	op_namelen;		/* Length of op_name. */
-	char	__user *op_name;	/* Pointer to the property name. */
-	int	op_buflen;		/* Length of op_buf (value-result) */
-	char	__user *op_buf;		/* Pointer to buffer. */
-};
-
-#define	OPIOCGET	_IOWR('O', 1, struct opiocdesc)
-#define	OPIOCSET	_IOW('O', 2, struct opiocdesc)
-#define	OPIOCNEXTPROP	_IOWR('O', 3, struct opiocdesc)
-#define	OPIOCGETOPTNODE	_IOR('O', 4, int)
-#define	OPIOCGETNEXT	_IOWR('O', 5, int)
-#define	OPIOCGETCHILD	_IOWR('O', 6, int)
-
-#endif /* _SPARC64_OPENPROMIO_H */
-
+#include <asm-sparc/openpromio.h>
-- 
1.5.4.1.143.ge7e51

