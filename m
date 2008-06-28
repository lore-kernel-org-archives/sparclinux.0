From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 28 Jun 2008 22:04:34 +0000
Subject: [PATCH 02/25] sparc: Merge asm-sparc{,64}/ioctl.h
Message-Id: <1214690697-4631-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

:$ diff -u include/asm-sparc/ioctl.h include/asm-sparc64/ioctl.h
:-- include/asm-sparc/ioctl.h	2008-06-13 06:46:39.000000000 +0200
:++ include/asm-sparc64/ioctl.h	2008-06-13 08:46:29.000000000 +0200
:@@ -1,5 +1,5 @@
:-#ifndef _SPARC_IOCTL_H
:-#define _SPARC_IOCTL_H
:+#ifndef _SPARC64_IOCTL_H
:+#define _SPARC64_IOCTL_H
:
:/*
:* Our DIR and SIZE overlap in order to simulteneously provide
:@@ -64,4 +64,4 @@
:#define IOCSIZE_MASK    (_IOC_XSIZEMASK << _IOC_SIZESHIFT)
:#define IOCSIZE_SHIFT   (_IOC_SIZESHIFT)
:
:-#endif /* !(_SPARC_IOCTL_H) */
:+#endif /* !(_SPARC64_IOCTL_H) */

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc64/ioctl.h |   68 +------------------------------------------
 1 files changed, 1 insertions(+), 67 deletions(-)

diff --git a/include/asm-sparc64/ioctl.h b/include/asm-sparc64/ioctl.h
index d634c21..18fc562 100644
--- a/include/asm-sparc64/ioctl.h
+++ b/include/asm-sparc64/ioctl.h
@@ -1,67 +1 @@
-#ifndef _SPARC64_IOCTL_H
-#define _SPARC64_IOCTL_H
-
-/*
- * Our DIR and SIZE overlap in order to simulteneously provide
- * a non-zero _IOC_NONE (for binary compatibility) and
- * 14 bits of size as on i386. Here's the layout:
- *
- *   0xE0000000   DIR
- *   0x80000000     DIR = WRITE
- *   0x40000000     DIR = READ
- *   0x20000000     DIR = NONE
- *   0x3FFF0000   SIZE (overlaps NONE bit)
- *   0x0000FF00   TYPE
- *   0x000000FF   NR (CMD)
- */
-
-#define _IOC_NRBITS      8
-#define _IOC_TYPEBITS    8
-#define _IOC_SIZEBITS   13	/* Actually 14, see below. */
-#define _IOC_DIRBITS     3
-
-#define _IOC_NRMASK      ((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK    ((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK    ((1 << _IOC_SIZEBITS)-1)
-#define _IOC_XSIZEMASK   ((1 << (_IOC_SIZEBITS+1))-1)
-#define _IOC_DIRMASK     ((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT     0
-#define _IOC_TYPESHIFT   (_IOC_NRSHIFT + _IOC_NRBITS)
-#define _IOC_SIZESHIFT   (_IOC_TYPESHIFT + _IOC_TYPEBITS)
-#define _IOC_DIRSHIFT    (_IOC_SIZESHIFT + _IOC_SIZEBITS)
-
-#define _IOC_NONE        1U
-#define _IOC_READ        2U
-#define _IOC_WRITE       4U
-
-#define _IOC(dir,type,nr,size) \
-        (((dir)  << _IOC_DIRSHIFT) | \
-         ((type) << _IOC_TYPESHIFT) | \
-         ((nr)   << _IOC_NRSHIFT) | \
-         ((size) << _IOC_SIZESHIFT))
-
-#define _IO(type,nr)        _IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size) _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* Used to decode ioctl numbers in drivers despite the leading underscore... */
-#define _IOC_DIR(nr)    \
- ( (((((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK) & (_IOC_WRITE|_IOC_READ)) != 0)?   \
-                            (((nr) >> _IOC_DIRSHIFT) & (_IOC_WRITE|_IOC_READ)):  \
-                            (((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK) )
-#define _IOC_TYPE(nr)       (((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)         (((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)   \
- ((((((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK) & (_IOC_WRITE|_IOC_READ)) = 0)?    \
-                         0: (((nr) >> _IOC_SIZESHIFT) & _IOC_XSIZEMASK))
-
-/* ...and for the PCMCIA and sound. */
-#define IOC_IN          (_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT         (_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT       ((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK    (_IOC_XSIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT   (_IOC_SIZESHIFT)
-
-#endif /* !(_SPARC64_IOCTL_H) */
+#include <asm-sparc/ioctl.h>
-- 
1.5.4.1.143.ge7e51

