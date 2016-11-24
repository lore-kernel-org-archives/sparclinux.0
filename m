From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 22:59:32 +0000
Subject: [PATCH] silo: Add 64-bit support
Message-Id: <20161124225932.13472-2-glaubitz@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch adds the necessary changes to compile silo
on sparc64. It adds the required stack bias for stack
operations and makes sure that all variables are properly
aligned and have the proper size, both on 32- and 64-bit
targets. These changes have been verified to work and
have been used in Debian to ship silo as a 64-bit package.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 Rules.make          |  5 ++---
 common/console.c    |  6 +++---
 common/divdi3.S     | 11 ++++++++++-
 common/jmp.S        | 10 ++++++++--
 common/prom.c       |  4 ++--
 common/tree.c       |  8 ++++----
 common/udivdi3.S    | 10 +++++++++-
 first-isofs/crt0.S  |  8 +++++++-
 first-isofs/isofs.c |  6 +++---
 second/crt0.S       | 21 +++++++++++++++++++--
 second/disk.c       |  8 ++++----
 second/file.c       |  2 +-
 second/muldi3.S     | 10 +++++++++-
 silo/silo.c         | 12 ++++++------
 14 files changed, 87 insertions(+), 34 deletions(-)

diff --git a/Rules.make b/Rules.make
index 0f176db..e46af48 100644
--- a/Rules.make
+++ b/Rules.make
@@ -2,10 +2,9 @@ VERSION=1.4.14
 IMGVERSION=0.99
 SHELL=/bin/bash
 RM=rm -f
-# We want to force 32-bit builds
-CC=gcc -m32
+CC=gcc
 HOSTCC=gcc
-LD=ld -m elf32_sparc
+LD=ld
 AS=as
 STRIP=strip
 NM=nm
diff --git a/common/console.c b/common/console.c
index 44d7efb..270caca 100644
--- a/common/console.c
+++ b/common/console.c
@@ -27,7 +27,7 @@ prom_nbgetchar(void)
 			i = inc;
 		break;
 	case PROM_P1275:
-		if (p1275_cmd ("read", 3, prom_stdin, &inc, 1) = 1)
+		if (p1275_cmd ("read", 3, (unsigned int) prom_stdin, &inc, 1) = 1)
 			i = inc;
 		break;
 	}
@@ -55,7 +55,7 @@ prom_nbputchar(char c)
 		break;
 	case PROM_P1275:
 		outc = c;
-		if (p1275_cmd ("write", 3, prom_stdout, &outc, 1) = 1)
+		if (p1275_cmd ("write", 3, (unsigned int) prom_stdout, &outc, 1) = 1)
 			i = 0;
 		break;
 	}
@@ -93,7 +93,7 @@ prom_puts (char *s, int len)
 		(*(romvec->pv_v2devops).v2_dev_write)(prom_stdout, s, len);
 		break;
 	case PROM_P1275:
-		p1275_cmd ("write", 3, prom_stdout, s, len);
+		p1275_cmd ("write", 3, (unsigned int) prom_stdout, s, len);
 		break;
 	}
 }
diff --git a/common/divdi3.S b/common/divdi3.S
index 681b368..128df53 100644
--- a/common/divdi3.S
+++ b/common/divdi3.S
@@ -17,9 +17,18 @@ along with GNU CC; see the file COPYING.  If not, write to
 the Free Software Foundation, 59 Temple Place - Suite 330,
 Boston, MA 02111-1307, USA.  */
 
+#if __WORDSIZE = 32
+# define STACK_BIAS 0
+#else
+#define STACK_BIAS 2047
+#endif
+
 	.data
 	.align 8
 	.globl	__clz_tab
+	.register %g2,#scratch
+	.register %g3,#scratch
+
 __clz_tab:
 	.byte	0,1,2,2,3,3,3,3,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
 	.byte	6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
@@ -36,7 +45,7 @@ __clz_tab:
 	.align 4
 	.globl __divdi3
 __divdi3:
-	save %sp,-104,%sp
+	save %sp,-STACK_BIAS-104,%sp
 	cmp %i0,0
 	bge .LL40
 	mov 0,%l4
diff --git a/common/jmp.S b/common/jmp.S
index 3bc8c94..a446d78 100644
--- a/common/jmp.S
+++ b/common/jmp.S
@@ -18,7 +18,13 @@
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
    USA.  */
 
-#define _SV save %sp, -0x40, %sp
+#if __WORDSIZE = 32
+# define STACK_BIAS 0
+#else
+# define STACK_BIAS 2047
+#endif
+
+#define _SV save %sp, -STACK_BIAS-0x40, %sp
 #define _RV restore
 #define FLUSH_ALL_WINDOWS \
 	_SV; _SV; _SV; _SV; _SV; _SV; _SV; \
@@ -46,7 +52,7 @@ __longjmp:
 	FLUSH_ALL_WINDOWS
 	ld [%o0], %o7		/* Return PC.  */
 	ld [%o0 + 4], %fp	/* Saved SP.  */
-	sub %fp, 64, %sp	/* Allocate a register save area.  */
+	sub %fp, 64+STACK_BIAS, %sp	/* Allocate a register save area.  */
 	tst %o1
 	be,a 1f
 	mov 1, %o1
diff --git a/common/prom.c b/common/prom.c
index 939bbb9..7585e10 100644
--- a/common/prom.c
+++ b/common/prom.c
@@ -196,7 +196,7 @@ int prom_map(int mode, unsigned long long size,
 			    P1275_ARG_64B(3) | P1275_ARG_64B(4) |
 			    P1275_ARG_64B(6) | 7,
 			    "map",
-			    prom_get_mmu_ihandle(),
+			    (unsigned int) prom_get_mmu_ihandle(),
 			    mode,
 			    size,
 			    vaddr,
@@ -211,7 +211,7 @@ void prom_unmap(unsigned long long size, unsigned long long vaddr)
 	p1275_cmd("call-method",
 		  P1275_ARG_64B(2) | P1275_ARG_64B(3) | 4,
 		  "unmap",
-		  prom_get_mmu_ihandle(),
+		  (unsigned int) prom_get_mmu_ihandle(),
 		  size,
 		  vaddr);
 }
diff --git a/common/tree.c b/common/tree.c
index 56da8b8..65a7743 100644
--- a/common/tree.c
+++ b/common/tree.c
@@ -22,7 +22,7 @@ int prom_getchild(int node)
 	if (prom_vers != PROM_P1275)
 		cnode = prom_nodeops->no_child(node);
 	else
-		cnode = p1275_cmd ("child", 1, node);
+		cnode = p1275_cmd ("child", 1, (unsigned int) node);
 		
 	if (cnode = 0 || cnode = -1)
 		return 0;
@@ -43,7 +43,7 @@ int prom_getsibling(int node)
 	if (prom_vers != PROM_P1275)
 		sibnode = prom_nodeops->no_nextnode(node);
 	else
-		sibnode = p1275_cmd ("peer", 1, node);
+		sibnode = p1275_cmd ("peer", 1, (unsigned int) node);
 		
 	if (sibnode = 0 || sibnode = -1)
 		return 0;
@@ -64,7 +64,7 @@ int prom_getproplen(int node, char *prop)
 		if (prom_vers != PROM_P1275)
 			ret = prom_nodeops->no_proplen(node, prop);
 		else
-			ret = p1275_cmd ("getproplen", 2, node, prop);
+			ret = p1275_cmd ("getproplen", 2, (unsigned int) node, prop);
 	}
 	return ret;
 }
@@ -85,7 +85,7 @@ int prom_getproperty(int node, char *prop, char *buffer, int bufsize)
 		if (prom_vers != PROM_P1275)
 			ret = prom_nodeops->no_getprop(node, prop, buffer);
 		else
-			ret = p1275_cmd ("getprop", 4, node, prop, buffer, bufsize);
+			ret = p1275_cmd ("getprop", 4, (unsigned int) node, prop, buffer, bufsize);
 	}
 	return ret;
 }
diff --git a/common/udivdi3.S b/common/udivdi3.S
index b430f1f..25ba6ef 100644
--- a/common/udivdi3.S
+++ b/common/udivdi3.S
@@ -17,11 +17,19 @@ along with GNU CC; see the file COPYING.  If not, write to
 the Free Software Foundation, 59 Temple Place - Suite 330,
 Boston, MA 02111-1307, USA.  */
 
+#if __WORDSIZE = 32
+# define STACK_BIAS 0
+#else
+# define STACK_BIAS 2047
+#endif
 	.text
 	.align 4
 	.globl __udivdi3
+	.register %g2,#scratch
+	.register %g3,#scratch
+
 __udivdi3:
-	save %sp,-104,%sp
+	save %sp,STACK_BIAS-104,%sp
 	mov %i3,%o3
 	cmp %i2,0
 	bne .LL40
diff --git a/first-isofs/crt0.S b/first-isofs/crt0.S
index 2db1281..88fcab5 100644
--- a/first-isofs/crt0.S
+++ b/first-isofs/crt0.S
@@ -21,6 +21,12 @@
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
    USA.  */
 
+#if __WORDSIZE = 32
+# define STACK_BIAS 0
+#else
+# define STACK_BIAS 2047
+#endif
+
 #define COPY	jmpl	%o7 + (copy - _start), %l7
 
 	.text
@@ -76,7 +82,7 @@ jumphere:
 	! Set up a stack
 setup_stack:
 	set	0x400000, %l1
-	save	%l1, -64, %sp
+	save	%l1, -STACK_BIAS-64, %sp
 
 	! Call cd_main() to start the whole thingie up
 
diff --git a/first-isofs/isofs.c b/first-isofs/isofs.c
index d7a603b..47d1c48 100644
--- a/first-isofs/isofs.c
+++ b/first-isofs/isofs.c
@@ -114,7 +114,7 @@ static void cd_fini(void)
 		break;
 
 	case PROM_P1275:
-		p1275_cmd("close", 1, fd);
+		p1275_cmd("close", 1, (unsigned)fd);
 		break;
 	};
 }
@@ -141,7 +141,7 @@ static int cd_read_block(unsigned long long offset, int size, void *data)
 
 		if (seekp != offset) {
 			if (prom_vers = PROM_P1275) {
-				if (p1275_cmd("seek", P1275_ARG_64B(2) | 3, fd, 0, offset) = -1)
+				if (p1275_cmd("seek", P1275_ARG_64B(2) | 3, (unsigned)fd, 0, offset) = -1)
 					return -1;
 			} else {
 				if ((*romvec->pv_v2devops.v2_dev_seek)
@@ -152,7 +152,7 @@ static int cd_read_block(unsigned long long offset, int size, void *data)
 		}
 
 		if (prom_vers = PROM_P1275)
-			ret = p1275_cmd ("read", 3, fd, data, size);
+			ret = p1275_cmd ("read", 3, (unsigned)fd, data, size);
 		else
 			ret = (*romvec->pv_v2devops.v2_dev_read) (fd, data, size);
 
diff --git a/second/crt0.S b/second/crt0.S
index f1ba1c8..399d174 100644
--- a/second/crt0.S
+++ b/second/crt0.S
@@ -21,6 +21,12 @@
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
    USA.  */
 
+#if __WORDSIZE = 32
+# define STACK_BIAS 0
+#else
+# define STACK_BIAS 2047
+#endif
+
 #define COPY	jmpl	%o7 + (copy - _start), %l7
 
 	.text
@@ -82,7 +88,11 @@ boot_parts:
 	sub	%l0, 16, %l0
 	sethi	%hi(gzminpi), %l1
 	add	%l1, %i3, %l1
+#if __WORDSIZE = 32
 	st	%l0, [%l1 + %lo(gzminpi)]
+#else
+	stx	%l0, [%l1 + %lo(gzminpi)]
+#endif
 
 	/* Jump to relocated code */
 	sethi	%hi(_end), %l0
@@ -121,12 +131,15 @@ jumphere:
 
 	! Set up a stack
 setup_stack:
-	save	%i0,-120,%sp
-
+	save	%i0,-STACK_BIAS-120,%sp
 	tst	%i4
 	be	0f
 	 sethi	%hi(gzminpi+0x100000), %l0
+#if __WORDSIZE = 32
 	ld	[%l0 + %lo(gzminpi)], %l1
+#else
+	ldx	[%l0 + %lo(gzminpi)], %l1
+#endif
 	sethi	%hi(LARGE_RELOC), %l2
 1:	lduh	[%l1], %l3
 	add	%l1, 2, %l1
@@ -147,7 +160,11 @@ setup_stack:
 	add	%l3, 16, %l3
 	ba	3b
 	 stb	%l3, [%l2]
+#if __WORDSIZE = 32
 4:	st	%l1, [%l0 + %lo(gzminpi)]
+#else
+4:	stx	%l1, [%l0 + %lo(gzminpi)]
+#endif
 
 	! Call my_main() to start the whole thingie up
 
diff --git a/second/disk.c b/second/disk.c
index 40234b3..989ab61 100644
--- a/second/disk.c
+++ b/second/disk.c
@@ -79,7 +79,7 @@ int silo_disk_open(char *device)
 
         	fd = p1275_cmd ("open", 1, device);
         	if ((unsigned)(fd + 1) > 1) {
-		    node = p1275_cmd ("instance-to-package", 1, fd);
+		    node = p1275_cmd ("instance-to-package", 1, (unsigned)fd);
                     /*
                      * Don't use our argument due to devalias.
                      * Alas, flash has no device_type property.
@@ -301,7 +301,7 @@ int silo_disk_read(char *buff, int size, unsigned long long offset)
 	    }
 	    if (seekp != offset) {
 	    	if (prom_vers = PROM_P1275) {
-		        if ((rc = p1275_cmd ("seek", P1275_ARG_64B(2) | 3, fd, 0, offset)) = -1)
+		        if ((rc = p1275_cmd ("seek", P1275_ARG_64B(2) | 3, (unsigned) fd, 0, offset)) = -1)
 			    return -1;
 	    	} else {
 		        if ((*romvec->pv_v2devops.v2_dev_seek) (fd, (unsigned)(offset >> 32), (unsigned)offset) = -1)
@@ -311,7 +311,7 @@ int silo_disk_read(char *buff, int size, unsigned long long offset)
 	    }
 	}
 	if (prom_vers = PROM_P1275) {
-		rc = p1275_cmd ("read", 3, fd, buff, size);
+		rc = p1275_cmd ("read", 3, (unsigned) fd, buff, size);
 	} else {
 		int i;
 		for (i = 0; i < 2; i++) {
@@ -355,7 +355,7 @@ void silo_disk_close(void)
 	case PROM_V3:
 	    (*romvec->pv_v2devops.v2_dev_close) (fd); break;
 	case PROM_P1275:
-	    p1275_cmd ("close", 1, fd); break;
+	    p1275_cmd ("close", 1, (unsigned) fd); break;
 	}
     }
     *currentdevice = 0;
diff --git a/second/file.c b/second/file.c
index c7c1ed2..379af2f 100644
--- a/second/file.c
+++ b/second/file.c
@@ -193,7 +193,7 @@ int dump_block (blk_t * blocknr, int blockcnt)
                 }
                 last_blockcnt = -1;
             }
-            if ((char *)filebuffer + (block_cnt + ((*blocknr) ? (blockcnt - last_blockcnt - 1) : 0)) * bs > filelimit) {
+            if ((unsigned int)filebuffer + (block_cnt + ((*blocknr) ? (blockcnt - last_blockcnt - 1) : 0)) * bs > filelimit) {
                 silo_fatal("Image too large to fit in destination");
                 return BLOCK_ABORT;
             }
diff --git a/second/muldi3.S b/second/muldi3.S
index 7f17872..7180630 100644
--- a/second/muldi3.S
+++ b/second/muldi3.S
@@ -17,11 +17,19 @@ along with GNU CC; see the file COPYING.  If not, write to
 the Free Software Foundation, 59 Temple Place - Suite 330,
 Boston, MA 02111-1307, USA.  */
 
+#if __WORDSIZE = 32
+# define STACK_BIAS 0
+#else
+# define STACK_BIAS 2047
+#endif
+
 	.text
 	.align 4
 	.globl __muldi3
+	.register %g2,#scratch
+	.register %g3,#scratch
 __muldi3:
-	save  %sp, -104, %sp
+	save  %sp, -STACK_BIAS-104, %sp
 	wr  %g0, %i1, %y
 	sra  %i3, 0x1f, %g2
 	and  %i1, %g2, %g2
diff --git a/silo/silo.c b/silo/silo.c
index 9728af2..20b7a0c 100644
--- a/silo/silo.c
+++ b/silo/silo.c
@@ -107,14 +107,14 @@ static int allow_confchk_fail = 0;
 
 /* This is just so that we don't have to fight with incompatible ufs_fs.h headers */
 #define SILO_UFS_MAGIC 0x00011954
-struct silo_ufs_super_block {
+struct __attribute__((packed)) silo_ufs_super_block {
 	unsigned char xxx1[36];
 	unsigned int fs_fsize;
 	unsigned char xxx2[1332];
 	unsigned int fs_magic;
 };
                                 
-struct sun_disklabel {
+struct __attribute__((packed)) sun_disklabel {
     unsigned char info[128];	/* Informative text string */
     unsigned char spare[292];	/* Boot information etc. */
     unsigned short rspeed;	/* Disk rotational speed */
@@ -127,9 +127,9 @@ struct sun_disklabel {
     unsigned short ntrks;	/* Tracks per cylinder */
     unsigned short nsect;	/* Sectors per track */
     unsigned char spare3[4];	/* Even more magic... */
-    struct sun_partition {
-	unsigned long start_cylinder;
-	unsigned long num_sectors;
+    struct __attribute__((packed)) sun_partition {
+	unsigned int start_cylinder;
+	unsigned int num_sectors;
     } partitions[8];
     unsigned short magic;	/* Magic number */
     unsigned short csum;	/* Label xor'd checksum */
@@ -205,7 +205,7 @@ int check_fs (int fd)
 {
     struct silo_ufs_super_block ufs;
     struct ext2_super_block sb;	/* Super Block Info */
-    struct romfs_super_block {
+    struct __attribute__((packed)) romfs_super_block {
 	__u32 word0;
 	__u32 word1;
 	__u32 size;
-- 
2.10.2

