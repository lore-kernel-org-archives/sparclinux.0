From: David Howells <dhowells@redhat.com>
Date: Tue, 31 Aug 2004 15:12:14 +0000
Subject: [PATCH] New error codes for Alpha, MIPS, PA-RISC, Sparc & Sparc64
Message-Id: <13071.1093965134@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040830232445.0b5aad79.akpm@osdl.org> 
In-Reply-To: <20040830232445.0b5aad79.akpm@osdl.org> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, rth@twiddle.net, linux-mips@linux-mips.org, parisc-linux@parisc-linux.org, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


The attached patch adds the new error codes I added for key-related errors to
those archs that don't make use of <asm-generic/errno.h>, including Alpha,
MIPS, PA-RISC, Sparc and Sparc64. This is required to compile with CONFIG_KEYS
on those platforms.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

warthog>diffstat keys-errors-2681mm4.diff 
 asm-alpha/errno.h   |    4 ++++
 asm-mips/errno.h    |    4 ++++
 asm-parisc/errno.h  |    4 ++++
 asm-sparc/errno.h   |    4 ++++
 asm-sparc64/errno.h |    4 ++++
 5 files changed, 20 insertions(+)

diff -uNrp linux-2.6.8.1-mm4-keys/include/asm-alpha/errno.h linux-2.6.8.1-mm4-keys-read/include/asm-alpha/errno.h
--- linux-2.6.8.1-mm4-keys/include/asm-alpha/errno.h	2004-06-18 13:42:21.000000000 +0100
+++ linux-2.6.8.1-mm4-keys-read/include/asm-alpha/errno.h	2004-08-31 10:10:11.466082943 +0100
@@ -110,5 +110,9 @@
 
 #define ENOMEDIUM	129	/* No medium found */
 #define EMEDIUMTYPE	130	/* Wrong medium type */
+#define	ENOKEY		131	/* Required key not available */
+#define	EKEYEXPIRED	132	/* Key has expired */
+#define	EKEYREVOKED	133	/* Key has been revoked */
+#define	EKEYREJECTED	134	/* Key was rejected by service */
 
 #endif
diff -uNrp linux-2.6.8.1-mm4-keys/include/asm-mips/errno.h linux-2.6.8.1-mm4-keys-read/include/asm-mips/errno.h
--- linux-2.6.8.1-mm4-keys/include/asm-mips/errno.h	2004-06-18 13:42:12.000000000 +0100
+++ linux-2.6.8.1-mm4-keys-read/include/asm-mips/errno.h	2004-08-31 10:12:16.492662321 +0100
@@ -110,6 +110,10 @@
  */
 #define ENOMEDIUM	159	/* No medium found */
 #define EMEDIUMTYPE	160	/* Wrong medium type */
+#define	ENOKEY		161	/* Required key not available */
+#define	EKEYEXPIRED	162	/* Key has expired */
+#define	EKEYREVOKED	163	/* Key has been revoked */
+#define	EKEYREJECTED	164	/* Key was rejected by service */
 
 #define EDQUOT		1133	/* Quota exceeded */
 
diff -uNrp linux-2.6.8.1-mm4-keys/include/asm-parisc/errno.h linux-2.6.8.1-mm4-keys-read/include/asm-parisc/errno.h
--- linux-2.6.8.1-mm4-keys/include/asm-parisc/errno.h	2004-06-18 13:42:13.000000000 +0100
+++ linux-2.6.8.1-mm4-keys-read/include/asm-parisc/errno.h	2004-08-31 10:11:51.478747181 +0100
@@ -67,6 +67,10 @@
 #define	EREMOTEIO	181	/* Remote I/O error */
 #define	ENOMEDIUM	182	/* No medium found */
 #define	EMEDIUMTYPE	183	/* Wrong medium type */
+#define	ENOKEY		184	/* Required key not available */
+#define	EKEYEXPIRED	185	/* Key has expired */
+#define	EKEYREVOKED	186	/* Key has been revoked */
+#define	EKEYREJECTED	187	/* Key was rejected by service */
 
 /* We now return you to your regularly scheduled HPUX. */
 
diff -uNrp linux-2.6.8.1-mm4-keys/include/asm-sparc/errno.h linux-2.6.8.1-mm4-keys-read/include/asm-sparc/errno.h
--- linux-2.6.8.1-mm4-keys/include/asm-sparc/errno.h	2004-06-18 13:42:21.000000000 +0100
+++ linux-2.6.8.1-mm4-keys-read/include/asm-sparc/errno.h	2004-08-31 10:10:55.134443332 +0100
@@ -101,5 +101,9 @@
 
 #define	ENOMEDIUM	125	/* No medium found */
 #define	EMEDIUMTYPE	126	/* Wrong medium type */
+#define	ENOKEY		127	/* Required key not available */
+#define	EKEYEXPIRED	128	/* Key has expired */
+#define	EKEYREVOKED	129	/* Key has been revoked */
+#define	EKEYREJECTED	130	/* Key was rejected by service */
 
 #endif
diff -uNrp linux-2.6.8.1-mm4-keys/include/asm-sparc64/errno.h linux-2.6.8.1-mm4-keys-read/include/asm-sparc64/errno.h
--- linux-2.6.8.1-mm4-keys/include/asm-sparc64/errno.h	2004-06-18 13:42:22.000000000 +0100
+++ linux-2.6.8.1-mm4-keys-read/include/asm-sparc64/errno.h	2004-08-31 10:09:36.730977977 +0100
@@ -101,5 +101,9 @@
 
 #define ENOMEDIUM       125     /* No medium found */
 #define EMEDIUMTYPE     126     /* Wrong medium type */
+#define	ENOKEY		127	/* Required key not available */
+#define	EKEYEXPIRED	128	/* Key has expired */
+#define	EKEYREVOKED	129	/* Key has been revoked */
+#define	EKEYREJECTED	130	/* Key was rejected by service */
 
 #endif /* !(_SPARC64_ERRNO_H) */
