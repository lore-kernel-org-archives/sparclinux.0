From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:32 +0000
Subject: [PATCH 20/21] sparc: copy sparc64 header files to asm-sparc
Message-Id: <1212786033-4227-20-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Several header files had non-trivial differences between
the 32 and 64 bit version.
To better support further unification create a _32.h
file for the orginal 32 bit version and likewise a _64.h
for the original 64 bit version.
To spot potential unification is now a simple:
---
 include/asm-sparc/asi.h            |  119 +-----------
 include/asm-sparc/asi_32.h         |  111 +++++++++++
 include/asm-sparc/asi_64.h         |  160 +++++++++++++++
 include/asm-sparc/ipcbuf.h         |   39 +---
 include/asm-sparc/ipcbuf_32.h      |   31 +++
 include/asm-sparc/ipcbuf_64.h      |   28 +++
 include/asm-sparc/openprom.h       |  265 +------------------------
 include/asm-sparc/openprom_32.h    |  257 ++++++++++++++++++++++++
 include/asm-sparc/openprom_64.h    |  280 ++++++++++++++++++++++++++
 include/asm-sparc/posix_types.h    |  124 +-----------
 include/asm-sparc/posix_types_32.h |  118 +++++++++++
 include/asm-sparc/posix_types_64.h |  122 ++++++++++++
 include/asm-sparc/ptrace.h         |  179 +----------------
 include/asm-sparc/ptrace_32.h      |  175 ++++++++++++++++
 include/asm-sparc/ptrace_64.h      |  346 ++++++++++++++++++++++++++++++++
 include/asm-sparc/reg.h            |   87 +--------
 include/asm-sparc/reg_32.h         |   79 ++++++++
 include/asm-sparc/reg_64.h         |   56 ++++++
 include/asm-sparc/sigcontext.h     |   70 +------
 include/asm-sparc/sigcontext_32.h  |   62 ++++++
 include/asm-sparc/sigcontext_64.h  |   87 ++++++++
 include/asm-sparc/siginfo.h        |   25 +--
 include/asm-sparc/siginfo_32.h     |   17 ++
 include/asm-sparc/siginfo_64.h     |   32 +++
 include/asm-sparc/signal.h         |  209 +-------------------
 include/asm-sparc/signal_32.h      |  207 +++++++++++++++++++
 include/asm-sparc/signal_64.h      |  194 ++++++++++++++++++
 include/asm-sparc/stat.h           |   82 +-------
 include/asm-sparc/stat_32.h        |   76 +++++++
 include/asm-sparc/stat_64.h        |   47 +++++
 include/asm-sparc/statfs.h         |   12 +-
 include/asm-sparc/statfs_32.h      |    6 +
 include/asm-sparc/statfs_64.h      |   54 +++++
 include/asm-sparc/unistd.h         |  386 +-----------------------------------
 include/asm-sparc/unistd_32.h      |  378 +++++++++++++++++++++++++++++++++++
 include/asm-sparc/unistd_64.h      |  373 ++++++++++++++++++++++++++++++++++
 include/asm-sparc64/asi.h          |  161 +---------------
 include/asm-sparc64/ipcbuf.h       |   29 +---
 include/asm-sparc64/openprom.h     |  281 +--------------------------
 include/asm-sparc64/posix_types.h  |  123 +------------
 include/asm-sparc64/ptrace.h       |  347 +--------------------------------
 include/asm-sparc64/reg.h          |   57 +------
 include/asm-sparc64/sigcontext.h   |   88 +--------
 include/asm-sparc64/siginfo.h      |   33 +---
 include/asm-sparc64/signal.h       |  195 +------------------
 include/asm-sparc64/stat.h         |   48 +-----
 include/asm-sparc64/statfs.h       |   55 +-----
 include/asm-sparc64/unistd.h       |  374 +----------------------------------
 48 files changed, 3396 insertions(+), 3288 deletions(-)
 create mode 100644 include/asm-sparc/asi_32.h
 create mode 100644 include/asm-sparc/asi_64.h
 create mode 100644 include/asm-sparc/ipcbuf_32.h
 create mode 100644 include/asm-sparc/ipcbuf_64.h
 create mode 100644 include/asm-sparc/openprom_32.h
 create mode 100644 include/asm-sparc/openprom_64.h
 create mode 100644 include/asm-sparc/posix_types_32.h
 create mode 100644 include/asm-sparc/posix_types_64.h
 create mode 100644 include/asm-sparc/ptrace_32.h
 create mode 100644 include/asm-sparc/ptrace_64.h
 create mode 100644 include/asm-sparc/reg_32.h
 create mode 100644 include/asm-sparc/reg_64.h
 create mode 100644 include/asm-sparc/sigcontext_32.h
 create mode 100644 include/asm-sparc/sigcontext_64.h
 create mode 100644 include/asm-sparc/siginfo_32.h
 create mode 100644 include/asm-sparc/siginfo_64.h
 create mode 100644 include/asm-sparc/signal_32.h
 create mode 100644 include/asm-sparc/signal_64.h
 create mode 100644 include/asm-sparc/stat_32.h
 create mode 100644 include/asm-sparc/stat_64.h
 create mode 100644 include/asm-sparc/statfs_32.h
 create mode 100644 include/asm-sparc/statfs_64.h
 create mode 100644 include/asm-sparc/unistd_32.h
 create mode 100644 include/asm-sparc/unistd_64.h

diff --git a/include/asm-sparc/asi.h b/include/asm-sparc/asi.h
index 158f9b0..3fb6689 100644
--- a/include/asm-sparc/asi.h
+++ b/include/asm-sparc/asi.h
@@ -1,111 +1,8 @@
-#ifndef _SPARC_ASI_H
-#define _SPARC_ASI_H
-
-/* asi.h:  Address Space Identifier values for the sparc.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- *
- * Pioneer work for sun4m: Paul Hatchman (paul@sfe.com.au)
- * Joint edition for sun4c+sun4m: Pete A. Zaitcev <zaitcev@ipmce.su>
- */
-
-/* The first batch are for the sun4c. */
-
-#define ASI_NULL1           0x00
-#define ASI_NULL2           0x01
-
-/* sun4c and sun4 control registers and mmu/vac ops */
-#define ASI_CONTROL         0x02
-#define ASI_SEGMAP          0x03
-#define ASI_PTE             0x04
-#define ASI_HWFLUSHSEG      0x05
-#define ASI_HWFLUSHPAGE     0x06
-#define ASI_REGMAP          0x06
-#define ASI_HWFLUSHCONTEXT  0x07
-
-#define ASI_USERTXT         0x08
-#define ASI_KERNELTXT       0x09
-#define ASI_USERDATA        0x0a
-#define ASI_KERNELDATA      0x0b
-
-/* VAC Cache flushing on sun4c and sun4 */
-#define ASI_FLUSHSEG        0x0c
-#define ASI_FLUSHPG         0x0d
-#define ASI_FLUSHCTX        0x0e
-
-/* SPARCstation-5: only 6 bits are decoded. */
-/* wo = Write Only, rw = Read Write;        */
-/* ss = Single Size, as = All Sizes;        */
-#define ASI_M_RES00         0x00   /* Don't touch... */
-#define ASI_M_UNA01         0x01   /* Same here... */
-#define ASI_M_MXCC          0x02   /* Access to TI VIKING MXCC registers */
-#define ASI_M_FLUSH_PROBE   0x03   /* Reference MMU Flush/Probe; rw, ss */
-#define ASI_M_MMUREGS       0x04   /* MMU Registers; rw, ss */
-#define ASI_M_TLBDIAG       0x05   /* MMU TLB only Diagnostics */
-#define ASI_M_DIAGS         0x06   /* Reference MMU Diagnostics */
-#define ASI_M_IODIAG        0x07   /* MMU I/O TLB only Diagnostics */
-#define ASI_M_USERTXT       0x08   /* Same as ASI_USERTXT; rw, as */
-#define ASI_M_KERNELTXT     0x09   /* Same as ASI_KERNELTXT; rw, as */
-#define ASI_M_USERDATA      0x0A   /* Same as ASI_USERDATA; rw, as */
-#define ASI_M_KERNELDATA    0x0B   /* Same as ASI_KERNELDATA; rw, as */
-#define ASI_M_TXTC_TAG      0x0C   /* Instruction Cache Tag; rw, ss */
-#define ASI_M_TXTC_DATA     0x0D   /* Instruction Cache Data; rw, ss */
-#define ASI_M_DATAC_TAG     0x0E   /* Data Cache Tag; rw, ss */
-#define ASI_M_DATAC_DATA    0x0F   /* Data Cache Data; rw, ss */
-
-/* The following cache flushing ASIs work only with the 'sta'
- * instruction. Results are unpredictable for 'swap' and 'ldstuba',
- * so don't do it.
- */
-
-/* These ASI flushes affect external caches too. */
-#define ASI_M_FLUSH_PAGE    0x10   /* Flush I&D Cache Line (page); wo, ss */
-#define ASI_M_FLUSH_SEG     0x11   /* Flush I&D Cache Line (seg); wo, ss */
-#define ASI_M_FLUSH_REGION  0x12   /* Flush I&D Cache Line (region); wo, ss */
-#define ASI_M_FLUSH_CTX     0x13   /* Flush I&D Cache Line (context); wo, ss */
-#define ASI_M_FLUSH_USER    0x14   /* Flush I&D Cache Line (user); wo, ss */
-
-/* Block-copy operations are available only on certain V8 cpus. */
-#define ASI_M_BCOPY         0x17   /* Block copy */
-
-/* These affect only the ICACHE and are Ross HyperSparc and TurboSparc specific. */
-#define ASI_M_IFLUSH_PAGE   0x18   /* Flush I Cache Line (page); wo, ss */
-#define ASI_M_IFLUSH_SEG    0x19   /* Flush I Cache Line (seg); wo, ss */
-#define ASI_M_IFLUSH_REGION 0x1A   /* Flush I Cache Line (region); wo, ss */
-#define ASI_M_IFLUSH_CTX    0x1B   /* Flush I Cache Line (context); wo, ss */
-#define ASI_M_IFLUSH_USER   0x1C   /* Flush I Cache Line (user); wo, ss */
-
-/* Block-fill operations are available on certain V8 cpus */
-#define ASI_M_BFILL         0x1F
-
-/* This allows direct access to main memory, actually 0x20 to 0x2f are
- * the available ASI's for physical ram pass-through, but I don't have
- * any idea what the other ones do....
- */
-
-#define ASI_M_BYPASS       0x20   /* Reference MMU bypass; rw, as */
-#define ASI_M_FBMEM        0x29   /* Graphics card frame buffer access */
-#define ASI_M_VMEUS        0x2A   /* VME user 16-bit access */
-#define ASI_M_VMEPS        0x2B   /* VME priv 16-bit access */
-#define ASI_M_VMEUT        0x2C   /* VME user 32-bit access */
-#define ASI_M_VMEPT        0x2D   /* VME priv 32-bit access */
-#define ASI_M_SBUS         0x2E   /* Direct SBus access */
-#define ASI_M_CTL          0x2F   /* Control Space (ECC and MXCC are here) */
-
-
-/* This is ROSS HyperSparc only. */
-#define ASI_M_FLUSH_IWHOLE 0x31   /* Flush entire ICACHE; wo, ss */
-
-/* Tsunami/Viking/TurboSparc i/d cache flash clear. */
-#define ASI_M_IC_FLCLEAR   0x36
-#define ASI_M_DC_FLCLEAR   0x37
-
-#define ASI_M_DCDR         0x39   /* Data Cache Diagnostics Register rw, ss */
-
-#define ASI_M_VIKING_TMP1  0x40	  /* Emulation temporary 1 on Viking */
-/* only available on SuperSparc I */
-/* #define ASI_M_VIKING_TMP2  0x41 */  /* Emulation temporary 2 on Viking */
-
-#define ASI_M_ACTION       0x4c   /* Breakpoint Action Register (GNU/Viking) */
-
-#endif /* _SPARC_ASI_H */
+#ifndef _ASM_SPARC_ASI_H
+#define _ASM_SPARC_ASI_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/asi_64.h>
+#else
+#include <asm-sparc/asi_32.h>
+#endif
+#endif
diff --git a/include/asm-sparc/asi_32.h b/include/asm-sparc/asi_32.h
new file mode 100644
index 0000000..158f9b0
--- /dev/null
+++ b/include/asm-sparc/asi_32.h
@@ -0,0 +1,111 @@
+#ifndef _SPARC_ASI_H
+#define _SPARC_ASI_H
+
+/* asi.h:  Address Space Identifier values for the sparc.
+ *
+ * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
+ *
+ * Pioneer work for sun4m: Paul Hatchman (paul@sfe.com.au)
+ * Joint edition for sun4c+sun4m: Pete A. Zaitcev <zaitcev@ipmce.su>
+ */
+
+/* The first batch are for the sun4c. */
+
+#define ASI_NULL1           0x00
+#define ASI_NULL2           0x01
+
+/* sun4c and sun4 control registers and mmu/vac ops */
+#define ASI_CONTROL         0x02
+#define ASI_SEGMAP          0x03
+#define ASI_PTE             0x04
+#define ASI_HWFLUSHSEG      0x05
+#define ASI_HWFLUSHPAGE     0x06
+#define ASI_REGMAP          0x06
+#define ASI_HWFLUSHCONTEXT  0x07
+
+#define ASI_USERTXT         0x08
+#define ASI_KERNELTXT       0x09
+#define ASI_USERDATA        0x0a
+#define ASI_KERNELDATA      0x0b
+
+/* VAC Cache flushing on sun4c and sun4 */
+#define ASI_FLUSHSEG        0x0c
+#define ASI_FLUSHPG         0x0d
+#define ASI_FLUSHCTX        0x0e
+
+/* SPARCstation-5: only 6 bits are decoded. */
+/* wo = Write Only, rw = Read Write;        */
+/* ss = Single Size, as = All Sizes;        */
+#define ASI_M_RES00         0x00   /* Don't touch... */
+#define ASI_M_UNA01         0x01   /* Same here... */
+#define ASI_M_MXCC          0x02   /* Access to TI VIKING MXCC registers */
+#define ASI_M_FLUSH_PROBE   0x03   /* Reference MMU Flush/Probe; rw, ss */
+#define ASI_M_MMUREGS       0x04   /* MMU Registers; rw, ss */
+#define ASI_M_TLBDIAG       0x05   /* MMU TLB only Diagnostics */
+#define ASI_M_DIAGS         0x06   /* Reference MMU Diagnostics */
+#define ASI_M_IODIAG        0x07   /* MMU I/O TLB only Diagnostics */
+#define ASI_M_USERTXT       0x08   /* Same as ASI_USERTXT; rw, as */
+#define ASI_M_KERNELTXT     0x09   /* Same as ASI_KERNELTXT; rw, as */
+#define ASI_M_USERDATA      0x0A   /* Same as ASI_USERDATA; rw, as */
+#define ASI_M_KERNELDATA    0x0B   /* Same as ASI_KERNELDATA; rw, as */
+#define ASI_M_TXTC_TAG      0x0C   /* Instruction Cache Tag; rw, ss */
+#define ASI_M_TXTC_DATA     0x0D   /* Instruction Cache Data; rw, ss */
+#define ASI_M_DATAC_TAG     0x0E   /* Data Cache Tag; rw, ss */
+#define ASI_M_DATAC_DATA    0x0F   /* Data Cache Data; rw, ss */
+
+/* The following cache flushing ASIs work only with the 'sta'
+ * instruction. Results are unpredictable for 'swap' and 'ldstuba',
+ * so don't do it.
+ */
+
+/* These ASI flushes affect external caches too. */
+#define ASI_M_FLUSH_PAGE    0x10   /* Flush I&D Cache Line (page); wo, ss */
+#define ASI_M_FLUSH_SEG     0x11   /* Flush I&D Cache Line (seg); wo, ss */
+#define ASI_M_FLUSH_REGION  0x12   /* Flush I&D Cache Line (region); wo, ss */
+#define ASI_M_FLUSH_CTX     0x13   /* Flush I&D Cache Line (context); wo, ss */
+#define ASI_M_FLUSH_USER    0x14   /* Flush I&D Cache Line (user); wo, ss */
+
+/* Block-copy operations are available only on certain V8 cpus. */
+#define ASI_M_BCOPY         0x17   /* Block copy */
+
+/* These affect only the ICACHE and are Ross HyperSparc and TurboSparc specific. */
+#define ASI_M_IFLUSH_PAGE   0x18   /* Flush I Cache Line (page); wo, ss */
+#define ASI_M_IFLUSH_SEG    0x19   /* Flush I Cache Line (seg); wo, ss */
+#define ASI_M_IFLUSH_REGION 0x1A   /* Flush I Cache Line (region); wo, ss */
+#define ASI_M_IFLUSH_CTX    0x1B   /* Flush I Cache Line (context); wo, ss */
+#define ASI_M_IFLUSH_USER   0x1C   /* Flush I Cache Line (user); wo, ss */
+
+/* Block-fill operations are available on certain V8 cpus */
+#define ASI_M_BFILL         0x1F
+
+/* This allows direct access to main memory, actually 0x20 to 0x2f are
+ * the available ASI's for physical ram pass-through, but I don't have
+ * any idea what the other ones do....
+ */
+
+#define ASI_M_BYPASS       0x20   /* Reference MMU bypass; rw, as */
+#define ASI_M_FBMEM        0x29   /* Graphics card frame buffer access */
+#define ASI_M_VMEUS        0x2A   /* VME user 16-bit access */
+#define ASI_M_VMEPS        0x2B   /* VME priv 16-bit access */
+#define ASI_M_VMEUT        0x2C   /* VME user 32-bit access */
+#define ASI_M_VMEPT        0x2D   /* VME priv 32-bit access */
+#define ASI_M_SBUS         0x2E   /* Direct SBus access */
+#define ASI_M_CTL          0x2F   /* Control Space (ECC and MXCC are here) */
+
+
+/* This is ROSS HyperSparc only. */
+#define ASI_M_FLUSH_IWHOLE 0x31   /* Flush entire ICACHE; wo, ss */
+
+/* Tsunami/Viking/TurboSparc i/d cache flash clear. */
+#define ASI_M_IC_FLCLEAR   0x36
+#define ASI_M_DC_FLCLEAR   0x37
+
+#define ASI_M_DCDR         0x39   /* Data Cache Diagnostics Register rw, ss */
+
+#define ASI_M_VIKING_TMP1  0x40	  /* Emulation temporary 1 on Viking */
+/* only available on SuperSparc I */
+/* #define ASI_M_VIKING_TMP2  0x41 */  /* Emulation temporary 2 on Viking */
+
+#define ASI_M_ACTION       0x4c   /* Breakpoint Action Register (GNU/Viking) */
+
+#endif /* _SPARC_ASI_H */
diff --git a/include/asm-sparc/asi_64.h b/include/asm-sparc/asi_64.h
new file mode 100644
index 0000000..bc57c40
--- /dev/null
+++ b/include/asm-sparc/asi_64.h
@@ -0,0 +1,160 @@
+#ifndef _SPARC64_ASI_H
+#define _SPARC64_ASI_H
+
+/* asi.h:  Address Space Identifier values for the V9.
+ *
+ * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
+ */
+
+/* V9 Architecture mandary ASIs. */
+#define ASI_N			0x04 /* Nucleus				*/
+#define ASI_NL			0x0c /* Nucleus, little endian		*/
+#define ASI_AIUP		0x10 /* Primary, user			*/
+#define ASI_AIUS		0x11 /* Secondary, user			*/
+#define ASI_AIUPL		0x18 /* Primary, user, little endian	*/
+#define ASI_AIUSL		0x19 /* Secondary, user, little endian	*/
+#define ASI_P			0x80 /* Primary, implicit		*/
+#define ASI_S			0x81 /* Secondary, implicit		*/
+#define ASI_PNF			0x82 /* Primary, no fault		*/
+#define ASI_SNF			0x83 /* Secondary, no fault		*/
+#define ASI_PL			0x88 /* Primary, implicit, l-endian	*/
+#define ASI_SL			0x89 /* Secondary, implicit, l-endian	*/
+#define ASI_PNFL		0x8a /* Primary, no fault, l-endian	*/
+#define ASI_SNFL		0x8b /* Secondary, no fault, l-endian	*/
+
+/* SpitFire and later extended ASIs.  The "(III)" marker designates
+ * UltraSparc-III and later specific ASIs.  The "(CMT)" marker designates
+ * Chip Multi Threading specific ASIs.  "(NG)" designates Niagara specific
+ * ASIs, "(4V)" designates SUN4V specific ASIs.
+ */
+#define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
+#define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
+#define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
+#define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
+#define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cachable, little endian*/
+#define ASI_PHYS_BYPASS_EC_E_L	0x1d /* PADDR, E-bit, little endian	*/
+#define ASI_BLK_AIUP_L_4V	0x1e /* (4V) Prim, user, block, l-endian*/
+#define ASI_BLK_AIUS_L_4V	0x1f /* (4V) Sec, user, block, l-endian	*/
+#define ASI_SCRATCHPAD		0x20 /* (4V) Scratch Pad Registers	*/
+#define ASI_MMU			0x21 /* (4V) MMU Context Registers	*/
+#define ASI_BLK_INIT_QUAD_LDD_AIUS 0x23 /* (NG) init-store, twin load,
+					 * secondary, user
+					 */
+#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cachable, qword load		*/
+#define ASI_QUEUE		0x25 /* (4V) Interrupt Queue Registers	*/
+#define ASI_QUAD_LDD_PHYS_4V	0x26 /* (4V) Physical, qword load	*/
+#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cachable, qword load, l-endian 	*/
+#define ASI_QUAD_LDD_PHYS_L_4V	0x2e /* (4V) Phys, qword load, l-endian	*/
+#define ASI_PCACHE_DATA_STATUS	0x30 /* (III) PCache data stat RAM diag	*/
+#define ASI_PCACHE_DATA		0x31 /* (III) PCache data RAM diag	*/
+#define ASI_PCACHE_TAG		0x32 /* (III) PCache tag RAM diag	*/
+#define ASI_PCACHE_SNOOP_TAG	0x33 /* (III) PCache snoop tag RAM diag	*/
+#define ASI_QUAD_LDD_PHYS	0x34 /* (III+) PADDR, qword load	*/
+#define ASI_WCACHE_VALID_BITS	0x38 /* (III) WCache Valid Bits diag	*/
+#define ASI_WCACHE_DATA		0x39 /* (III) WCache data RAM diag	*/
+#define ASI_WCACHE_TAG		0x3a /* (III) WCache tag RAM diag	*/
+#define ASI_WCACHE_SNOOP_TAG	0x3b /* (III) WCache snoop tag RAM diag	*/
+#define ASI_QUAD_LDD_PHYS_L	0x3c /* (III+) PADDR, qw-load, l-endian	*/
+#define ASI_SRAM_FAST_INIT	0x40 /* (III+) Fast SRAM init		*/
+#define ASI_CORE_AVAILABLE	0x41 /* (CMT) LP Available		*/
+#define ASI_CORE_ENABLE_STAT	0x41 /* (CMT) LP Enable Status		*/
+#define ASI_CORE_ENABLE		0x41 /* (CMT) LP Enable RW		*/
+#define ASI_XIR_STEERING	0x41 /* (CMT) XIR Steering RW		*/
+#define ASI_CORE_RUNNING_RW	0x41 /* (CMT) LP Running RW		*/
+#define ASI_CORE_RUNNING_W1S	0x41 /* (CMT) LP Running Write-One Set	*/
+#define ASI_CORE_RUNNING_W1C	0x41 /* (CMT) LP Running Write-One Clr	*/
+#define ASI_CORE_RUNNING_STAT	0x41 /* (CMT) LP Running Status		*/
+#define ASI_CMT_ERROR_STEERING	0x41 /* (CMT) Error Steering RW		*/
+#define ASI_DCACHE_INVALIDATE	0x42 /* (III) DCache Invalidate diag	*/
+#define ASI_DCACHE_UTAG		0x43 /* (III) DCache uTag diag		*/
+#define ASI_DCACHE_SNOOP_TAG	0x44 /* (III) DCache snoop tag RAM diag	*/
+#define ASI_LSU_CONTROL		0x45 /* Load-store control unit		*/
+#define ASI_DCU_CONTROL_REG	0x45 /* (III) DCache Unit Control reg	*/
+#define ASI_DCACHE_DATA		0x46 /* DCache data-ram diag access	*/
+#define ASI_DCACHE_TAG		0x47 /* Dcache tag/valid ram diag access*/
+#define ASI_INTR_DISPATCH_STAT	0x48 /* IRQ vector dispatch status	*/
+#define ASI_INTR_RECEIVE	0x49 /* IRQ vector receive status	*/
+#define ASI_UPA_CONFIG		0x4a /* UPA config space		*/
+#define ASI_JBUS_CONFIG		0x4a /* (IIIi) JBUS Config Register	*/
+#define ASI_SAFARI_CONFIG	0x4a /* (III) Safari Config Register	*/
+#define ASI_SAFARI_ADDRESS	0x4a /* (III) Safari Address Register	*/
+#define ASI_ESTATE_ERROR_EN	0x4b /* E-cache error enable space	*/
+#define ASI_AFSR		0x4c /* Async fault status register	*/
+#define ASI_AFAR		0x4d /* Async fault address register	*/
+#define ASI_EC_TAG_DATA		0x4e /* E-cache tag/valid ram diag acc	*/
+#define ASI_IMMU		0x50 /* Insn-MMU main register space	*/
+#define ASI_IMMU_TSB_8KB_PTR	0x51 /* Insn-MMU 8KB TSB pointer reg	*/
+#define ASI_IMMU_TSB_64KB_PTR	0x52 /* Insn-MMU 64KB TSB pointer reg	*/
+#define ASI_ITLB_DATA_IN	0x54 /* Insn-MMU TLB data in reg	*/
+#define ASI_ITLB_DATA_ACCESS	0x55 /* Insn-MMU TLB data access reg	*/
+#define ASI_ITLB_TAG_READ	0x56 /* Insn-MMU TLB tag read reg	*/
+#define ASI_IMMU_DEMAP		0x57 /* Insn-MMU TLB demap		*/
+#define ASI_DMMU		0x58 /* Data-MMU main register space	*/
+#define ASI_DMMU_TSB_8KB_PTR	0x59 /* Data-MMU 8KB TSB pointer reg	*/
+#define ASI_DMMU_TSB_64KB_PTR	0x5a /* Data-MMU 16KB TSB pointer reg	*/
+#define ASI_DMMU_TSB_DIRECT_PTR	0x5b /* Data-MMU TSB direct pointer reg	*/
+#define ASI_DTLB_DATA_IN	0x5c /* Data-MMU TLB data in reg	*/
+#define ASI_DTLB_DATA_ACCESS	0x5d /* Data-MMU TLB data access reg	*/
+#define ASI_DTLB_TAG_READ	0x5e /* Data-MMU TLB tag read reg	*/
+#define ASI_DMMU_DEMAP		0x5f /* Data-MMU TLB demap		*/
+#define ASI_IIU_INST_TRAP	0x60 /* (III) Instruction Breakpoint	*/
+#define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
+#define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
+#define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
+#define ASI_IC_INSTR		0x66 /* Insn cache instrucion ram diag	*/
+#define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
+#define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
+#define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
+#define ASI_IC_NEXT_FIELD	0x6f /* Insn cache next-field ram diag	*/
+#define ASI_BRPRED_ARRAY	0x6f /* (III) Branch Prediction RAM diag*/
+#define ASI_BLK_AIUP		0x70 /* Primary, user, block load/store	*/
+#define ASI_BLK_AIUS		0x71 /* Secondary, user, block ld/st	*/
+#define ASI_MCU_CTRL_REG	0x72 /* (III) Memory controller regs	*/
+#define ASI_EC_DATA		0x74 /* (III) E-cache data staging reg	*/
+#define ASI_EC_CTRL		0x75 /* (III) E-cache control reg	*/
+#define ASI_EC_W		0x76 /* E-cache diag write access	*/
+#define ASI_UDB_ERROR_W		0x77 /* External UDB error regs W	*/
+#define ASI_UDB_CONTROL_W	0x77 /* External UDB control regs W	*/
+#define ASI_INTR_W		0x77 /* IRQ vector dispatch write	*/
+#define ASI_INTR_DATAN_W	0x77 /* (III) Out irq vector data reg N	*/
+#define ASI_INTR_DISPATCH_W	0x77 /* (III) Interrupt vector dispatch	*/
+#define ASI_BLK_AIUPL		0x78 /* Primary, user, little, blk ld/st*/
+#define ASI_BLK_AIUSL		0x79 /* Secondary, user, little, blk ld/st*/
+#define ASI_EC_R		0x7e /* E-cache diag read access	*/
+#define ASI_UDBH_ERROR_R	0x7f /* External UDB error regs rd hi	*/
+#define ASI_UDBL_ERROR_R	0x7f /* External UDB error regs rd low	*/
+#define ASI_UDBH_CONTROL_R	0x7f /* External UDB control regs rd hi	*/
+#define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
+#define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
+#define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
+#define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
+#define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
+#define ASI_PST16_P		0xc2 /* Primary, 4 16-bit, partial	*/
+#define ASI_PST16_S		0xc3 /* Secondary, 4 16-bit, partial	*/
+#define ASI_PST32_P		0xc4 /* Primary, 2 32-bit, partial	*/
+#define ASI_PST32_S		0xc5 /* Secondary, 2 32-bit, partial	*/
+#define ASI_PST8_PL		0xc8 /* Primary, 8 8-bit, partial, L	*/
+#define ASI_PST8_SL		0xc9 /* Secondary, 8 8-bit, partial, L	*/
+#define ASI_PST16_PL		0xca /* Primary, 4 16-bit, partial, L	*/
+#define ASI_PST16_SL		0xcb /* Secondary, 4 16-bit, partial, L	*/
+#define ASI_PST32_PL		0xcc /* Primary, 2 32-bit, partial, L	*/
+#define ASI_PST32_SL		0xcd /* Secondary, 2 32-bit, partial, L	*/
+#define ASI_FL8_P		0xd0 /* Primary, 1 8-bit, fpu ld/st	*/
+#define ASI_FL8_S		0xd1 /* Secondary, 1 8-bit, fpu ld/st	*/
+#define ASI_FL16_P		0xd2 /* Primary, 1 16-bit, fpu ld/st	*/
+#define ASI_FL16_S		0xd3 /* Secondary, 1 16-bit, fpu ld/st	*/
+#define ASI_FL8_PL		0xd8 /* Primary, 1 8-bit, fpu ld/st, L	*/
+#define ASI_FL8_SL		0xd9 /* Secondary, 1 8-bit, fpu ld/st, L*/
+#define ASI_FL16_PL		0xda /* Primary, 1 16-bit, fpu ld/st, L	*/
+#define ASI_FL16_SL		0xdb /* Secondary, 1 16-bit, fpu ld/st,L*/
+#define ASI_BLK_COMMIT_P	0xe0 /* Primary, blk store commit	*/
+#define ASI_BLK_COMMIT_S	0xe1 /* Secondary, blk store commit	*/
+#define ASI_BLK_INIT_QUAD_LDD_P	0xe2 /* (NG) init-store, twin load,
+				      * primary, implicit
+				      */
+#define ASI_BLK_P		0xf0 /* Primary, blk ld/st		*/
+#define ASI_BLK_S		0xf1 /* Secondary, blk ld/st		*/
+#define ASI_BLK_PL		0xf8 /* Primary, blk ld/st, little	*/
+#define ASI_BLK_SL		0xf9 /* Secondary, blk ld/st, little	*/
+
+#endif /* _SPARC64_ASI_H */
diff --git a/include/asm-sparc/ipcbuf.h b/include/asm-sparc/ipcbuf.h
index 9bef02d..d5257da 100644
--- a/include/asm-sparc/ipcbuf.h
+++ b/include/asm-sparc/ipcbuf.h
@@ -1,31 +1,8 @@
-#ifndef _SPARC_IPCBUF_H
-#define _SPARC_IPCBUF_H
-
-/* 
- * The ipc64_perm structure for sparc architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 32-bit mode
- * - 32-bit seq
- * - 2 miscellaneous 64-bit values (so that this structure matches
- *				    sparc64 ipc64_perm)
- */
-
-struct ipc64_perm
-{
-	__kernel_key_t		key;
-	__kernel_uid32_t	uid;
-	__kernel_gid32_t	gid;
-	__kernel_uid32_t	cuid;
-	__kernel_gid32_t	cgid;
-	unsigned short		__pad1;
-	__kernel_mode_t		mode;
-	unsigned short		__pad2;
-	unsigned short		seq;
-	unsigned long long	__unused1;
-	unsigned long long	__unused2;
-};
-
-#endif /* _SPARC_IPCBUF_H */
+#ifndef _ASM_SPARC_IPCBUF_H
+#define _ASM_SPARC_IPCBUF_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/ipcbuf_64.h>
+#else
+#include <asm-sparc/ipcbuf_32.h>
+#endif
+#endif
diff --git a/include/asm-sparc/ipcbuf_32.h b/include/asm-sparc/ipcbuf_32.h
new file mode 100644
index 0000000..9bef02d
--- /dev/null
+++ b/include/asm-sparc/ipcbuf_32.h
@@ -0,0 +1,31 @@
+#ifndef _SPARC_IPCBUF_H
+#define _SPARC_IPCBUF_H
+
+/* 
+ * The ipc64_perm structure for sparc architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 32-bit mode
+ * - 32-bit seq
+ * - 2 miscellaneous 64-bit values (so that this structure matches
+ *				    sparc64 ipc64_perm)
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
+	unsigned short		__pad1;
+	__kernel_mode_t		mode;
+	unsigned short		__pad2;
+	unsigned short		seq;
+	unsigned long long	__unused1;
+	unsigned long long	__unused2;
+};
+
+#endif /* _SPARC_IPCBUF_H */
diff --git a/include/asm-sparc/ipcbuf_64.h b/include/asm-sparc/ipcbuf_64.h
new file mode 100644
index 0000000..9c5bf1b
--- /dev/null
+++ b/include/asm-sparc/ipcbuf_64.h
@@ -0,0 +1,28 @@
+#ifndef _SPARC64_IPCBUF_H
+#define _SPARC64_IPCBUF_H
+
+/* 
+ * The ipc64_perm structure for sparc64 architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 32-bit seq
+ * - 2 miscellaneous 64-bit values
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t	key;
+	__kernel_uid_t	uid;
+	__kernel_gid_t	gid;
+	__kernel_uid_t	cuid;
+	__kernel_gid_t	cgid;
+	__kernel_mode_t	mode; 
+	unsigned short	__pad1;
+	unsigned short	seq;
+	unsigned long	__unused1;
+	unsigned long	__unused2;
+};
+
+#endif /* _SPARC64_IPCBUF_H */
diff --git a/include/asm-sparc/openprom.h b/include/asm-sparc/openprom.h
index ed4b6bc..f4575b3 100644
--- a/include/asm-sparc/openprom.h
+++ b/include/asm-sparc/openprom.h
@@ -1,257 +1,8 @@
-#ifndef __SPARC_OPENPROM_H
-#define __SPARC_OPENPROM_H
-
-/* openprom.h:  Prom structures and defines for access to the OPENBOOT
- *              prom routines and data areas.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#include <asm/vaddrs.h>
-
-/* Empirical constants... */
-#define	LINUX_OPPROM_MAGIC      0x10010407
-
-#ifndef __ASSEMBLY__
-/* V0 prom device operations. */
-struct linux_dev_v0_funcs {
-	int (*v0_devopen)(char *device_str);
-	int (*v0_devclose)(int dev_desc);
-	int (*v0_rdblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
-	int (*v0_wrblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
-	int (*v0_wrnetdev)(int dev_desc, int num_bytes, char *buf);
-	int (*v0_rdnetdev)(int dev_desc, int num_bytes, char *buf);
-	int (*v0_rdchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
-	int (*v0_wrchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
-	int (*v0_seekdev)(int dev_desc, long logical_offst, int from);
-};
-
-/* V2 and later prom device operations. */
-struct linux_dev_v2_funcs {
-	int (*v2_inst2pkg)(int d);	/* Convert ihandle to phandle */
-	char * (*v2_dumb_mem_alloc)(char *va, unsigned sz);
-	void (*v2_dumb_mem_free)(char *va, unsigned sz);
-
-	/* To map devices into virtual I/O space. */
-	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned paddr, unsigned sz);
-	void (*v2_dumb_munmap)(char *virta, unsigned size);
-
-	int (*v2_dev_open)(char *devpath);
-	void (*v2_dev_close)(int d);
-	int (*v2_dev_read)(int d, char *buf, int nbytes);
-	int (*v2_dev_write)(int d, char *buf, int nbytes);
-	int (*v2_dev_seek)(int d, int hi, int lo);
-
-	/* Never issued (multistage load support) */
-	void (*v2_wheee2)(void);
-	void (*v2_wheee3)(void);
-};
-
-struct linux_mlist_v0 {
-	struct linux_mlist_v0 *theres_more;
-	char *start_adr;
-	unsigned num_bytes;
-};
-
-struct linux_mem_v0 {
-	struct linux_mlist_v0 **v0_totphys;
-	struct linux_mlist_v0 **v0_prommap;
-	struct linux_mlist_v0 **v0_available; /* What we can use */
-};
-
-/* Arguments sent to the kernel from the boot prompt. */
-struct linux_arguments_v0 {
-	char *argv[8];
-	char args[100];
-	char boot_dev[2];
-	int boot_dev_ctrl;
-	int boot_dev_unit;
-	int dev_partition;
-	char *kernel_file_name;
-	void *aieee1;           /* XXX */
-};
-
-/* V2 and up boot things. */
-struct linux_bootargs_v2 {
-	char **bootpath;
-	char **bootargs;
-	int *fd_stdin;
-	int *fd_stdout;
-};
-
-/* The top level PROM vector. */
-struct linux_romvec {
-	/* Version numbers. */
-	unsigned int pv_magic_cookie;
-	unsigned int pv_romvers;
-	unsigned int pv_plugin_revision;
-	unsigned int pv_printrev;
-
-	/* Version 0 memory descriptors. */
-	struct linux_mem_v0 pv_v0mem;
-
-	/* Node operations. */
-	struct linux_nodeops *pv_nodeops;
-
-	char **pv_bootstr;
-	struct linux_dev_v0_funcs pv_v0devops;
-
-	char *pv_stdin;
-	char *pv_stdout;
-#define	PROMDEV_KBD	0		/* input from keyboard */
-#define	PROMDEV_SCREEN	0		/* output to screen */
-#define	PROMDEV_TTYA	1		/* in/out to ttya */
-#define	PROMDEV_TTYB	2		/* in/out to ttyb */
-
-	/* Blocking getchar/putchar.  NOT REENTRANT! (grr) */
-	int (*pv_getchar)(void);
-	void (*pv_putchar)(int ch);
-
-	/* Non-blocking variants. */
-	int (*pv_nbgetchar)(void);
-	int (*pv_nbputchar)(int ch);
-
-	void (*pv_putstr)(char *str, int len);
-
-	/* Miscellany. */
-	void (*pv_reboot)(char *bootstr);
-	void (*pv_printf)(__const__ char *fmt, ...);
-	void (*pv_abort)(void);
-	__volatile__ int *pv_ticks;
-	void (*pv_halt)(void);
-	void (**pv_synchook)(void);
-
-	/* Evaluate a forth string, not different proto for V0 and V2->up. */
-	union {
-		void (*v0_eval)(int len, char *str);
-		void (*v2_eval)(char *str);
-	} pv_fortheval;
-
-	struct linux_arguments_v0 **pv_v0bootargs;
-
-	/* Get ether address. */
-	unsigned int (*pv_enaddr)(int d, char *enaddr);
-
-	struct linux_bootargs_v2 pv_v2bootargs;
-	struct linux_dev_v2_funcs pv_v2devops;
-
-	int filler[15];
-
-	/* This one is sun4c/sun4 only. */
-	void (*pv_setctxt)(int ctxt, char *va, int pmeg);
-
-	/* Prom version 3 Multiprocessor routines. This stuff is crazy.
-	 * No joke. Calling these when there is only one cpu probably
-	 * crashes the machine, have to test this. :-)
-	 */
-
-	/* v3_cpustart() will start the cpu 'whichcpu' in mmu-context
-	 * 'thiscontext' executing at address 'prog_counter'
-	 */
-	int (*v3_cpustart)(unsigned int whichcpu, int ctxtbl_ptr,
-			   int thiscontext, char *prog_counter);
-
-	/* v3_cpustop() will cause cpu 'whichcpu' to stop executing
-	 * until a resume cpu call is made.
-	 */
-	int (*v3_cpustop)(unsigned int whichcpu);
-
-	/* v3_cpuidle() will idle cpu 'whichcpu' until a stop or
-	 * resume cpu call is made.
-	 */
-	int (*v3_cpuidle)(unsigned int whichcpu);
-
-	/* v3_cpuresume() will resume processor 'whichcpu' executing
-	 * starting with whatever 'pc' and 'npc' were left at the
-	 * last 'idle' or 'stop' call.
-	 */
-	int (*v3_cpuresume)(unsigned int whichcpu);
-};
-
-/* Routines for traversing the prom device tree. */
-struct linux_nodeops {
-	int (*no_nextnode)(int node);
-	int (*no_child)(int node);
-	int (*no_proplen)(int node, char *name);
-	int (*no_getprop)(int node, char *name, char *val);
-	int (*no_setprop)(int node, char *name, char *val, int len);
-	char * (*no_nextprop)(int node, char *name);
-};
-
-/* More fun PROM structures for device probing. */
-#define PROMREG_MAX     16
-#define PROMVADDR_MAX   16
-#define PROMINTR_MAX    15
-
-struct linux_prom_registers {
-	unsigned int which_io;         /* is this in OBIO space? */
-	unsigned int phys_addr;        /* The physical address of this register */
-	unsigned int reg_size;         /* How many bytes does this register take up? */
-};
-
-struct linux_prom_irqs {
-	int pri;    /* IRQ priority */
-	int vector; /* This is foobar, what does it do? */
-};
-
-/* Element of the "ranges" vector */
-struct linux_prom_ranges {
-	unsigned int ot_child_space;
-	unsigned int ot_child_base;		/* Bus feels this */
-	unsigned int ot_parent_space;
-	unsigned int ot_parent_base;		/* CPU looks from here */
-	unsigned int or_size;
-};
-
-/* Ranges and reg properties are a bit different for PCI. */
-struct linux_prom_pci_registers {
-	/* 
-	 * We don't know what information this field contain.
-	 * We guess, PCI device function is in bits 15:8
-	 * So, ...
-	 */
-	unsigned int which_io;  /* Let it be which_io */
-
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_ranges {
-	unsigned int child_phys_hi;	/* Only certain bits are encoded here. */
-	unsigned int child_phys_mid;
-	unsigned int child_phys_lo;
-
-	unsigned int parent_phys_hi;
-	unsigned int parent_phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_assigned_addresses {
-	unsigned int which_io;
-
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_ebus_ranges {
-	unsigned int child_phys_hi;
-	unsigned int child_phys_lo;
-
-	unsigned int parent_phys_hi;
-	unsigned int parent_phys_mid;
-	unsigned int parent_phys_lo;
-
-	unsigned int size;
-};
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(__SPARC_OPENPROM_H) */
+#ifndef _ASM_SPARC_OPENPROM_H
+#define _ASM_SPARC_OPENPROM_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/openprom_64.h>
+#else
+#include <asm-sparc/openprom_32.h>
+#endif
+#endif
diff --git a/include/asm-sparc/openprom_32.h b/include/asm-sparc/openprom_32.h
new file mode 100644
index 0000000..ed4b6bc
--- /dev/null
+++ b/include/asm-sparc/openprom_32.h
@@ -0,0 +1,257 @@
+#ifndef __SPARC_OPENPROM_H
+#define __SPARC_OPENPROM_H
+
+/* openprom.h:  Prom structures and defines for access to the OPENBOOT
+ *              prom routines and data areas.
+ *
+ * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
+ */
+
+#include <asm/vaddrs.h>
+
+/* Empirical constants... */
+#define	LINUX_OPPROM_MAGIC      0x10010407
+
+#ifndef __ASSEMBLY__
+/* V0 prom device operations. */
+struct linux_dev_v0_funcs {
+	int (*v0_devopen)(char *device_str);
+	int (*v0_devclose)(int dev_desc);
+	int (*v0_rdblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
+	int (*v0_wrblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
+	int (*v0_wrnetdev)(int dev_desc, int num_bytes, char *buf);
+	int (*v0_rdnetdev)(int dev_desc, int num_bytes, char *buf);
+	int (*v0_rdchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
+	int (*v0_wrchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
+	int (*v0_seekdev)(int dev_desc, long logical_offst, int from);
+};
+
+/* V2 and later prom device operations. */
+struct linux_dev_v2_funcs {
+	int (*v2_inst2pkg)(int d);	/* Convert ihandle to phandle */
+	char * (*v2_dumb_mem_alloc)(char *va, unsigned sz);
+	void (*v2_dumb_mem_free)(char *va, unsigned sz);
+
+	/* To map devices into virtual I/O space. */
+	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned paddr, unsigned sz);
+	void (*v2_dumb_munmap)(char *virta, unsigned size);
+
+	int (*v2_dev_open)(char *devpath);
+	void (*v2_dev_close)(int d);
+	int (*v2_dev_read)(int d, char *buf, int nbytes);
+	int (*v2_dev_write)(int d, char *buf, int nbytes);
+	int (*v2_dev_seek)(int d, int hi, int lo);
+
+	/* Never issued (multistage load support) */
+	void (*v2_wheee2)(void);
+	void (*v2_wheee3)(void);
+};
+
+struct linux_mlist_v0 {
+	struct linux_mlist_v0 *theres_more;
+	char *start_adr;
+	unsigned num_bytes;
+};
+
+struct linux_mem_v0 {
+	struct linux_mlist_v0 **v0_totphys;
+	struct linux_mlist_v0 **v0_prommap;
+	struct linux_mlist_v0 **v0_available; /* What we can use */
+};
+
+/* Arguments sent to the kernel from the boot prompt. */
+struct linux_arguments_v0 {
+	char *argv[8];
+	char args[100];
+	char boot_dev[2];
+	int boot_dev_ctrl;
+	int boot_dev_unit;
+	int dev_partition;
+	char *kernel_file_name;
+	void *aieee1;           /* XXX */
+};
+
+/* V2 and up boot things. */
+struct linux_bootargs_v2 {
+	char **bootpath;
+	char **bootargs;
+	int *fd_stdin;
+	int *fd_stdout;
+};
+
+/* The top level PROM vector. */
+struct linux_romvec {
+	/* Version numbers. */
+	unsigned int pv_magic_cookie;
+	unsigned int pv_romvers;
+	unsigned int pv_plugin_revision;
+	unsigned int pv_printrev;
+
+	/* Version 0 memory descriptors. */
+	struct linux_mem_v0 pv_v0mem;
+
+	/* Node operations. */
+	struct linux_nodeops *pv_nodeops;
+
+	char **pv_bootstr;
+	struct linux_dev_v0_funcs pv_v0devops;
+
+	char *pv_stdin;
+	char *pv_stdout;
+#define	PROMDEV_KBD	0		/* input from keyboard */
+#define	PROMDEV_SCREEN	0		/* output to screen */
+#define	PROMDEV_TTYA	1		/* in/out to ttya */
+#define	PROMDEV_TTYB	2		/* in/out to ttyb */
+
+	/* Blocking getchar/putchar.  NOT REENTRANT! (grr) */
+	int (*pv_getchar)(void);
+	void (*pv_putchar)(int ch);
+
+	/* Non-blocking variants. */
+	int (*pv_nbgetchar)(void);
+	int (*pv_nbputchar)(int ch);
+
+	void (*pv_putstr)(char *str, int len);
+
+	/* Miscellany. */
+	void (*pv_reboot)(char *bootstr);
+	void (*pv_printf)(__const__ char *fmt, ...);
+	void (*pv_abort)(void);
+	__volatile__ int *pv_ticks;
+	void (*pv_halt)(void);
+	void (**pv_synchook)(void);
+
+	/* Evaluate a forth string, not different proto for V0 and V2->up. */
+	union {
+		void (*v0_eval)(int len, char *str);
+		void (*v2_eval)(char *str);
+	} pv_fortheval;
+
+	struct linux_arguments_v0 **pv_v0bootargs;
+
+	/* Get ether address. */
+	unsigned int (*pv_enaddr)(int d, char *enaddr);
+
+	struct linux_bootargs_v2 pv_v2bootargs;
+	struct linux_dev_v2_funcs pv_v2devops;
+
+	int filler[15];
+
+	/* This one is sun4c/sun4 only. */
+	void (*pv_setctxt)(int ctxt, char *va, int pmeg);
+
+	/* Prom version 3 Multiprocessor routines. This stuff is crazy.
+	 * No joke. Calling these when there is only one cpu probably
+	 * crashes the machine, have to test this. :-)
+	 */
+
+	/* v3_cpustart() will start the cpu 'whichcpu' in mmu-context
+	 * 'thiscontext' executing at address 'prog_counter'
+	 */
+	int (*v3_cpustart)(unsigned int whichcpu, int ctxtbl_ptr,
+			   int thiscontext, char *prog_counter);
+
+	/* v3_cpustop() will cause cpu 'whichcpu' to stop executing
+	 * until a resume cpu call is made.
+	 */
+	int (*v3_cpustop)(unsigned int whichcpu);
+
+	/* v3_cpuidle() will idle cpu 'whichcpu' until a stop or
+	 * resume cpu call is made.
+	 */
+	int (*v3_cpuidle)(unsigned int whichcpu);
+
+	/* v3_cpuresume() will resume processor 'whichcpu' executing
+	 * starting with whatever 'pc' and 'npc' were left at the
+	 * last 'idle' or 'stop' call.
+	 */
+	int (*v3_cpuresume)(unsigned int whichcpu);
+};
+
+/* Routines for traversing the prom device tree. */
+struct linux_nodeops {
+	int (*no_nextnode)(int node);
+	int (*no_child)(int node);
+	int (*no_proplen)(int node, char *name);
+	int (*no_getprop)(int node, char *name, char *val);
+	int (*no_setprop)(int node, char *name, char *val, int len);
+	char * (*no_nextprop)(int node, char *name);
+};
+
+/* More fun PROM structures for device probing. */
+#define PROMREG_MAX     16
+#define PROMVADDR_MAX   16
+#define PROMINTR_MAX    15
+
+struct linux_prom_registers {
+	unsigned int which_io;         /* is this in OBIO space? */
+	unsigned int phys_addr;        /* The physical address of this register */
+	unsigned int reg_size;         /* How many bytes does this register take up? */
+};
+
+struct linux_prom_irqs {
+	int pri;    /* IRQ priority */
+	int vector; /* This is foobar, what does it do? */
+};
+
+/* Element of the "ranges" vector */
+struct linux_prom_ranges {
+	unsigned int ot_child_space;
+	unsigned int ot_child_base;		/* Bus feels this */
+	unsigned int ot_parent_space;
+	unsigned int ot_parent_base;		/* CPU looks from here */
+	unsigned int or_size;
+};
+
+/* Ranges and reg properties are a bit different for PCI. */
+struct linux_prom_pci_registers {
+	/* 
+	 * We don't know what information this field contain.
+	 * We guess, PCI device function is in bits 15:8
+	 * So, ...
+	 */
+	unsigned int which_io;  /* Let it be which_io */
+
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
+struct linux_prom_pci_ranges {
+	unsigned int child_phys_hi;	/* Only certain bits are encoded here. */
+	unsigned int child_phys_mid;
+	unsigned int child_phys_lo;
+
+	unsigned int parent_phys_hi;
+	unsigned int parent_phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
+struct linux_prom_pci_assigned_addresses {
+	unsigned int which_io;
+
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
+struct linux_prom_ebus_ranges {
+	unsigned int child_phys_hi;
+	unsigned int child_phys_lo;
+
+	unsigned int parent_phys_hi;
+	unsigned int parent_phys_mid;
+	unsigned int parent_phys_lo;
+
+	unsigned int size;
+};
+
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* !(__SPARC_OPENPROM_H) */
diff --git a/include/asm-sparc/openprom_64.h b/include/asm-sparc/openprom_64.h
new file mode 100644
index 0000000..b69e4a8
--- /dev/null
+++ b/include/asm-sparc/openprom_64.h
@@ -0,0 +1,280 @@
+#ifndef __SPARC64_OPENPROM_H
+#define __SPARC64_OPENPROM_H
+
+/* openprom.h:  Prom structures and defines for access to the OPENBOOT
+ *              prom routines and data areas.
+ *
+ * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
+ */
+
+#ifndef __ASSEMBLY__
+/* V0 prom device operations. */
+struct linux_dev_v0_funcs {
+	int (*v0_devopen)(char *device_str);
+	int (*v0_devclose)(int dev_desc);
+	int (*v0_rdblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
+	int (*v0_wrblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
+	int (*v0_wrnetdev)(int dev_desc, int num_bytes, char *buf);
+	int (*v0_rdnetdev)(int dev_desc, int num_bytes, char *buf);
+	int (*v0_rdchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
+	int (*v0_wrchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
+	int (*v0_seekdev)(int dev_desc, long logical_offst, int from);
+};
+
+/* V2 and later prom device operations. */
+struct linux_dev_v2_funcs {
+	int (*v2_inst2pkg)(int d);	/* Convert ihandle to phandle */
+	char * (*v2_dumb_mem_alloc)(char *va, unsigned sz);
+	void (*v2_dumb_mem_free)(char *va, unsigned sz);
+
+	/* To map devices into virtual I/O space. */
+	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned paddr, unsigned sz);
+	void (*v2_dumb_munmap)(char *virta, unsigned size);
+
+	int (*v2_dev_open)(char *devpath);
+	void (*v2_dev_close)(int d);
+	int (*v2_dev_read)(int d, char *buf, int nbytes);
+	int (*v2_dev_write)(int d, char *buf, int nbytes);
+	int (*v2_dev_seek)(int d, int hi, int lo);
+
+	/* Never issued (multistage load support) */
+	void (*v2_wheee2)(void);
+	void (*v2_wheee3)(void);
+};
+
+struct linux_mlist_v0 {
+	struct linux_mlist_v0 *theres_more;
+	unsigned start_adr;
+	unsigned num_bytes;
+};
+
+struct linux_mem_v0 {
+	struct linux_mlist_v0 **v0_totphys;
+	struct linux_mlist_v0 **v0_prommap;
+	struct linux_mlist_v0 **v0_available; /* What we can use */
+};
+
+/* Arguments sent to the kernel from the boot prompt. */
+struct linux_arguments_v0 {
+	char *argv[8];
+	char args[100];
+	char boot_dev[2];
+	int boot_dev_ctrl;
+	int boot_dev_unit;
+	int dev_partition;
+	char *kernel_file_name;
+	void *aieee1;           /* XXX */
+};
+
+/* V2 and up boot things. */
+struct linux_bootargs_v2 {
+	char **bootpath;
+	char **bootargs;
+	int *fd_stdin;
+	int *fd_stdout;
+};
+
+/* The top level PROM vector. */
+struct linux_romvec {
+	/* Version numbers. */
+	unsigned int pv_magic_cookie;
+	unsigned int pv_romvers;
+	unsigned int pv_plugin_revision;
+	unsigned int pv_printrev;
+
+	/* Version 0 memory descriptors. */
+	struct linux_mem_v0 pv_v0mem;
+
+	/* Node operations. */
+	struct linux_nodeops *pv_nodeops;
+
+	char **pv_bootstr;
+	struct linux_dev_v0_funcs pv_v0devops;
+
+	char *pv_stdin;
+	char *pv_stdout;
+#define	PROMDEV_KBD	0		/* input from keyboard */
+#define	PROMDEV_SCREEN	0		/* output to screen */
+#define	PROMDEV_TTYA	1		/* in/out to ttya */
+#define	PROMDEV_TTYB	2		/* in/out to ttyb */
+
+	/* Blocking getchar/putchar.  NOT REENTRANT! (grr) */
+	int (*pv_getchar)(void);
+	void (*pv_putchar)(int ch);
+
+	/* Non-blocking variants. */
+	int (*pv_nbgetchar)(void);
+	int (*pv_nbputchar)(int ch);
+
+	void (*pv_putstr)(char *str, int len);
+
+	/* Miscellany. */
+	void (*pv_reboot)(char *bootstr);
+	void (*pv_printf)(__const__ char *fmt, ...);
+	void (*pv_abort)(void);
+	__volatile__ int *pv_ticks;
+	void (*pv_halt)(void);
+	void (**pv_synchook)(void);
+
+	/* Evaluate a forth string, not different proto for V0 and V2->up. */
+	union {
+		void (*v0_eval)(int len, char *str);
+		void (*v2_eval)(char *str);
+	} pv_fortheval;
+
+	struct linux_arguments_v0 **pv_v0bootargs;
+
+	/* Get ether address. */
+	unsigned int (*pv_enaddr)(int d, char *enaddr);
+
+	struct linux_bootargs_v2 pv_v2bootargs;
+	struct linux_dev_v2_funcs pv_v2devops;
+
+	int filler[15];
+
+	/* This one is sun4c/sun4 only. */
+	void (*pv_setctxt)(int ctxt, char *va, int pmeg);
+
+	/* Prom version 3 Multiprocessor routines. This stuff is crazy.
+	 * No joke. Calling these when there is only one cpu probably
+	 * crashes the machine, have to test this. :-)
+	 */
+
+	/* v3_cpustart() will start the cpu 'whichcpu' in mmu-context
+	 * 'thiscontext' executing at address 'prog_counter'
+	 */
+	int (*v3_cpustart)(unsigned int whichcpu, int ctxtbl_ptr,
+			   int thiscontext, char *prog_counter);
+
+	/* v3_cpustop() will cause cpu 'whichcpu' to stop executing
+	 * until a resume cpu call is made.
+	 */
+	int (*v3_cpustop)(unsigned int whichcpu);
+
+	/* v3_cpuidle() will idle cpu 'whichcpu' until a stop or
+	 * resume cpu call is made.
+	 */
+	int (*v3_cpuidle)(unsigned int whichcpu);
+
+	/* v3_cpuresume() will resume processor 'whichcpu' executing
+	 * starting with whatever 'pc' and 'npc' were left at the
+	 * last 'idle' or 'stop' call.
+	 */
+	int (*v3_cpuresume)(unsigned int whichcpu);
+};
+
+/* Routines for traversing the prom device tree. */
+struct linux_nodeops {
+	int (*no_nextnode)(int node);
+	int (*no_child)(int node);
+	int (*no_proplen)(int node, char *name);
+	int (*no_getprop)(int node, char *name, char *val);
+	int (*no_setprop)(int node, char *name, char *val, int len);
+	char * (*no_nextprop)(int node, char *name);
+};
+
+/* More fun PROM structures for device probing. */
+#define PROMREG_MAX     24
+#define PROMVADDR_MAX   16
+#define PROMINTR_MAX    32
+
+struct linux_prom_registers {
+	unsigned which_io;	/* hi part of physical address			*/
+	unsigned phys_addr;	/* The physical address of this register	*/
+	int reg_size;		/* How many bytes does this register take up?	*/
+};
+
+struct linux_prom64_registers {
+	unsigned long phys_addr;
+	unsigned long reg_size;
+};
+
+struct linux_prom_irqs {
+	int pri;    /* IRQ priority */
+	int vector; /* This is foobar, what does it do? */
+};
+
+/* Element of the "ranges" vector */
+struct linux_prom_ranges {
+	unsigned int ot_child_space;
+	unsigned int ot_child_base;		/* Bus feels this */
+	unsigned int ot_parent_space;
+	unsigned int ot_parent_base;		/* CPU looks from here */
+	unsigned int or_size;
+};
+
+struct linux_prom64_ranges {
+	unsigned long ot_child_base;		/* Bus feels this */
+	unsigned long ot_parent_base;		/* CPU looks from here */
+	unsigned long or_size;
+};
+
+/* Ranges and reg properties are a bit different for PCI. */
+struct linux_prom_pci_registers {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
+struct linux_prom_pci_ranges {
+	unsigned int child_phys_hi;	/* Only certain bits are encoded here. */
+	unsigned int child_phys_mid;
+	unsigned int child_phys_lo;
+
+	unsigned int parent_phys_hi;
+	unsigned int parent_phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
+struct linux_prom_pci_intmap {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+
+	unsigned int interrupt;
+
+	int          cnode;
+	unsigned int cinterrupt;
+};
+
+struct linux_prom_pci_intmask {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+	unsigned int interrupt;
+};
+
+struct linux_prom_ebus_ranges {
+	unsigned int child_phys_hi;
+	unsigned int child_phys_lo;
+
+	unsigned int parent_phys_hi;
+	unsigned int parent_phys_mid;
+	unsigned int parent_phys_lo;
+
+	unsigned int size;
+};
+
+struct linux_prom_ebus_intmap {
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+
+	unsigned int interrupt;
+
+	int          cnode;
+	unsigned int cinterrupt;
+};
+
+struct linux_prom_ebus_intmask {
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+	unsigned int interrupt;
+};
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* !(__SPARC64_OPENPROM_H) */
diff --git a/include/asm-sparc/posix_types.h b/include/asm-sparc/posix_types.h
index dcc07eb..024095e 100644
--- a/include/asm-sparc/posix_types.h
+++ b/include/asm-sparc/posix_types.h
@@ -1,118 +1,8 @@
-#ifndef __ARCH_SPARC_POSIX_TYPES_H
-#define __ARCH_SPARC_POSIX_TYPES_H
-
-/*
- * This file is generally used by user-level software, so you need to
- * be a little careful about namespace pollution etc.  Also, we cannot
- * assume GCC is being used.
- */
-
-typedef unsigned int           __kernel_size_t;
-typedef int                    __kernel_ssize_t;
-typedef long int               __kernel_ptrdiff_t;
-typedef long                   __kernel_time_t;
-typedef long		       __kernel_suseconds_t;
-typedef long                   __kernel_clock_t;
-typedef int                    __kernel_pid_t;
-typedef unsigned short         __kernel_ipc_pid_t;
-typedef unsigned short         __kernel_uid_t;
-typedef unsigned short         __kernel_gid_t;
-typedef unsigned long          __kernel_ino_t;
-typedef unsigned short         __kernel_mode_t;
-typedef unsigned short         __kernel_umode_t;
-typedef short                  __kernel_nlink_t;
-typedef long                   __kernel_daddr_t;
-typedef long                   __kernel_off_t;
-typedef char *                 __kernel_caddr_t;
-typedef unsigned short	       __kernel_uid16_t;
-typedef unsigned short	       __kernel_gid16_t;
-typedef unsigned int	       __kernel_uid32_t;
-typedef unsigned int	       __kernel_gid32_t;
-typedef unsigned short	       __kernel_old_uid_t;
-typedef unsigned short	       __kernel_old_gid_t;
-typedef unsigned short	       __kernel_old_dev_t;
-typedef int                    __kernel_clockid_t;
-typedef int                    __kernel_timer_t;
-
-#ifdef __GNUC__
-typedef long long	__kernel_loff_t;
+#ifndef _ASM_SPARC_POSIX_TYPES_H
+#define _ASM_SPARC_POSIX_TYPES_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/posix_types_64.h>
+#else
+#include <asm-sparc/posix_types_32.h>
+#endif
 #endif
-
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-
-#if defined(__KERNEL__)
-
-#undef __FD_SET
-static inline void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static inline void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static inline int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
-{ 
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant cases (8 or 32 longs,
- * for 256 and 1024-bit fd_sets respectively)
- */
-#undef __FD_ZERO
-static inline void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 32:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
-			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
-			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
-			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
-			  return;
-			case 16:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  return;
-			case 8:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  return;
-			case 4:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) */
-
-#endif /* !(__ARCH_SPARC_POSIX_TYPES_H) */
diff --git a/include/asm-sparc/posix_types_32.h b/include/asm-sparc/posix_types_32.h
new file mode 100644
index 0000000..dcc07eb
--- /dev/null
+++ b/include/asm-sparc/posix_types_32.h
@@ -0,0 +1,118 @@
+#ifndef __ARCH_SPARC_POSIX_TYPES_H
+#define __ARCH_SPARC_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc.  Also, we cannot
+ * assume GCC is being used.
+ */
+
+typedef unsigned int           __kernel_size_t;
+typedef int                    __kernel_ssize_t;
+typedef long int               __kernel_ptrdiff_t;
+typedef long                   __kernel_time_t;
+typedef long		       __kernel_suseconds_t;
+typedef long                   __kernel_clock_t;
+typedef int                    __kernel_pid_t;
+typedef unsigned short         __kernel_ipc_pid_t;
+typedef unsigned short         __kernel_uid_t;
+typedef unsigned short         __kernel_gid_t;
+typedef unsigned long          __kernel_ino_t;
+typedef unsigned short         __kernel_mode_t;
+typedef unsigned short         __kernel_umode_t;
+typedef short                  __kernel_nlink_t;
+typedef long                   __kernel_daddr_t;
+typedef long                   __kernel_off_t;
+typedef char *                 __kernel_caddr_t;
+typedef unsigned short	       __kernel_uid16_t;
+typedef unsigned short	       __kernel_gid16_t;
+typedef unsigned int	       __kernel_uid32_t;
+typedef unsigned int	       __kernel_gid32_t;
+typedef unsigned short	       __kernel_old_uid_t;
+typedef unsigned short	       __kernel_old_gid_t;
+typedef unsigned short	       __kernel_old_dev_t;
+typedef int                    __kernel_clockid_t;
+typedef int                    __kernel_timer_t;
+
+#ifdef __GNUC__
+typedef long long	__kernel_loff_t;
+#endif
+
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+
+#if defined(__KERNEL__)
+
+#undef __FD_SET
+static inline void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
+}
+
+#undef __FD_CLR
+static inline void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
+}
+
+#undef __FD_ISSET
+static inline int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
+{ 
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
+}
+
+/*
+ * This will unroll the loop for the normal constant cases (8 or 32 longs,
+ * for 256 and 1024-bit fd_sets respectively)
+ */
+#undef __FD_ZERO
+static inline void __FD_ZERO(__kernel_fd_set *p)
+{
+	unsigned long *tmp = p->fds_bits;
+	int i;
+
+	if (__builtin_constant_p(__FDSET_LONGS)) {
+		switch (__FDSET_LONGS) {
+			case 32:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
+			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
+			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
+			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
+			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
+			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
+			  return;
+			case 16:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
+			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
+			  return;
+			case 8:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  return;
+			case 4:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  return;
+		}
+	}
+	i = __FDSET_LONGS;
+	while (i) {
+		i--;
+		*tmp = 0;
+		tmp++;
+	}
+}
+
+#endif /* defined(__KERNEL__) */
+
+#endif /* !(__ARCH_SPARC_POSIX_TYPES_H) */
diff --git a/include/asm-sparc/posix_types_64.h b/include/asm-sparc/posix_types_64.h
new file mode 100644
index 0000000..4eaaa01
--- /dev/null
+++ b/include/asm-sparc/posix_types_64.h
@@ -0,0 +1,122 @@
+#ifndef __ARCH_SPARC64_POSIX_TYPES_H
+#define __ARCH_SPARC64_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc.  Also, we cannot
+ * assume GCC is being used.
+ */
+
+typedef unsigned long          __kernel_size_t;
+typedef long                   __kernel_ssize_t;
+typedef long                   __kernel_ptrdiff_t;
+typedef long                   __kernel_time_t;
+typedef long                   __kernel_clock_t;
+typedef int                    __kernel_pid_t;
+typedef int                    __kernel_ipc_pid_t;
+typedef unsigned int           __kernel_uid_t;
+typedef unsigned int           __kernel_gid_t;
+typedef unsigned long          __kernel_ino_t;
+typedef unsigned int           __kernel_mode_t;
+typedef unsigned short         __kernel_umode_t;
+typedef unsigned int           __kernel_nlink_t;
+typedef int                    __kernel_daddr_t;
+typedef long                   __kernel_off_t;
+typedef char *                 __kernel_caddr_t;
+typedef unsigned short	       __kernel_uid16_t;
+typedef unsigned short	       __kernel_gid16_t;
+typedef int                    __kernel_clockid_t;
+typedef int                    __kernel_timer_t;
+
+typedef unsigned short 	       __kernel_old_uid_t;
+typedef unsigned short         __kernel_old_gid_t;
+typedef __kernel_uid_t	       __kernel_uid32_t;
+typedef __kernel_gid_t	       __kernel_gid32_t;
+
+typedef unsigned int	       __kernel_old_dev_t;
+
+/* Note this piece of asymmetry from the v9 ABI.  */
+typedef int		       __kernel_suseconds_t;
+
+#ifdef __GNUC__
+typedef long long              __kernel_loff_t;
+#endif
+
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+
+#if defined(__KERNEL__)
+
+#undef __FD_SET
+static inline void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
+}
+
+#undef __FD_CLR
+static inline void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
+}
+
+#undef __FD_ISSET
+static inline int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
+{ 
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
+}
+
+/*
+ * This will unroll the loop for the normal constant cases (8 or 32 longs,
+ * for 256 and 1024-bit fd_sets respectively)
+ */
+#undef __FD_ZERO
+static inline void __FD_ZERO(__kernel_fd_set *p)
+{
+	unsigned long *tmp = p->fds_bits;
+	int i;
+
+	if (__builtin_constant_p(__FDSET_LONGS)) {
+		switch (__FDSET_LONGS) {
+			case 32:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
+			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
+			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
+			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
+			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
+			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
+			  return;
+			case 16:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
+			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
+			  return;
+			case 8:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  return;
+			case 4:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  return;
+		}
+	}
+	i = __FDSET_LONGS;
+	while (i) {
+		i--;
+		*tmp = 0;
+		tmp++;
+	}
+}
+
+#endif /* defined(__KERNEL__) */
+
+#endif /* !(__ARCH_SPARC64_POSIX_TYPES_H) */
diff --git a/include/asm-sparc/ptrace.h b/include/asm-sparc/ptrace.h
index 11f3bc2..d6b9e24 100644
--- a/include/asm-sparc/ptrace.h
+++ b/include/asm-sparc/ptrace.h
@@ -1,175 +1,8 @@
-#ifndef _SPARC_PTRACE_H
-#define _SPARC_PTRACE_H
-
-#include <asm/psr.h>
-
-/* This struct defines the way the registers are stored on the 
- * stack during a system call and basically all traps.
- */
-
-#ifndef __ASSEMBLY__
-
-#include <linux/types.h>
-
-struct pt_regs {
-	unsigned long psr;
-	unsigned long pc;
-	unsigned long npc;
-	unsigned long y;
-	unsigned long u_regs[16]; /* globals and ins */
-};
-
-#define UREG_G0        0
-#define UREG_G1        1
-#define UREG_G2        2
-#define UREG_G3        3
-#define UREG_G4        4
-#define UREG_G5        5
-#define UREG_G6        6
-#define UREG_G7        7
-#define UREG_I0        8
-#define UREG_I1        9
-#define UREG_I2        10
-#define UREG_I3        11
-#define UREG_I4        12
-#define UREG_I5        13
-#define UREG_I6        14
-#define UREG_I7        15
-#define UREG_WIM       UREG_G0
-#define UREG_FADDR     UREG_G0
-#define UREG_FP        UREG_I6
-#define UREG_RETPC     UREG_I7
-
-static inline bool pt_regs_is_syscall(struct pt_regs *regs)
-{
-	return (regs->psr & PSR_SYSCALL);
-}
-
-static inline bool pt_regs_clear_syscall(struct pt_regs *regs)
-{
-	return (regs->psr &= ~PSR_SYSCALL);
-}
-
-/* A register window */
-struct reg_window {
-	unsigned long locals[8];
-	unsigned long ins[8];
-};
-
-/* A Sparc stack frame */
-struct sparc_stackf {
-	unsigned long locals[8];
-        unsigned long ins[6];
-	struct sparc_stackf *fp;
-	unsigned long callers_pc;
-	char *structptr;
-	unsigned long xargs[6];
-	unsigned long xxargs[1];
-};	
-
-#define TRACEREG_SZ   sizeof(struct pt_regs)
-#define STACKFRAME_SZ sizeof(struct sparc_stackf)
-
-#ifdef __KERNEL__
-
-#define user_mode(regs) (!((regs)->psr & PSR_PS))
-#define instruction_pointer(regs) ((regs)->pc)
-unsigned long profile_pc(struct pt_regs *);
-extern void show_regs(struct pt_regs *);
+#ifndef _ASM_SPARC_PTRACE_H
+#define _ASM_SPARC_PTRACE_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/ptrace_64.h>
+#else
+#include <asm-sparc/ptrace_32.h>
 #endif
-
-#else /* __ASSEMBLY__ */
-/* For assembly code. */
-#define TRACEREG_SZ       0x50
-#define STACKFRAME_SZ     0x60
 #endif
-
-/*
- * The asm-offsets.h is a generated file, so we cannot include it.
- * It may be OK for glibc headers, but it's utterly pointless for C code.
- * The assembly code using those offsets has to include it explicitly.
- */
-/* #include <asm/asm-offsets.h> */
-
-/* These are for pt_regs. */
-#define PT_PSR    0x0
-#define PT_PC     0x4
-#define PT_NPC    0x8
-#define PT_Y      0xc
-#define PT_G0     0x10
-#define PT_WIM    PT_G0
-#define PT_G1     0x14
-#define PT_G2     0x18
-#define PT_G3     0x1c
-#define PT_G4     0x20
-#define PT_G5     0x24
-#define PT_G6     0x28
-#define PT_G7     0x2c
-#define PT_I0     0x30
-#define PT_I1     0x34
-#define PT_I2     0x38
-#define PT_I3     0x3c
-#define PT_I4     0x40
-#define PT_I5     0x44
-#define PT_I6     0x48
-#define PT_FP     PT_I6
-#define PT_I7     0x4c
-
-/* Reg_window offsets */
-#define RW_L0     0x00
-#define RW_L1     0x04
-#define RW_L2     0x08
-#define RW_L3     0x0c
-#define RW_L4     0x10
-#define RW_L5     0x14
-#define RW_L6     0x18
-#define RW_L7     0x1c
-#define RW_I0     0x20
-#define RW_I1     0x24
-#define RW_I2     0x28
-#define RW_I3     0x2c
-#define RW_I4     0x30
-#define RW_I5     0x34
-#define RW_I6     0x38
-#define RW_I7     0x3c
-
-/* Stack_frame offsets */
-#define SF_L0     0x00
-#define SF_L1     0x04
-#define SF_L2     0x08
-#define SF_L3     0x0c
-#define SF_L4     0x10
-#define SF_L5     0x14
-#define SF_L6     0x18
-#define SF_L7     0x1c
-#define SF_I0     0x20
-#define SF_I1     0x24
-#define SF_I2     0x28
-#define SF_I3     0x2c
-#define SF_I4     0x30
-#define SF_I5     0x34
-#define SF_FP     0x38
-#define SF_PC     0x3c
-#define SF_RETP   0x40
-#define SF_XARG0  0x44
-#define SF_XARG1  0x48
-#define SF_XARG2  0x4c
-#define SF_XARG3  0x50
-#define SF_XARG4  0x54
-#define SF_XARG5  0x58
-#define SF_XXARG  0x5c
-
-/* Stuff for the ptrace system call */
-#define PTRACE_SPARC_DETACH       11
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_READDATA           16
-#define PTRACE_WRITEDATA          17
-#define PTRACE_READTEXT           18
-#define PTRACE_WRITETEXT          19
-#define PTRACE_GETFPAREGS         20
-#define PTRACE_SETFPAREGS         21
-
-#endif /* !(_SPARC_PTRACE_H) */
diff --git a/include/asm-sparc/ptrace_32.h b/include/asm-sparc/ptrace_32.h
new file mode 100644
index 0000000..11f3bc2
--- /dev/null
+++ b/include/asm-sparc/ptrace_32.h
@@ -0,0 +1,175 @@
+#ifndef _SPARC_PTRACE_H
+#define _SPARC_PTRACE_H
+
+#include <asm/psr.h>
+
+/* This struct defines the way the registers are stored on the 
+ * stack during a system call and basically all traps.
+ */
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+struct pt_regs {
+	unsigned long psr;
+	unsigned long pc;
+	unsigned long npc;
+	unsigned long y;
+	unsigned long u_regs[16]; /* globals and ins */
+};
+
+#define UREG_G0        0
+#define UREG_G1        1
+#define UREG_G2        2
+#define UREG_G3        3
+#define UREG_G4        4
+#define UREG_G5        5
+#define UREG_G6        6
+#define UREG_G7        7
+#define UREG_I0        8
+#define UREG_I1        9
+#define UREG_I2        10
+#define UREG_I3        11
+#define UREG_I4        12
+#define UREG_I5        13
+#define UREG_I6        14
+#define UREG_I7        15
+#define UREG_WIM       UREG_G0
+#define UREG_FADDR     UREG_G0
+#define UREG_FP        UREG_I6
+#define UREG_RETPC     UREG_I7
+
+static inline bool pt_regs_is_syscall(struct pt_regs *regs)
+{
+	return (regs->psr & PSR_SYSCALL);
+}
+
+static inline bool pt_regs_clear_syscall(struct pt_regs *regs)
+{
+	return (regs->psr &= ~PSR_SYSCALL);
+}
+
+/* A register window */
+struct reg_window {
+	unsigned long locals[8];
+	unsigned long ins[8];
+};
+
+/* A Sparc stack frame */
+struct sparc_stackf {
+	unsigned long locals[8];
+        unsigned long ins[6];
+	struct sparc_stackf *fp;
+	unsigned long callers_pc;
+	char *structptr;
+	unsigned long xargs[6];
+	unsigned long xxargs[1];
+};	
+
+#define TRACEREG_SZ   sizeof(struct pt_regs)
+#define STACKFRAME_SZ sizeof(struct sparc_stackf)
+
+#ifdef __KERNEL__
+
+#define user_mode(regs) (!((regs)->psr & PSR_PS))
+#define instruction_pointer(regs) ((regs)->pc)
+unsigned long profile_pc(struct pt_regs *);
+extern void show_regs(struct pt_regs *);
+#endif
+
+#else /* __ASSEMBLY__ */
+/* For assembly code. */
+#define TRACEREG_SZ       0x50
+#define STACKFRAME_SZ     0x60
+#endif
+
+/*
+ * The asm-offsets.h is a generated file, so we cannot include it.
+ * It may be OK for glibc headers, but it's utterly pointless for C code.
+ * The assembly code using those offsets has to include it explicitly.
+ */
+/* #include <asm/asm-offsets.h> */
+
+/* These are for pt_regs. */
+#define PT_PSR    0x0
+#define PT_PC     0x4
+#define PT_NPC    0x8
+#define PT_Y      0xc
+#define PT_G0     0x10
+#define PT_WIM    PT_G0
+#define PT_G1     0x14
+#define PT_G2     0x18
+#define PT_G3     0x1c
+#define PT_G4     0x20
+#define PT_G5     0x24
+#define PT_G6     0x28
+#define PT_G7     0x2c
+#define PT_I0     0x30
+#define PT_I1     0x34
+#define PT_I2     0x38
+#define PT_I3     0x3c
+#define PT_I4     0x40
+#define PT_I5     0x44
+#define PT_I6     0x48
+#define PT_FP     PT_I6
+#define PT_I7     0x4c
+
+/* Reg_window offsets */
+#define RW_L0     0x00
+#define RW_L1     0x04
+#define RW_L2     0x08
+#define RW_L3     0x0c
+#define RW_L4     0x10
+#define RW_L5     0x14
+#define RW_L6     0x18
+#define RW_L7     0x1c
+#define RW_I0     0x20
+#define RW_I1     0x24
+#define RW_I2     0x28
+#define RW_I3     0x2c
+#define RW_I4     0x30
+#define RW_I5     0x34
+#define RW_I6     0x38
+#define RW_I7     0x3c
+
+/* Stack_frame offsets */
+#define SF_L0     0x00
+#define SF_L1     0x04
+#define SF_L2     0x08
+#define SF_L3     0x0c
+#define SF_L4     0x10
+#define SF_L5     0x14
+#define SF_L6     0x18
+#define SF_L7     0x1c
+#define SF_I0     0x20
+#define SF_I1     0x24
+#define SF_I2     0x28
+#define SF_I3     0x2c
+#define SF_I4     0x30
+#define SF_I5     0x34
+#define SF_FP     0x38
+#define SF_PC     0x3c
+#define SF_RETP   0x40
+#define SF_XARG0  0x44
+#define SF_XARG1  0x48
+#define SF_XARG2  0x4c
+#define SF_XARG3  0x50
+#define SF_XARG4  0x54
+#define SF_XARG5  0x58
+#define SF_XXARG  0x5c
+
+/* Stuff for the ptrace system call */
+#define PTRACE_SPARC_DETACH       11
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_READDATA           16
+#define PTRACE_WRITEDATA          17
+#define PTRACE_READTEXT           18
+#define PTRACE_WRITETEXT          19
+#define PTRACE_GETFPAREGS         20
+#define PTRACE_SETFPAREGS         21
+
+#endif /* !(_SPARC_PTRACE_H) */
diff --git a/include/asm-sparc/ptrace_64.h b/include/asm-sparc/ptrace_64.h
new file mode 100644
index 0000000..b163da7
--- /dev/null
+++ b/include/asm-sparc/ptrace_64.h
@@ -0,0 +1,346 @@
+#ifndef _SPARC64_PTRACE_H
+#define _SPARC64_PTRACE_H
+
+#include <asm/pstate.h>
+
+/* This struct defines the way the registers are stored on the 
+ * stack during a system call and basically all traps.
+ */
+
+/* This magic value must have the low 9 bits clear,
+ * as that is where we encode the %tt value, see below.
+ */
+#define PT_REGS_MAGIC 0x57ac6c00
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+struct pt_regs {
+	unsigned long u_regs[16]; /* globals and ins */
+	unsigned long tstate;
+	unsigned long tpc;
+	unsigned long tnpc;
+	unsigned int y;
+
+	/* We encode a magic number, PT_REGS_MAGIC, along
+	 * with the %tt (trap type) register value at trap
+	 * entry time.  The magic number allows us to identify
+	 * accurately a trap stack frame in the stack
+	 * unwinder, and the %tt value allows us to test
+	 * things like "in a system call" etc. for an arbitray
+	 * process.
+	 *
+	 * The PT_REGS_MAGIC is choosen such that it can be
+	 * loaded completely using just a sethi instruction.
+	 */
+	unsigned int magic;
+};
+
+static inline int pt_regs_trap_type(struct pt_regs *regs)
+{
+	return regs->magic & 0x1ff;
+}
+
+static inline bool pt_regs_is_syscall(struct pt_regs *regs)
+{
+	return (regs->tstate & TSTATE_SYSCALL);
+}
+
+static inline bool pt_regs_clear_syscall(struct pt_regs *regs)
+{
+	return (regs->tstate &= ~TSTATE_SYSCALL);
+}
+
+struct pt_regs32 {
+	unsigned int psr;
+	unsigned int pc;
+	unsigned int npc;
+	unsigned int y;
+	unsigned int u_regs[16]; /* globals and ins */
+};
+
+#define UREG_G0        0
+#define UREG_G1        1
+#define UREG_G2        2
+#define UREG_G3        3
+#define UREG_G4        4
+#define UREG_G5        5
+#define UREG_G6        6
+#define UREG_G7        7
+#define UREG_I0        8
+#define UREG_I1        9
+#define UREG_I2        10
+#define UREG_I3        11
+#define UREG_I4        12
+#define UREG_I5        13
+#define UREG_I6        14
+#define UREG_I7        15
+#define UREG_FP        UREG_I6
+#define UREG_RETPC     UREG_I7
+
+/* A V9 register window */
+struct reg_window {
+	unsigned long locals[8];
+	unsigned long ins[8];
+};
+
+/* A 32-bit register window. */
+struct reg_window32 {
+	unsigned int locals[8];
+	unsigned int ins[8];
+};
+
+/* A V9 Sparc stack frame */
+struct sparc_stackf {
+	unsigned long locals[8];
+        unsigned long ins[6];
+	struct sparc_stackf *fp;
+	unsigned long callers_pc;
+	char *structptr;
+	unsigned long xargs[6];
+	unsigned long xxargs[1];
+};	
+
+/* A 32-bit Sparc stack frame */
+struct sparc_stackf32 {
+	unsigned int locals[8];
+        unsigned int ins[6];
+	unsigned int fp;
+	unsigned int callers_pc;
+	unsigned int structptr;
+	unsigned int xargs[6];
+	unsigned int xxargs[1];
+};	
+
+struct sparc_trapf {
+	unsigned long locals[8];
+	unsigned long ins[8];
+	unsigned long _unused;
+	struct pt_regs *regs;
+};
+
+#define TRACEREG_SZ	sizeof(struct pt_regs)
+#define STACKFRAME_SZ	sizeof(struct sparc_stackf)
+
+#define TRACEREG32_SZ	sizeof(struct pt_regs32)
+#define STACKFRAME32_SZ	sizeof(struct sparc_stackf32)
+
+#ifdef __KERNEL__
+
+struct global_reg_snapshot {
+	unsigned long		tstate;
+	unsigned long		tpc;
+	unsigned long		tnpc;
+	unsigned long		o7;
+	unsigned long		i7;
+	struct thread_info	*thread;
+	unsigned long		pad1;
+	unsigned long		pad2;
+};
+
+#define __ARCH_WANT_COMPAT_SYS_PTRACE
+
+#define force_successful_syscall_return()	    \
+do {	current_thread_info()->syscall_noerror = 1; \
+} while (0)
+#define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
+#define instruction_pointer(regs) ((regs)->tpc)
+#define regs_return_value(regs) ((regs)->u_regs[UREG_I0])
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *);
+#else
+#define profile_pc(regs) instruction_pointer(regs)
+#endif
+extern void show_regs(struct pt_regs *);
+extern void __show_regs(struct pt_regs *);
+#endif
+
+#else /* __ASSEMBLY__ */
+/* For assembly code. */
+#define TRACEREG_SZ		0xa0
+#define STACKFRAME_SZ		0xc0
+
+#define TRACEREG32_SZ		0x50
+#define STACKFRAME32_SZ		0x60
+#endif
+
+#ifdef __KERNEL__
+#define STACK_BIAS		2047
+#endif
+
+/* These are for pt_regs. */
+#define PT_V9_G0     0x00
+#define PT_V9_G1     0x08
+#define PT_V9_G2     0x10
+#define PT_V9_G3     0x18
+#define PT_V9_G4     0x20
+#define PT_V9_G5     0x28
+#define PT_V9_G6     0x30
+#define PT_V9_G7     0x38
+#define PT_V9_I0     0x40
+#define PT_V9_I1     0x48
+#define PT_V9_I2     0x50
+#define PT_V9_I3     0x58
+#define PT_V9_I4     0x60
+#define PT_V9_I5     0x68
+#define PT_V9_I6     0x70
+#define PT_V9_FP     PT_V9_I6
+#define PT_V9_I7     0x78
+#define PT_V9_TSTATE 0x80
+#define PT_V9_TPC    0x88
+#define PT_V9_TNPC   0x90
+#define PT_V9_Y      0x98
+#define PT_V9_MAGIC  0x9c
+#define PT_TSTATE	PT_V9_TSTATE
+#define PT_TPC		PT_V9_TPC
+#define PT_TNPC		PT_V9_TNPC
+
+/* These for pt_regs32. */
+#define PT_PSR    0x0
+#define PT_PC     0x4
+#define PT_NPC    0x8
+#define PT_Y      0xc
+#define PT_G0     0x10
+#define PT_WIM    PT_G0
+#define PT_G1     0x14
+#define PT_G2     0x18
+#define PT_G3     0x1c
+#define PT_G4     0x20
+#define PT_G5     0x24
+#define PT_G6     0x28
+#define PT_G7     0x2c
+#define PT_I0     0x30
+#define PT_I1     0x34
+#define PT_I2     0x38
+#define PT_I3     0x3c
+#define PT_I4     0x40
+#define PT_I5     0x44
+#define PT_I6     0x48
+#define PT_FP     PT_I6
+#define PT_I7     0x4c
+
+/* Reg_window offsets */
+#define RW_V9_L0     0x00
+#define RW_V9_L1     0x08
+#define RW_V9_L2     0x10
+#define RW_V9_L3     0x18
+#define RW_V9_L4     0x20
+#define RW_V9_L5     0x28
+#define RW_V9_L6     0x30
+#define RW_V9_L7     0x38
+#define RW_V9_I0     0x40
+#define RW_V9_I1     0x48
+#define RW_V9_I2     0x50
+#define RW_V9_I3     0x58
+#define RW_V9_I4     0x60
+#define RW_V9_I5     0x68
+#define RW_V9_I6     0x70
+#define RW_V9_I7     0x78
+
+#define RW_L0     0x00
+#define RW_L1     0x04
+#define RW_L2     0x08
+#define RW_L3     0x0c
+#define RW_L4     0x10
+#define RW_L5     0x14
+#define RW_L6     0x18
+#define RW_L7     0x1c
+#define RW_I0     0x20
+#define RW_I1     0x24
+#define RW_I2     0x28
+#define RW_I3     0x2c
+#define RW_I4     0x30
+#define RW_I5     0x34
+#define RW_I6     0x38
+#define RW_I7     0x3c
+
+/* Stack_frame offsets */
+#define SF_V9_L0     0x00
+#define SF_V9_L1     0x08
+#define SF_V9_L2     0x10
+#define SF_V9_L3     0x18
+#define SF_V9_L4     0x20
+#define SF_V9_L5     0x28
+#define SF_V9_L6     0x30
+#define SF_V9_L7     0x38
+#define SF_V9_I0     0x40
+#define SF_V9_I1     0x48
+#define SF_V9_I2     0x50
+#define SF_V9_I3     0x58
+#define SF_V9_I4     0x60
+#define SF_V9_I5     0x68
+#define SF_V9_FP     0x70
+#define SF_V9_PC     0x78
+#define SF_V9_RETP   0x80
+#define SF_V9_XARG0  0x88
+#define SF_V9_XARG1  0x90
+#define SF_V9_XARG2  0x98
+#define SF_V9_XARG3  0xa0
+#define SF_V9_XARG4  0xa8
+#define SF_V9_XARG5  0xb0
+#define SF_V9_XXARG  0xb8
+
+#define SF_L0     0x00
+#define SF_L1     0x04
+#define SF_L2     0x08
+#define SF_L3     0x0c
+#define SF_L4     0x10
+#define SF_L5     0x14
+#define SF_L6     0x18
+#define SF_L7     0x1c
+#define SF_I0     0x20
+#define SF_I1     0x24
+#define SF_I2     0x28
+#define SF_I3     0x2c
+#define SF_I4     0x30
+#define SF_I5     0x34
+#define SF_FP     0x38
+#define SF_PC     0x3c
+#define SF_RETP   0x40
+#define SF_XARG0  0x44
+#define SF_XARG1  0x48
+#define SF_XARG2  0x4c
+#define SF_XARG3  0x50
+#define SF_XARG4  0x54
+#define SF_XARG5  0x58
+#define SF_XXARG  0x5c
+
+#ifdef __KERNEL__
+
+/* global_reg_snapshot offsets */
+#define GR_SNAP_TSTATE	0x00
+#define GR_SNAP_TPC	0x08
+#define GR_SNAP_TNPC	0x10
+#define GR_SNAP_O7	0x18
+#define GR_SNAP_I7	0x20
+#define GR_SNAP_THREAD	0x28
+#define GR_SNAP_PAD1	0x30
+#define GR_SNAP_PAD2	0x38
+
+#endif  /*  __KERNEL__  */
+
+/* Stuff for the ptrace system call */
+#define PTRACE_SPARC_DETACH       11
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_READDATA           16
+#define PTRACE_WRITEDATA          17
+#define PTRACE_READTEXT           18
+#define PTRACE_WRITETEXT          19
+#define PTRACE_GETFPAREGS         20
+#define PTRACE_SETFPAREGS         21
+
+/* There are for debugging 64-bit processes, either from a 32 or 64 bit
+ * parent.  Thus their complements are for debugging 32-bit processes only.
+ */
+
+#define PTRACE_GETREGS64	  22
+#define PTRACE_SETREGS64	  23
+/* PTRACE_SYSCALL is 24 */
+#define PTRACE_GETFPREGS64	  25
+#define PTRACE_SETFPREGS64	  26
+
+#endif /* !(_SPARC64_PTRACE_H) */
diff --git a/include/asm-sparc/reg.h b/include/asm-sparc/reg.h
index ea0a7e5..d2f1371 100644
--- a/include/asm-sparc/reg.h
+++ b/include/asm-sparc/reg.h
@@ -1,79 +1,8 @@
-/*
- * linux/include/asm-sparc/reg.h
- * Layout of the registers as expected by gdb on the Sparc
- * we should replace the user.h definitions with those in
- * this file, we don't even use the other 
- * -miguel
- *
- * The names of the structures, constants and aliases in this file
- * have the same names as the sunos ones, some programs rely on these
- * names (gdb for example).
- *
- */
-
-#ifndef __SPARC_REG_H
-#define __SPARC_REG_H
-
-struct regs {
-	int     r_psr;
-#define r_ps r_psr
-        int     r_pc; 
-        int     r_npc;
-        int     r_y;  
-        int     r_g1; 
-        int     r_g2;
-        int     r_g3;
-        int     r_g4;
-        int     r_g5;
-        int     r_g6;
-        int     r_g7;
-        int     r_o0;
-        int     r_o1;
-        int     r_o2;
-        int     r_o3;
-        int     r_o4;
-        int     r_o5;
-        int     r_o6;
-        int     r_o7;
-};
-
-struct fpq {
-        unsigned long *addr;
-        unsigned long instr;
-};
-
-struct  fq {
-        union {
-                double  whole;
-                struct  fpq fpq;
-        } FQu;
-};
-
-#define FPU_REGS_TYPE unsigned int
-#define FPU_FSR_TYPE unsigned
-
-struct fp_status {
-        union {
-                FPU_REGS_TYPE Fpu_regs[32];
-                double  Fpu_dregs[16];
-        } fpu_fr;
-        FPU_FSR_TYPE Fpu_fsr;
-        unsigned Fpu_flags;
-        unsigned Fpu_extra;
-        unsigned Fpu_qcnt;
-        struct fq Fpu_q[16];
-};
-
-#define fpu_regs  f_fpstatus.fpu_fr.Fpu_regs
-#define fpu_dregs f_fpstatus.fpu_fr.Fpu_dregs
-#define fpu_fsr   f_fpstatus.Fpu_fsr
-#define fpu_flags f_fpstatus.Fpu_flags
-#define fpu_extra f_fpstatus.Fpu_extra
-#define fpu_q     f_fpstatus.Fpu_q
-#define fpu_qcnt  f_fpstatus.Fpu_qcnt
-
-struct fpu {
-        struct fp_status f_fpstatus;
-};
-
-#endif /* __SPARC_REG_H */
+#ifndef _ASM_SPARC_REG_H
+#define _ASM_SPARC_REG_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/reg_64.h>
+#else
+#include <asm-sparc/reg_32.h>
+#endif
+#endif
diff --git a/include/asm-sparc/reg_32.h b/include/asm-sparc/reg_32.h
new file mode 100644
index 0000000..ea0a7e5
--- /dev/null
+++ b/include/asm-sparc/reg_32.h
@@ -0,0 +1,79 @@
+/*
+ * linux/include/asm-sparc/reg.h
+ * Layout of the registers as expected by gdb on the Sparc
+ * we should replace the user.h definitions with those in
+ * this file, we don't even use the other 
+ * -miguel
+ *
+ * The names of the structures, constants and aliases in this file
+ * have the same names as the sunos ones, some programs rely on these
+ * names (gdb for example).
+ *
+ */
+
+#ifndef __SPARC_REG_H
+#define __SPARC_REG_H
+
+struct regs {
+	int     r_psr;
+#define r_ps r_psr
+        int     r_pc; 
+        int     r_npc;
+        int     r_y;  
+        int     r_g1; 
+        int     r_g2;
+        int     r_g3;
+        int     r_g4;
+        int     r_g5;
+        int     r_g6;
+        int     r_g7;
+        int     r_o0;
+        int     r_o1;
+        int     r_o2;
+        int     r_o3;
+        int     r_o4;
+        int     r_o5;
+        int     r_o6;
+        int     r_o7;
+};
+
+struct fpq {
+        unsigned long *addr;
+        unsigned long instr;
+};
+
+struct  fq {
+        union {
+                double  whole;
+                struct  fpq fpq;
+        } FQu;
+};
+
+#define FPU_REGS_TYPE unsigned int
+#define FPU_FSR_TYPE unsigned
+
+struct fp_status {
+        union {
+                FPU_REGS_TYPE Fpu_regs[32];
+                double  Fpu_dregs[16];
+        } fpu_fr;
+        FPU_FSR_TYPE Fpu_fsr;
+        unsigned Fpu_flags;
+        unsigned Fpu_extra;
+        unsigned Fpu_qcnt;
+        struct fq Fpu_q[16];
+};
+
+#define fpu_regs  f_fpstatus.fpu_fr.Fpu_regs
+#define fpu_dregs f_fpstatus.fpu_fr.Fpu_dregs
+#define fpu_fsr   f_fpstatus.Fpu_fsr
+#define fpu_flags f_fpstatus.Fpu_flags
+#define fpu_extra f_fpstatus.Fpu_extra
+#define fpu_q     f_fpstatus.Fpu_q
+#define fpu_qcnt  f_fpstatus.Fpu_qcnt
+
+struct fpu {
+        struct fp_status f_fpstatus;
+};
+
+#endif /* __SPARC_REG_H */
diff --git a/include/asm-sparc/reg_64.h b/include/asm-sparc/reg_64.h
new file mode 100644
index 0000000..77aa480
--- /dev/null
+++ b/include/asm-sparc/reg_64.h
@@ -0,0 +1,56 @@
+/*
+ * linux/asm-sparc64/reg.h
+ * Layout of the registers as expected by gdb on the Sparc
+ * we should replace the user.h definitions with those in
+ * this file, we don't even use the other 
+ * -miguel
+ *
+ * The names of the structures, constants and aliases in this file
+ * have the same names as the sunos ones, some programs rely on these
+ * names (gdb for example).
+ *
+ */
+
+#ifndef __SPARC64_REG_H
+#define __SPARC64_REG_H
+
+struct regs {
+        unsigned long r_g1;
+        unsigned long r_g2;
+        unsigned long r_g3;
+        unsigned long r_g4;
+        unsigned long r_g5;
+        unsigned long r_g6;
+        unsigned long r_g7;
+        unsigned long r_o0;
+        unsigned long r_o1;
+        unsigned long r_o2;
+        unsigned long r_o3;
+        unsigned long r_o4;
+        unsigned long r_o5;
+        unsigned long r_o6;
+        unsigned long r_o7;
+        unsigned long __pad;
+        unsigned long r_tstate;
+        unsigned long r_tpc;
+        unsigned long r_tnpc;
+        unsigned int  r_y;
+        unsigned int  r_fprs;
+};
+
+#define FPU_REGS_TYPE unsigned int
+#define FPU_FSR_TYPE unsigned long
+
+struct fp_status {
+        unsigned long fpu_fr[32];
+        unsigned long Fpu_fsr;
+};
+
+struct fpu {
+	struct fp_status f_fpstatus;
+};
+
+#define fpu_regs  f_fpstatus.fpu_fr
+#define fpu_fsr   f_fpstatus.Fpu_fsr
+
+#endif /* __SPARC64_REG_H */
diff --git a/include/asm-sparc/sigcontext.h b/include/asm-sparc/sigcontext.h
index c5fb60d..b1dcf5d 100644
--- a/include/asm-sparc/sigcontext.h
+++ b/include/asm-sparc/sigcontext.h
@@ -1,62 +1,8 @@
-#ifndef __SPARC_SIGCONTEXT_H
-#define __SPARC_SIGCONTEXT_H
-
-#ifdef __KERNEL__
-#include <asm/ptrace.h>
-
-#ifndef __ASSEMBLY__
-
-#define __SUNOS_MAXWIN   31
-
-/* This is what SunOS does, so shall I. */
-struct sigcontext {
-	int sigc_onstack;      /* state to restore */
-	int sigc_mask;         /* sigmask to restore */
-	int sigc_sp;           /* stack pointer */
-	int sigc_pc;           /* program counter */
-	int sigc_npc;          /* next program counter */
-	int sigc_psr;          /* for condition codes etc */
-	int sigc_g1;           /* User uses these two registers */
-	int sigc_o0;           /* within the trampoline code. */
-
-	/* Now comes information regarding the users window set
-	 * at the time of the signal.
-	 */
-	int sigc_oswins;       /* outstanding windows */
-
-	/* stack ptrs for each regwin buf */
-	char *sigc_spbuf[__SUNOS_MAXWIN];
-
-	/* Windows to restore after signal */
-	struct {
-		unsigned long	locals[8];
-		unsigned long	ins[8];
-	} sigc_wbuf[__SUNOS_MAXWIN];
-};
-
-typedef struct {
-	struct {
-		unsigned long psr;
-		unsigned long pc;
-		unsigned long npc;
-		unsigned long y;
-		unsigned long u_regs[16]; /* globals and ins */
-	}		si_regs;
-	int		si_mask;
-} __siginfo_t;
-
-typedef struct {
-	unsigned   long si_float_regs [32];
-	unsigned   long si_fsr;
-	unsigned   long si_fpqdepth;
-	struct {
-		unsigned long *insn_addr;
-		unsigned long insn;
-	} si_fpqueue [16];
-} __siginfo_fpu_t;
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* (__KERNEL__) */
-
-#endif /* !(__SPARC_SIGCONTEXT_H) */
+#ifndef _ASM_SPARC_SIGCONTEXT_H
+#define _ASM_SPARC_SIGCONTEXT_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/sigcontext_64.h>
+#else
+#include <asm-sparc/sigcontext_32.h>
+#endif
+#endif
diff --git a/include/asm-sparc/sigcontext_32.h b/include/asm-sparc/sigcontext_32.h
new file mode 100644
index 0000000..c5fb60d
--- /dev/null
+++ b/include/asm-sparc/sigcontext_32.h
@@ -0,0 +1,62 @@
+#ifndef __SPARC_SIGCONTEXT_H
+#define __SPARC_SIGCONTEXT_H
+
+#ifdef __KERNEL__
+#include <asm/ptrace.h>
+
+#ifndef __ASSEMBLY__
+
+#define __SUNOS_MAXWIN   31
+
+/* This is what SunOS does, so shall I. */
+struct sigcontext {
+	int sigc_onstack;      /* state to restore */
+	int sigc_mask;         /* sigmask to restore */
+	int sigc_sp;           /* stack pointer */
+	int sigc_pc;           /* program counter */
+	int sigc_npc;          /* next program counter */
+	int sigc_psr;          /* for condition codes etc */
+	int sigc_g1;           /* User uses these two registers */
+	int sigc_o0;           /* within the trampoline code. */
+
+	/* Now comes information regarding the users window set
+	 * at the time of the signal.
+	 */
+	int sigc_oswins;       /* outstanding windows */
+
+	/* stack ptrs for each regwin buf */
+	char *sigc_spbuf[__SUNOS_MAXWIN];
+
+	/* Windows to restore after signal */
+	struct {
+		unsigned long	locals[8];
+		unsigned long	ins[8];
+	} sigc_wbuf[__SUNOS_MAXWIN];
+};
+
+typedef struct {
+	struct {
+		unsigned long psr;
+		unsigned long pc;
+		unsigned long npc;
+		unsigned long y;
+		unsigned long u_regs[16]; /* globals and ins */
+	}		si_regs;
+	int		si_mask;
+} __siginfo_t;
+
+typedef struct {
+	unsigned   long si_float_regs [32];
+	unsigned   long si_fsr;
+	unsigned   long si_fpqdepth;
+	struct {
+		unsigned long *insn_addr;
+		unsigned long insn;
+	} si_fpqueue [16];
+} __siginfo_fpu_t;
+
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* (__KERNEL__) */
+
+#endif /* !(__SPARC_SIGCONTEXT_H) */
diff --git a/include/asm-sparc/sigcontext_64.h b/include/asm-sparc/sigcontext_64.h
new file mode 100644
index 0000000..1c868d6
--- /dev/null
+++ b/include/asm-sparc/sigcontext_64.h
@@ -0,0 +1,87 @@
+#ifndef __SPARC64_SIGCONTEXT_H
+#define __SPARC64_SIGCONTEXT_H
+
+#ifdef __KERNEL__
+#include <asm/ptrace.h>
+#endif
+
+#ifndef __ASSEMBLY__
+
+#ifdef __KERNEL__
+
+#define __SUNOS_MAXWIN   31
+
+/* This is what SunOS does, so shall I unless we use new 32bit signals or rt signals. */
+struct sigcontext32 {
+	int sigc_onstack;      /* state to restore */
+	int sigc_mask;         /* sigmask to restore */
+	int sigc_sp;           /* stack pointer */
+	int sigc_pc;           /* program counter */
+	int sigc_npc;          /* next program counter */
+	int sigc_psr;          /* for condition codes etc */
+	int sigc_g1;           /* User uses these two registers */
+	int sigc_o0;           /* within the trampoline code. */
+
+	/* Now comes information regarding the users window set
+	 * at the time of the signal.
+	 */
+	int sigc_oswins;       /* outstanding windows */
+
+	/* stack ptrs for each regwin buf */
+	unsigned sigc_spbuf[__SUNOS_MAXWIN];
+
+	/* Windows to restore after signal */
+	struct reg_window32 sigc_wbuf[__SUNOS_MAXWIN];
+};
+
+#endif
+
+#ifdef __KERNEL__
+
+/* This is what we use for 32bit new non-rt signals. */
+
+typedef struct {
+	struct {
+		unsigned int psr;
+		unsigned int pc;
+		unsigned int npc;
+		unsigned int y;
+		unsigned int u_regs[16]; /* globals and ins */
+	}			si_regs;
+	int			si_mask;
+} __siginfo32_t;
+
+#endif
+
+typedef struct {
+	unsigned   int si_float_regs [64];
+	unsigned   long si_fsr;
+	unsigned   long si_gsr;
+	unsigned   long si_fprs;
+} __siginfo_fpu_t;
+
+/* This is what SunOS doesn't, so we have to write this alone
+   and do it properly. */
+struct sigcontext {
+	/* The size of this array has to match SI_MAX_SIZE from siginfo.h */
+	char			sigc_info[128];
+	struct {
+		unsigned long	u_regs[16]; /* globals and ins */
+		unsigned long	tstate;
+		unsigned long	tpc;
+		unsigned long	tnpc;
+		unsigned int	y;
+		unsigned int	fprs;
+	}			sigc_regs;
+	__siginfo_fpu_t *	sigc_fpu_save;
+	struct {
+		void	*	ss_sp;
+		int		ss_flags;
+		unsigned long	ss_size;
+	}			sigc_stack;
+	unsigned long		sigc_mask;
+};
+
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* !(__SPARC64_SIGCONTEXT_H) */
diff --git a/include/asm-sparc/siginfo.h b/include/asm-sparc/siginfo.h
index 3c71af1..ef40206 100644
--- a/include/asm-sparc/siginfo.h
+++ b/include/asm-sparc/siginfo.h
@@ -1,17 +1,8 @@
-#ifndef _SPARC_SIGINFO_H
-#define _SPARC_SIGINFO_H
-
-#define __ARCH_SI_UID_T		unsigned int
-#define __ARCH_SI_TRAPNO
-
-#include <asm-generic/siginfo.h>
-
-#define SI_NOINFO	32767		/* no information in siginfo_t */
-
-/*
- * SIGEMT si_codes
- */
-#define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
-#define NSIGEMT		1
-
-#endif /* !(_SPARC_SIGINFO_H) */
+#ifndef _ASM_SPARC_SIGINFO_H
+#define _ASM_SPARC_SIGINFO_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/siginfo_64.h>
+#else
+#include <asm-sparc/siginfo_32.h>
+#endif
+#endif
diff --git a/include/asm-sparc/siginfo_32.h b/include/asm-sparc/siginfo_32.h
new file mode 100644
index 0000000..3c71af1
--- /dev/null
+++ b/include/asm-sparc/siginfo_32.h
@@ -0,0 +1,17 @@
+#ifndef _SPARC_SIGINFO_H
+#define _SPARC_SIGINFO_H
+
+#define __ARCH_SI_UID_T		unsigned int
+#define __ARCH_SI_TRAPNO
+
+#include <asm-generic/siginfo.h>
+
+#define SI_NOINFO	32767		/* no information in siginfo_t */
+
+/*
+ * SIGEMT si_codes
+ */
+#define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
+#define NSIGEMT		1
+
+#endif /* !(_SPARC_SIGINFO_H) */
diff --git a/include/asm-sparc/siginfo_64.h b/include/asm-sparc/siginfo_64.h
new file mode 100644
index 0000000..c96e6c3
--- /dev/null
+++ b/include/asm-sparc/siginfo_64.h
@@ -0,0 +1,32 @@
+#ifndef _SPARC64_SIGINFO_H
+#define _SPARC64_SIGINFO_H
+
+#define SI_PAD_SIZE32	((SI_MAX_SIZE/sizeof(int)) - 3)
+
+#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_BAND_T int
+
+#include <asm-generic/siginfo.h>
+
+#ifdef __KERNEL__
+
+#include <linux/compat.h>
+
+#ifdef CONFIG_COMPAT
+
+struct compat_siginfo;
+
+#endif /* CONFIG_COMPAT */
+
+#endif /* __KERNEL__ */
+
+#define SI_NOINFO	32767		/* no information in siginfo_t */
+
+/*
+ * SIGEMT si_codes
+ */
+#define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
+#define NSIGEMT		1
+
+#endif
diff --git a/include/asm-sparc/signal.h b/include/asm-sparc/signal.h
index 683657d..0bdcac4 100644
--- a/include/asm-sparc/signal.h
+++ b/include/asm-sparc/signal.h
@@ -1,207 +1,8 @@
-#ifndef _ASMSPARC_SIGNAL_H
-#define _ASMSPARC_SIGNAL_H
-
-#include <asm/sigcontext.h>
-#include <linux/compiler.h>
-
-#ifdef __KERNEL__
-#ifndef __ASSEMBLY__
-#include <linux/personality.h>
-#include <linux/types.h>
-#endif
-#endif
-
-/* On the Sparc the signal handlers get passed a 'sub-signal' code
- * for certain signal types, which we document here.
- */
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define    SUBSIG_STACK       0
-#define    SUBSIG_ILLINST     2
-#define    SUBSIG_PRIVINST    3
-#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
-
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-
-#define SIGEMT           7
-#define    SUBSIG_TAG    10
-
-#define SIGFPE		 8
-#define    SUBSIG_FPDISABLED     0x400
-#define    SUBSIG_FPERROR        0x404
-#define    SUBSIG_FPINTOVFL      0x001
-#define    SUBSIG_FPSTSIG        0x002
-#define    SUBSIG_IDIVZERO       0x014
-#define    SUBSIG_FPINEXACT      0x0c4
-#define    SUBSIG_FPDIVZERO      0x0c8
-#define    SUBSIG_FPUNFLOW       0x0cc
-#define    SUBSIG_FPOPERROR      0x0d0
-#define    SUBSIG_FPOVFLOW       0x0d4
-
-#define SIGKILL		 9
-#define SIGBUS          10
-#define    SUBSIG_BUSTIMEOUT    1
-#define    SUBSIG_ALIGNMENT     2
-#define    SUBSIG_MISCERROR     5
-
-#define SIGSEGV		11
-#define    SUBSIG_NOMAPPING     3
-#define    SUBSIG_PROTECTION    4
-#define    SUBSIG_SEGERROR      5
-
-#define SIGSYS		12
-
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGURG          16
-
-/* SunOS values which deviate from the Linux/i386 ones */
-#define SIGSTOP		17
-#define SIGTSTP		18
-#define SIGCONT		19
-#define SIGCHLD		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGIO		23
-#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGLOST		29
-#define SIGPWR		SIGLOST
-#define SIGUSR1		30
-#define SIGUSR2		31
-
-/* Most things should be clean enough to redefine this at will, if care
- * is taken to make libc match.
- */
-
-#define __OLD_NSIG	32
-#define __NEW_NSIG	64
-#define _NSIG_BPW	32
-#define _NSIG_WORDS	(__NEW_NSIG / _NSIG_BPW)
-
-#define SIGRTMIN	32
-#define SIGRTMAX	__NEW_NSIG
-
-#if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
-#define	_NSIG		__NEW_NSIG
-#define __new_sigset_t	sigset_t
-#define __new_sigaction	sigaction
-#define __old_sigset_t	old_sigset_t
-#define __old_sigaction	old_sigaction
+#ifndef _ASM_SPARC_SIGNAL_H
+#define _ASM_SPARC_SIGNAL_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/signal_64.h>
 #else
-#define _NSIG		__OLD_NSIG
-#define __old_sigset_t	sigset_t
-#define __old_sigaction	sigaction
-#endif
-
-#ifndef __ASSEMBLY__
-
-typedef unsigned long __old_sigset_t;
-
-typedef struct {
-	unsigned long	sig[_NSIG_WORDS];
-} __new_sigset_t;
-
-
-#ifdef __KERNEL__
-/* A SunOS sigstack */
-struct sigstack {
-	char *the_stack;
-	int   cur_status;
-};
+#include <asm-sparc/signal_32.h>
 #endif
-
-/* Sigvec flags */
-#define _SV_SSTACK    1u    /* This signal handler should use sig-stack */
-#define _SV_INTR      2u    /* Sig return should not restart system call */
-#define _SV_RESET     4u    /* Set handler to SIG_DFL upon taken signal */
-#define _SV_IGNCHILD  8u    /* Do not send SIGCHLD */
-
-/*
- * sa_flags values: SA_STACK is not currently supported, but will allow the
- * usage of signal stacks by using the (now obsolete) sa_restorer field in
- * the sigaction structure as a stack pointer. This is now possible due to
- * the changes in signal handling. LBT 010493.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- */
-#define SA_NOCLDSTOP	_SV_IGNCHILD
-#define SA_STACK	_SV_SSTACK
-#define SA_ONSTACK	_SV_SSTACK
-#define SA_RESTART	_SV_INTR
-#define SA_ONESHOT	_SV_RESET
-#define SA_NOMASK	0x20u
-#define SA_NOCLDWAIT	0x100u
-#define SA_SIGINFO	0x200u
-
-#define SIG_BLOCK          0x01	/* for blocking signals */
-#define SIG_UNBLOCK        0x02	/* for unblocking signals */
-#define SIG_SETMASK        0x04	/* for setting the signal mask */
-
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	4096
-#define SIGSTKSZ	16384
-
-#ifdef __KERNEL__
-/*
- * DJHR
- * SA_STATIC_ALLOC is used for the SPARC system to indicate that this
- * interrupt handler's irq structure should be statically allocated
- * by the request_irq routine.
- * The alternative is that arch/sparc/kernel/irq.c has carnal knowledge
- * of interrupt usage and that sucks. Also without a flag like this
- * it may be possible for the free_irq routine to attempt to free
- * statically allocated data.. which is NOT GOOD.
- *
- */
-#define SA_STATIC_ALLOC		0x8000
 #endif
-
-#include <asm-generic/signal.h>
-
-#ifdef __KERNEL__
-struct __new_sigaction {
-	__sighandler_t	sa_handler;
-	unsigned long	sa_flags;
-	void		(*sa_restorer)(void);	/* Not used by Linux/SPARC */
-	__new_sigset_t	sa_mask;
-};
-
-struct k_sigaction {
-	struct __new_sigaction	sa;
-	void			__user *ka_restorer;
-};
-
-struct __old_sigaction {
-	__sighandler_t	sa_handler;
-	__old_sigset_t	sa_mask;
-	unsigned long	sa_flags;
-	void		(*sa_restorer) (void);	/* not used by Linux/SPARC */
-};
-
-typedef struct sigaltstack {
-	void		__user *ss_sp;
-	int		ss_flags;
-	size_t		ss_size;
-} stack_t;
-
-#define ptrace_signal_deliver(regs, cookie) do { } while (0)
-
-#endif /* !(__KERNEL__) */
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(_ASMSPARC_SIGNAL_H) */
diff --git a/include/asm-sparc/signal_32.h b/include/asm-sparc/signal_32.h
new file mode 100644
index 0000000..683657d
--- /dev/null
+++ b/include/asm-sparc/signal_32.h
@@ -0,0 +1,207 @@
+#ifndef _ASMSPARC_SIGNAL_H
+#define _ASMSPARC_SIGNAL_H
+
+#include <asm/sigcontext.h>
+#include <linux/compiler.h>
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+#include <linux/personality.h>
+#include <linux/types.h>
+#endif
+#endif
+
+/* On the Sparc the signal handlers get passed a 'sub-signal' code
+ * for certain signal types, which we document here.
+ */
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define    SUBSIG_STACK       0
+#define    SUBSIG_ILLINST     2
+#define    SUBSIG_PRIVINST    3
+#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
+
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+
+#define SIGEMT           7
+#define    SUBSIG_TAG    10
+
+#define SIGFPE		 8
+#define    SUBSIG_FPDISABLED     0x400
+#define    SUBSIG_FPERROR        0x404
+#define    SUBSIG_FPINTOVFL      0x001
+#define    SUBSIG_FPSTSIG        0x002
+#define    SUBSIG_IDIVZERO       0x014
+#define    SUBSIG_FPINEXACT      0x0c4
+#define    SUBSIG_FPDIVZERO      0x0c8
+#define    SUBSIG_FPUNFLOW       0x0cc
+#define    SUBSIG_FPOPERROR      0x0d0
+#define    SUBSIG_FPOVFLOW       0x0d4
+
+#define SIGKILL		 9
+#define SIGBUS          10
+#define    SUBSIG_BUSTIMEOUT    1
+#define    SUBSIG_ALIGNMENT     2
+#define    SUBSIG_MISCERROR     5
+
+#define SIGSEGV		11
+#define    SUBSIG_NOMAPPING     3
+#define    SUBSIG_PROTECTION    4
+#define    SUBSIG_SEGERROR      5
+
+#define SIGSYS		12
+
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGURG          16
+
+/* SunOS values which deviate from the Linux/i386 ones */
+#define SIGSTOP		17
+#define SIGTSTP		18
+#define SIGCONT		19
+#define SIGCHLD		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGIO		23
+#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGLOST		29
+#define SIGPWR		SIGLOST
+#define SIGUSR1		30
+#define SIGUSR2		31
+
+/* Most things should be clean enough to redefine this at will, if care
+ * is taken to make libc match.
+ */
+
+#define __OLD_NSIG	32
+#define __NEW_NSIG	64
+#define _NSIG_BPW	32
+#define _NSIG_WORDS	(__NEW_NSIG / _NSIG_BPW)
+
+#define SIGRTMIN	32
+#define SIGRTMAX	__NEW_NSIG
+
+#if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
+#define	_NSIG		__NEW_NSIG
+#define __new_sigset_t	sigset_t
+#define __new_sigaction	sigaction
+#define __old_sigset_t	old_sigset_t
+#define __old_sigaction	old_sigaction
+#else
+#define _NSIG		__OLD_NSIG
+#define __old_sigset_t	sigset_t
+#define __old_sigaction	sigaction
+#endif
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned long __old_sigset_t;
+
+typedef struct {
+	unsigned long	sig[_NSIG_WORDS];
+} __new_sigset_t;
+
+
+#ifdef __KERNEL__
+/* A SunOS sigstack */
+struct sigstack {
+	char *the_stack;
+	int   cur_status;
+};
+#endif
+
+/* Sigvec flags */
+#define _SV_SSTACK    1u    /* This signal handler should use sig-stack */
+#define _SV_INTR      2u    /* Sig return should not restart system call */
+#define _SV_RESET     4u    /* Set handler to SIG_DFL upon taken signal */
+#define _SV_IGNCHILD  8u    /* Do not send SIGCHLD */
+
+/*
+ * sa_flags values: SA_STACK is not currently supported, but will allow the
+ * usage of signal stacks by using the (now obsolete) sa_restorer field in
+ * the sigaction structure as a stack pointer. This is now possible due to
+ * the changes in signal handling. LBT 010493.
+ * SA_RESTART flag to get restarting signals (which were the default long ago)
+ */
+#define SA_NOCLDSTOP	_SV_IGNCHILD
+#define SA_STACK	_SV_SSTACK
+#define SA_ONSTACK	_SV_SSTACK
+#define SA_RESTART	_SV_INTR
+#define SA_ONESHOT	_SV_RESET
+#define SA_NOMASK	0x20u
+#define SA_NOCLDWAIT	0x100u
+#define SA_SIGINFO	0x200u
+
+#define SIG_BLOCK          0x01	/* for blocking signals */
+#define SIG_UNBLOCK        0x02	/* for unblocking signals */
+#define SIG_SETMASK        0x04	/* for setting the signal mask */
+
+/* 
+ * sigaltstack controls
+ */
+#define SS_ONSTACK	1
+#define SS_DISABLE	2
+
+#define MINSIGSTKSZ	4096
+#define SIGSTKSZ	16384
+
+#ifdef __KERNEL__
+/*
+ * DJHR
+ * SA_STATIC_ALLOC is used for the SPARC system to indicate that this
+ * interrupt handler's irq structure should be statically allocated
+ * by the request_irq routine.
+ * The alternative is that arch/sparc/kernel/irq.c has carnal knowledge
+ * of interrupt usage and that sucks. Also without a flag like this
+ * it may be possible for the free_irq routine to attempt to free
+ * statically allocated data.. which is NOT GOOD.
+ *
+ */
+#define SA_STATIC_ALLOC		0x8000
+#endif
+
+#include <asm-generic/signal.h>
+
+#ifdef __KERNEL__
+struct __new_sigaction {
+	__sighandler_t	sa_handler;
+	unsigned long	sa_flags;
+	void		(*sa_restorer)(void);	/* Not used by Linux/SPARC */
+	__new_sigset_t	sa_mask;
+};
+
+struct k_sigaction {
+	struct __new_sigaction	sa;
+	void			__user *ka_restorer;
+};
+
+struct __old_sigaction {
+	__sighandler_t	sa_handler;
+	__old_sigset_t	sa_mask;
+	unsigned long	sa_flags;
+	void		(*sa_restorer) (void);	/* not used by Linux/SPARC */
+};
+
+typedef struct sigaltstack {
+	void		__user *ss_sp;
+	int		ss_flags;
+	size_t		ss_size;
+} stack_t;
+
+#define ptrace_signal_deliver(regs, cookie) do { } while (0)
+
+#endif /* !(__KERNEL__) */
+
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* !(_ASMSPARC_SIGNAL_H) */
diff --git a/include/asm-sparc/signal_64.h b/include/asm-sparc/signal_64.h
new file mode 100644
index 0000000..2a7c793
--- /dev/null
+++ b/include/asm-sparc/signal_64.h
@@ -0,0 +1,194 @@
+#ifndef _ASMSPARC64_SIGNAL_H
+#define _ASMSPARC64_SIGNAL_H
+
+#include <asm/sigcontext.h>
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+#include <linux/personality.h>
+#include <linux/types.h>
+#endif
+#endif
+
+/* On the Sparc the signal handlers get passed a 'sub-signal' code
+ * for certain signal types, which we document here.
+ */
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define    SUBSIG_STACK       0
+#define    SUBSIG_ILLINST     2
+#define    SUBSIG_PRIVINST    3
+#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
+
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+
+#define SIGEMT           7
+#define    SUBSIG_TAG    10
+
+#define SIGFPE		 8
+#define    SUBSIG_FPDISABLED     0x400
+#define    SUBSIG_FPERROR        0x404
+#define    SUBSIG_FPINTOVFL      0x001
+#define    SUBSIG_FPSTSIG        0x002
+#define    SUBSIG_IDIVZERO       0x014
+#define    SUBSIG_FPINEXACT      0x0c4
+#define    SUBSIG_FPDIVZERO      0x0c8
+#define    SUBSIG_FPUNFLOW       0x0cc
+#define    SUBSIG_FPOPERROR      0x0d0
+#define    SUBSIG_FPOVFLOW       0x0d4
+
+#define SIGKILL		 9
+#define SIGBUS          10
+#define    SUBSIG_BUSTIMEOUT    1
+#define    SUBSIG_ALIGNMENT     2
+#define    SUBSIG_MISCERROR     5
+
+#define SIGSEGV		11
+#define    SUBSIG_NOMAPPING     3
+#define    SUBSIG_PROTECTION    4
+#define    SUBSIG_SEGERROR      5
+
+#define SIGSYS		12
+
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGURG          16
+
+/* SunOS values which deviate from the Linux/i386 ones */
+#define SIGSTOP		17
+#define SIGTSTP		18
+#define SIGCONT		19
+#define SIGCHLD		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGIO		23
+#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGLOST		29
+#define SIGPWR		SIGLOST
+#define SIGUSR1		30
+#define SIGUSR2		31
+
+/* Most things should be clean enough to redefine this at will, if care
+   is taken to make libc match.  */
+
+#define __OLD_NSIG	32
+#define __NEW_NSIG      64
+#define _NSIG_BPW     	64
+#define _NSIG_WORDS   	(__NEW_NSIG / _NSIG_BPW)
+
+#define SIGRTMIN       32
+#define SIGRTMAX       __NEW_NSIG
+
+#if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
+#define _NSIG			__NEW_NSIG
+#define __new_sigset_t		sigset_t
+#define __new_sigaction		sigaction
+#define __new_sigaction32	sigaction32
+#define __old_sigset_t		old_sigset_t
+#define __old_sigaction		old_sigaction
+#define __old_sigaction32	old_sigaction32
+#else
+#define _NSIG			__OLD_NSIG
+#define NSIG			_NSIG
+#define __old_sigset_t		sigset_t
+#define __old_sigaction		sigaction
+#define __old_sigaction32	sigaction32
+#endif
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned long __old_sigset_t;            /* at least 32 bits */
+
+typedef struct {
+       unsigned long sig[_NSIG_WORDS];
+} __new_sigset_t;
+
+/* A SunOS sigstack */
+struct sigstack {
+	/* XXX 32-bit pointers pinhead XXX */
+	char *the_stack;
+	int   cur_status;
+};
+
+/* Sigvec flags */
+#define _SV_SSTACK    1u    /* This signal handler should use sig-stack */
+#define _SV_INTR      2u    /* Sig return should not restart system call */
+#define _SV_RESET     4u    /* Set handler to SIG_DFL upon taken signal */
+#define _SV_IGNCHILD  8u    /* Do not send SIGCHLD */
+
+/*
+ * sa_flags values: SA_STACK is not currently supported, but will allow the
+ * usage of signal stacks by using the (now obsolete) sa_restorer field in
+ * the sigaction structure as a stack pointer. This is now possible due to
+ * the changes in signal handling. LBT 010493.
+ * SA_RESTART flag to get restarting signals (which were the default long ago)
+ */
+#define SA_NOCLDSTOP	_SV_IGNCHILD
+#define SA_STACK	_SV_SSTACK
+#define SA_ONSTACK	_SV_SSTACK
+#define SA_RESTART	_SV_INTR
+#define SA_ONESHOT	_SV_RESET
+#define SA_NOMASK	0x20u
+#define SA_NOCLDWAIT    0x100u
+#define SA_SIGINFO      0x200u
+
+
+#define SIG_BLOCK          0x01	/* for blocking signals */
+#define SIG_UNBLOCK        0x02	/* for unblocking signals */
+#define SIG_SETMASK        0x04	/* for setting the signal mask */
+
+/* 
+ * sigaltstack controls
+ */
+#define SS_ONSTACK	1
+#define SS_DISABLE	2
+
+#define MINSIGSTKSZ	4096
+#define SIGSTKSZ	16384
+
+#include <asm-generic/signal.h>
+
+struct __new_sigaction {
+	__sighandler_t		sa_handler;
+	unsigned long		sa_flags;
+	__sigrestore_t 		sa_restorer;  /* not used by Linux/SPARC yet */
+	__new_sigset_t		sa_mask;
+};
+
+struct __old_sigaction {
+	__sighandler_t  	sa_handler;
+	__old_sigset_t  	sa_mask;
+	unsigned long   	sa_flags;
+	void 			(*sa_restorer)(void);     /* not used by Linux/SPARC yet */
+};
+
+typedef struct sigaltstack {
+	void			__user *ss_sp;
+	int			ss_flags;
+	size_t			ss_size;
+} stack_t;
+
+#ifdef __KERNEL__
+
+struct k_sigaction {
+	struct __new_sigaction 	sa;
+	void __user		*ka_restorer;
+};
+
+#define ptrace_signal_deliver(regs, cookie) do { } while (0)
+
+#endif /* !(__KERNEL__) */
+
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* !(_ASMSPARC64_SIGNAL_H) */
diff --git a/include/asm-sparc/stat.h b/include/asm-sparc/stat.h
index 2299e1d..1c2b419 100644
--- a/include/asm-sparc/stat.h
+++ b/include/asm-sparc/stat.h
@@ -1,76 +1,8 @@
-#ifndef _SPARC_STAT_H
-#define _SPARC_STAT_H
-
-#include <linux/types.h>
-
-struct __old_kernel_stat {
-	unsigned short st_dev;
-	unsigned short st_ino;
-	unsigned short st_mode;
-	unsigned short st_nlink;
-	unsigned short st_uid;
-	unsigned short st_gid;
-	unsigned short st_rdev;
-	unsigned long  st_size;
-	unsigned long  st_atime;
-	unsigned long  st_mtime;
-	unsigned long  st_ctime;
-};
-
-struct stat {
-	unsigned short	st_dev;
-	unsigned long	st_ino;
-	unsigned short	st_mode;
-	short		st_nlink;
-	unsigned short	st_uid;
-	unsigned short	st_gid;
-	unsigned short	st_rdev;
-	long		st_size;
-	long		st_atime;
-	unsigned long	st_atime_nsec;
-	long		st_mtime;
-	unsigned long	st_mtime_nsec;
-	long		st_ctime;
-	unsigned long	st_ctime_nsec;
-	long		st_blksize;
-	long		st_blocks;
-	unsigned long	__unused4[2];
-};
-
-#define STAT_HAVE_NSEC 1
-
-struct stat64 {
-	unsigned long long st_dev;
-
-	unsigned long long st_ino;
-
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
-
-	unsigned int	st_uid;
-	unsigned int	st_gid;
-
-	unsigned long long st_rdev;
-
-	unsigned char	__pad3[8];
-
-	long long	st_size;
-	unsigned int	st_blksize;
-
-	unsigned char	__pad4[8];
-	unsigned int	st_blocks;
-
-	unsigned int	st_atime;
-	unsigned int	st_atime_nsec;
-
-	unsigned int	st_mtime;
-	unsigned int	st_mtime_nsec;
-
-	unsigned int	st_ctime;
-	unsigned int	st_ctime_nsec;
-
-	unsigned int	__unused4;
-	unsigned int	__unused5;
-};
-
+#ifndef _ASM_SPARC_STAT_H
+#define _ASM_SPARC_STAT_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/stat_64.h>
+#else
+#include <asm-sparc/stat_32.h>
+#endif
 #endif
diff --git a/include/asm-sparc/stat_32.h b/include/asm-sparc/stat_32.h
new file mode 100644
index 0000000..2299e1d
--- /dev/null
+++ b/include/asm-sparc/stat_32.h
@@ -0,0 +1,76 @@
+#ifndef _SPARC_STAT_H
+#define _SPARC_STAT_H
+
+#include <linux/types.h>
+
+struct __old_kernel_stat {
+	unsigned short st_dev;
+	unsigned short st_ino;
+	unsigned short st_mode;
+	unsigned short st_nlink;
+	unsigned short st_uid;
+	unsigned short st_gid;
+	unsigned short st_rdev;
+	unsigned long  st_size;
+	unsigned long  st_atime;
+	unsigned long  st_mtime;
+	unsigned long  st_ctime;
+};
+
+struct stat {
+	unsigned short	st_dev;
+	unsigned long	st_ino;
+	unsigned short	st_mode;
+	short		st_nlink;
+	unsigned short	st_uid;
+	unsigned short	st_gid;
+	unsigned short	st_rdev;
+	long		st_size;
+	long		st_atime;
+	unsigned long	st_atime_nsec;
+	long		st_mtime;
+	unsigned long	st_mtime_nsec;
+	long		st_ctime;
+	unsigned long	st_ctime_nsec;
+	long		st_blksize;
+	long		st_blocks;
+	unsigned long	__unused4[2];
+};
+
+#define STAT_HAVE_NSEC 1
+
+struct stat64 {
+	unsigned long long st_dev;
+
+	unsigned long long st_ino;
+
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+
+	unsigned long long st_rdev;
+
+	unsigned char	__pad3[8];
+
+	long long	st_size;
+	unsigned int	st_blksize;
+
+	unsigned char	__pad4[8];
+	unsigned int	st_blocks;
+
+	unsigned int	st_atime;
+	unsigned int	st_atime_nsec;
+
+	unsigned int	st_mtime;
+	unsigned int	st_mtime_nsec;
+
+	unsigned int	st_ctime;
+	unsigned int	st_ctime_nsec;
+
+	unsigned int	__unused4;
+	unsigned int	__unused5;
+};
+
+#endif
diff --git a/include/asm-sparc/stat_64.h b/include/asm-sparc/stat_64.h
new file mode 100644
index 0000000..9650fde
--- /dev/null
+++ b/include/asm-sparc/stat_64.h
@@ -0,0 +1,47 @@
+#ifndef _SPARC64_STAT_H
+#define _SPARC64_STAT_H
+
+#include <linux/types.h>
+
+struct stat {
+	unsigned   st_dev;
+	ino_t   st_ino;
+	mode_t  st_mode;
+	short   st_nlink;
+	uid_t   st_uid;
+	gid_t   st_gid;
+	unsigned   st_rdev;
+	off_t   st_size;
+	time_t  st_atime;
+	time_t  st_mtime;
+	time_t  st_ctime;
+	off_t   st_blksize;
+	off_t   st_blocks;
+	unsigned long  __unused4[2];
+};
+
+struct stat64 {
+	unsigned long	st_dev;
+	unsigned long	st_ino;
+	unsigned long	st_nlink;
+
+	unsigned int	st_mode;
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+	unsigned int	__pad0;
+
+	unsigned long	st_rdev;
+	long		st_size;
+	long		st_blksize;
+	long		st_blocks;
+
+	unsigned long	st_atime;
+	unsigned long	st_atime_nsec;
+	unsigned long	st_mtime;
+	unsigned long	st_mtime_nsec;
+	unsigned long	st_ctime;
+	unsigned long	st_ctime_nsec;
+	long		__unused[3];
+};
+
+#endif
diff --git a/include/asm-sparc/statfs.h b/include/asm-sparc/statfs.h
index 304520f..26cb3c2 100644
--- a/include/asm-sparc/statfs.h
+++ b/include/asm-sparc/statfs.h
@@ -1,6 +1,8 @@
-#ifndef _SPARC_STATFS_H
-#define _SPARC_STATFS_H
-
-#include <asm-generic/statfs.h>
-
+#ifndef _ASM_SPARC_STATFS_H
+#define _ASM_SPARC_STATFS_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/statfs_64.h>
+#else
+#include <asm-sparc/statfs_32.h>
+#endif
 #endif
diff --git a/include/asm-sparc/statfs_32.h b/include/asm-sparc/statfs_32.h
new file mode 100644
index 0000000..304520f
--- /dev/null
+++ b/include/asm-sparc/statfs_32.h
@@ -0,0 +1,6 @@
+#ifndef _SPARC_STATFS_H
+#define _SPARC_STATFS_H
+
+#include <asm-generic/statfs.h>
+
+#endif
diff --git a/include/asm-sparc/statfs_64.h b/include/asm-sparc/statfs_64.h
new file mode 100644
index 0000000..79b3c89
--- /dev/null
+++ b/include/asm-sparc/statfs_64.h
@@ -0,0 +1,54 @@
+#ifndef _SPARC64_STATFS_H
+#define _SPARC64_STATFS_H
+
+#ifndef __KERNEL_STRICT_NAMES
+
+#include <linux/types.h>
+
+typedef __kernel_fsid_t	fsid_t;
+
+#endif
+
+struct statfs {
+	long f_type;
+	long f_bsize;
+	long f_blocks;
+	long f_bfree;
+	long f_bavail;
+	long f_files;
+	long f_ffree;
+	__kernel_fsid_t f_fsid;
+	long f_namelen;
+	long f_frsize;
+	long f_spare[5];
+};
+
+struct statfs64 {
+	long f_type;
+	long f_bsize;
+	long f_blocks;
+	long f_bfree;
+	long f_bavail;
+	long f_files;
+	long f_ffree;
+	__kernel_fsid_t f_fsid;
+	long f_namelen;
+	long f_frsize;
+	long f_spare[5];
+};
+
+struct compat_statfs64 {
+	__u32 f_type;
+	__u32 f_bsize;
+	__u64 f_blocks;
+	__u64 f_bfree;
+	__u64 f_bavail;
+	__u64 f_files;
+	__u64 f_ffree;
+	__kernel_fsid_t f_fsid;
+	__u32 f_namelen;
+	__u32 f_frsize;
+	__u32 f_spare[5];
+};
+
+#endif
diff --git a/include/asm-sparc/unistd.h b/include/asm-sparc/unistd.h
index 2338a02..790ef77 100644
--- a/include/asm-sparc/unistd.h
+++ b/include/asm-sparc/unistd.h
@@ -1,378 +1,8 @@
-#ifndef _SPARC_UNISTD_H
-#define _SPARC_UNISTD_H
-
-/*
- * System calls under the Sparc.
- *
- * Don't be scared by the ugly clobbers, it is the only way I can
- * think of right now to force the arguments into fixed registers
- * before the trap into the system call with gcc 'asm' statements.
- *
- * Copyright (C) 1995, 2007 David S. Miller (davem@davemloft.net)
- *
- * SunOS compatibility based upon preliminary work which is:
- *
- * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
- */
-
-#define __NR_restart_syscall      0 /* Linux Specific				   */
-#define __NR_exit                 1 /* Common                                      */
-#define __NR_fork                 2 /* Common                                      */
-#define __NR_read                 3 /* Common                                      */
-#define __NR_write                4 /* Common                                      */
-#define __NR_open                 5 /* Common                                      */
-#define __NR_close                6 /* Common                                      */
-#define __NR_wait4                7 /* Common                                      */
-#define __NR_creat                8 /* Common                                      */
-#define __NR_link                 9 /* Common                                      */
-#define __NR_unlink              10 /* Common                                      */
-#define __NR_execv               11 /* SunOS Specific                              */
-#define __NR_chdir               12 /* Common                                      */
-#define __NR_chown		 13 /* Common					   */
-#define __NR_mknod               14 /* Common                                      */
-#define __NR_chmod               15 /* Common                                      */
-#define __NR_lchown              16 /* Common                                      */
-#define __NR_brk                 17 /* Common                                      */
-#define __NR_perfctr             18 /* Performance counter operations              */
-#define __NR_lseek               19 /* Common                                      */
-#define __NR_getpid              20 /* Common                                      */
-#define __NR_capget		 21 /* Linux Specific				   */
-#define __NR_capset		 22 /* Linux Specific				   */
-#define __NR_setuid              23 /* Implemented via setreuid in SunOS           */
-#define __NR_getuid              24 /* Common                                      */
-#define __NR_vmsplice	         25 /* ENOSYS under SunOS			   */
-#define __NR_ptrace              26 /* Common                                      */
-#define __NR_alarm               27 /* Implemented via setitimer in SunOS          */
-#define __NR_sigaltstack	 28 /* Common					   */
-#define __NR_pause               29 /* Is sigblock(0)->sigpause() in SunOS         */
-#define __NR_utime               30 /* Implemented via utimes() under SunOS        */
-#define __NR_lchown32            31 /* Linux sparc32 specific                      */
-#define __NR_fchown32            32 /* Linux sparc32 specific                      */
-#define __NR_access              33 /* Common                                      */
-#define __NR_nice                34 /* Implemented via get/setpriority() in SunOS  */
-#define __NR_chown32             35 /* Linux sparc32 specific                      */
-#define __NR_sync                36 /* Common                                      */
-#define __NR_kill                37 /* Common                                      */
-#define __NR_stat                38 /* Common                                      */
-#define __NR_sendfile		 39 /* Linux Specific				   */
-#define __NR_lstat               40 /* Common                                      */
-#define __NR_dup                 41 /* Common                                      */
-#define __NR_pipe                42 /* Common                                      */
-#define __NR_times               43 /* Implemented via getrusage() in SunOS        */
-#define __NR_getuid32            44 /* Linux sparc32 specific                      */
-#define __NR_umount2             45 /* Linux Specific                              */
-#define __NR_setgid              46 /* Implemented via setregid() in SunOS         */
-#define __NR_getgid              47 /* Common                                      */
-#define __NR_signal              48 /* Implemented via sigvec() in SunOS           */
-#define __NR_geteuid             49 /* SunOS calls getuid()                        */
-#define __NR_getegid             50 /* SunOS calls getgid()                        */
-#define __NR_acct                51 /* Common                                      */
-/* #define __NR_memory_ordering  52    Linux sparc64 specific			   */
-#define __NR_getgid32            53 /* Linux sparc32 specific                      */
-#define __NR_ioctl               54 /* Common                                      */
-#define __NR_reboot              55 /* Common                                      */
-#define __NR_mmap2		 56 /* Linux sparc32 Specific			   */
-#define __NR_symlink             57 /* Common                                      */
-#define __NR_readlink            58 /* Common                                      */
-#define __NR_execve              59 /* Common                                      */
-#define __NR_umask               60 /* Common                                      */
-#define __NR_chroot              61 /* Common                                      */
-#define __NR_fstat               62 /* Common                                      */
-#define __NR_fstat64		 63 /* Linux Specific			           */
-#define __NR_getpagesize         64 /* Common                                      */
-#define __NR_msync               65 /* Common in newer 1.3.x revs...               */
-#define __NR_vfork               66 /* Common                                      */
-#define __NR_pread64             67 /* Linux Specific                              */
-#define __NR_pwrite64            68 /* Linux Specific                              */
-#define __NR_geteuid32           69 /* Linux sparc32, sbrk under SunOS             */
-#define __NR_getegid32           70 /* Linux sparc32, sstk under SunOS             */
-#define __NR_mmap                71 /* Common                                      */
-#define __NR_setreuid32          72 /* Linux sparc32, vadvise under SunOS          */
-#define __NR_munmap              73 /* Common                                      */
-#define __NR_mprotect            74 /* Common                                      */
-#define __NR_madvise             75 /* Common                                      */
-#define __NR_vhangup             76 /* Common                                      */
-#define __NR_truncate64		 77 /* Linux sparc32 Specific			   */
-#define __NR_mincore             78 /* Common                                      */
-#define __NR_getgroups           79 /* Common                                      */
-#define __NR_setgroups           80 /* Common                                      */
-#define __NR_getpgrp             81 /* Common                                      */
-#define __NR_setgroups32         82 /* Linux sparc32, setpgrp under SunOS          */
-#define __NR_setitimer           83 /* Common                                      */
-#define __NR_ftruncate64	 84 /* Linux sparc32 Specific			   */
-#define __NR_swapon              85 /* Common                                      */
-#define __NR_getitimer           86 /* Common                                      */
-#define __NR_setuid32            87 /* Linux sparc32, gethostname under SunOS      */
-#define __NR_sethostname         88 /* Common                                      */
-#define __NR_setgid32            89 /* Linux sparc32, getdtablesize under SunOS    */
-#define __NR_dup2                90 /* Common                                      */
-#define __NR_setfsuid32          91 /* Linux sparc32, getdopt under SunOS          */
-#define __NR_fcntl               92 /* Common                                      */
-#define __NR_select              93 /* Common                                      */
-#define __NR_setfsgid32          94 /* Linux sparc32, setdopt under SunOS          */
-#define __NR_fsync               95 /* Common                                      */
-#define __NR_setpriority         96 /* Common                                      */
-#define __NR_socket              97 /* Common                                      */
-#define __NR_connect             98 /* Common                                      */
-#define __NR_accept              99 /* Common                                      */
-#define __NR_getpriority        100 /* Common                                      */
-#define __NR_rt_sigreturn       101 /* Linux Specific                              */
-#define __NR_rt_sigaction       102 /* Linux Specific                              */
-#define __NR_rt_sigprocmask     103 /* Linux Specific                              */
-#define __NR_rt_sigpending      104 /* Linux Specific                              */
-#define __NR_rt_sigtimedwait    105 /* Linux Specific                              */
-#define __NR_rt_sigqueueinfo    106 /* Linux Specific                              */
-#define __NR_rt_sigsuspend      107 /* Linux Specific                              */
-#define __NR_setresuid32        108 /* Linux Specific, sigvec under SunOS	   */
-#define __NR_getresuid32        109 /* Linux Specific, sigblock under SunOS	   */
-#define __NR_setresgid32        110 /* Linux Specific, sigsetmask under SunOS	   */
-#define __NR_getresgid32        111 /* Linux Specific, sigpause under SunOS	   */
-#define __NR_setregid32         112 /* Linux sparc32, sigstack under SunOS         */
-#define __NR_recvmsg            113 /* Common                                      */
-#define __NR_sendmsg            114 /* Common                                      */
-#define __NR_getgroups32        115 /* Linux sparc32, vtrace under SunOS           */
-#define __NR_gettimeofday       116 /* Common                                      */
-#define __NR_getrusage          117 /* Common                                      */
-#define __NR_getsockopt         118 /* Common                                      */
-#define __NR_getcwd		119 /* Linux Specific				   */
-#define __NR_readv              120 /* Common                                      */
-#define __NR_writev             121 /* Common                                      */
-#define __NR_settimeofday       122 /* Common                                      */
-#define __NR_fchown             123 /* Common                                      */
-#define __NR_fchmod             124 /* Common                                      */
-#define __NR_recvfrom           125 /* Common                                      */
-#define __NR_setreuid           126 /* Common                                      */
-#define __NR_setregid           127 /* Common                                      */
-#define __NR_rename             128 /* Common                                      */
-#define __NR_truncate           129 /* Common                                      */
-#define __NR_ftruncate          130 /* Common                                      */
-#define __NR_flock              131 /* Common                                      */
-#define __NR_lstat64		132 /* Linux Specific			           */
-#define __NR_sendto             133 /* Common                                      */
-#define __NR_shutdown           134 /* Common                                      */
-#define __NR_socketpair         135 /* Common                                      */
-#define __NR_mkdir              136 /* Common                                      */
-#define __NR_rmdir              137 /* Common                                      */
-#define __NR_utimes             138 /* SunOS Specific                              */
-#define __NR_stat64		139 /* Linux Specific			           */
-#define __NR_sendfile64         140 /* adjtime under SunOS                         */
-#define __NR_getpeername        141 /* Common                                      */
-#define __NR_futex              142 /* gethostid under SunOS                       */
-#define __NR_gettid             143 /* ENOSYS under SunOS                          */
-#define __NR_getrlimit          144 /* Common                                      */
-#define __NR_setrlimit          145 /* Common                                      */
-#define __NR_pivot_root		146 /* Linux Specific, killpg under SunOS          */
-#define __NR_prctl		147 /* ENOSYS under SunOS                          */
-#define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
-#define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
-#define __NR_getsockname        150 /* Common                                      */
-#define __NR_inotify_init       151 /* Linux specific                              */
-#define __NR_inotify_add_watch  152 /* Linux specific                              */
-#define __NR_poll               153 /* Common                                      */
-#define __NR_getdents64		154 /* Linux specific				   */
-#define __NR_fcntl64		155 /* Linux sparc32 Specific                      */
-#define __NR_inotify_rm_watch   156 /* Linux specific				   */
-#define __NR_statfs             157 /* Common                                      */
-#define __NR_fstatfs            158 /* Common                                      */
-#define __NR_umount             159 /* Common                                      */
-#define __NR_sched_set_affinity 160 /* Linux specific, async_daemon under SunOS    */
-#define __NR_sched_get_affinity 161 /* Linux specific, getfh under SunOS           */
-#define __NR_getdomainname      162 /* SunOS Specific                              */
-#define __NR_setdomainname      163 /* Common                                      */
-/* #define __NR_utrap_install   164    Linux sparc64 specific			   */
-#define __NR_quotactl           165 /* Common                                      */
-#define __NR_set_tid_address    166 /* Linux specific, exportfs under SunOS        */
-#define __NR_mount              167 /* Common                                      */
-#define __NR_ustat              168 /* Common                                      */
-#define __NR_setxattr           169 /* SunOS: semsys                               */
-#define __NR_lsetxattr          170 /* SunOS: msgsys                               */
-#define __NR_fsetxattr          171 /* SunOS: shmsys                               */
-#define __NR_getxattr           172 /* SunOS: auditsys                             */
-#define __NR_lgetxattr          173 /* SunOS: rfssys                               */
-#define __NR_getdents           174 /* Common                                      */
-#define __NR_setsid             175 /* Common                                      */
-#define __NR_fchdir             176 /* Common                                      */
-#define __NR_fgetxattr          177 /* SunOS: fchroot                              */
-#define __NR_listxattr          178 /* SunOS: vpixsys                              */
-#define __NR_llistxattr         179 /* SunOS: aioread                              */
-#define __NR_flistxattr         180 /* SunOS: aiowrite                             */
-#define __NR_removexattr        181 /* SunOS: aiowait                              */
-#define __NR_lremovexattr       182 /* SunOS: aiocancel                            */
-#define __NR_sigpending         183 /* Common                                      */
-#define __NR_query_module	184 /* Linux Specific				   */
-#define __NR_setpgid            185 /* Common                                      */
-#define __NR_fremovexattr       186 /* SunOS: pathconf                             */
-#define __NR_tkill              187 /* SunOS: fpathconf                            */
-#define __NR_exit_group		188 /* Linux specific, sysconf undef SunOS         */
-#define __NR_uname              189 /* Linux Specific                              */
-#define __NR_init_module        190 /* Linux Specific                              */
-#define __NR_personality        191 /* Linux Specific                              */
-#define __NR_remap_file_pages   192 /* Linux Specific                              */
-#define __NR_epoll_create       193 /* Linux Specific                              */
-#define __NR_epoll_ctl          194 /* Linux Specific                              */
-#define __NR_epoll_wait         195 /* Linux Specific                              */
-#define __NR_ioprio_set         196 /* Linux Specific                              */
-#define __NR_getppid            197 /* Linux Specific                              */
-#define __NR_sigaction          198 /* Linux Specific                              */
-#define __NR_sgetmask           199 /* Linux Specific                              */
-#define __NR_ssetmask           200 /* Linux Specific                              */
-#define __NR_sigsuspend         201 /* Linux Specific                              */
-#define __NR_oldlstat           202 /* Linux Specific                              */
-#define __NR_uselib             203 /* Linux Specific                              */
-#define __NR_readdir            204 /* Linux Specific                              */
-#define __NR_readahead          205 /* Linux Specific                              */
-#define __NR_socketcall         206 /* Linux Specific                              */
-#define __NR_syslog             207 /* Linux Specific                              */
-#define __NR_lookup_dcookie     208 /* Linux Specific                              */
-#define __NR_fadvise64          209 /* Linux Specific                              */
-#define __NR_fadvise64_64       210 /* Linux Specific                              */
-#define __NR_tgkill             211 /* Linux Specific                              */
-#define __NR_waitpid            212 /* Linux Specific                              */
-#define __NR_swapoff            213 /* Linux Specific                              */
-#define __NR_sysinfo            214 /* Linux Specific                              */
-#define __NR_ipc                215 /* Linux Specific                              */
-#define __NR_sigreturn          216 /* Linux Specific                              */
-#define __NR_clone              217 /* Linux Specific                              */
-#define __NR_ioprio_get         218 /* Linux Specific                              */
-#define __NR_adjtimex           219 /* Linux Specific                              */
-#define __NR_sigprocmask        220 /* Linux Specific                              */
-#define __NR_create_module      221 /* Linux Specific                              */
-#define __NR_delete_module      222 /* Linux Specific                              */
-#define __NR_get_kernel_syms    223 /* Linux Specific                              */
-#define __NR_getpgid            224 /* Linux Specific                              */
-#define __NR_bdflush            225 /* Linux Specific                              */
-#define __NR_sysfs              226 /* Linux Specific                              */
-#define __NR_afs_syscall        227 /* Linux Specific                              */
-#define __NR_setfsuid           228 /* Linux Specific                              */
-#define __NR_setfsgid           229 /* Linux Specific                              */
-#define __NR__newselect         230 /* Linux Specific                              */
-#define __NR_time               231 /* Linux Specific                              */
-#define __NR_splice             232 /* Linux Specific                              */
-#define __NR_stime              233 /* Linux Specific                              */
-#define __NR_statfs64           234 /* Linux Specific                              */
-#define __NR_fstatfs64          235 /* Linux Specific                              */
-#define __NR__llseek            236 /* Linux Specific                              */
-#define __NR_mlock              237
-#define __NR_munlock            238
-#define __NR_mlockall           239
-#define __NR_munlockall         240
-#define __NR_sched_setparam     241
-#define __NR_sched_getparam     242
-#define __NR_sched_setscheduler 243
-#define __NR_sched_getscheduler 244
-#define __NR_sched_yield        245
-#define __NR_sched_get_priority_max 246
-#define __NR_sched_get_priority_min 247
-#define __NR_sched_rr_get_interval  248
-#define __NR_nanosleep          249
-#define __NR_mremap             250
-#define __NR__sysctl            251
-#define __NR_getsid             252
-#define __NR_fdatasync          253
-#define __NR_nfsservctl         254
-#define __NR_sync_file_range	255
-#define __NR_clock_settime	256
-#define __NR_clock_gettime	257
-#define __NR_clock_getres	258
-#define __NR_clock_nanosleep	259
-#define __NR_sched_getaffinity	260
-#define __NR_sched_setaffinity	261
-#define __NR_timer_settime	262
-#define __NR_timer_gettime	263
-#define __NR_timer_getoverrun	264
-#define __NR_timer_delete	265
-#define __NR_timer_create	266
-/* #define __NR_vserver		267 Reserved for VSERVER */
-#define __NR_io_setup		268
-#define __NR_io_destroy		269
-#define __NR_io_submit		270
-#define __NR_io_cancel		271
-#define __NR_io_getevents	272
-#define __NR_mq_open		273
-#define __NR_mq_unlink		274
-#define __NR_mq_timedsend	275
-#define __NR_mq_timedreceive	276
-#define __NR_mq_notify		277
-#define __NR_mq_getsetattr	278
-#define __NR_waitid		279
-#define __NR_tee		280
-#define __NR_add_key		281
-#define __NR_request_key	282
-#define __NR_keyctl		283
-#define __NR_openat		284
-#define __NR_mkdirat		285
-#define __NR_mknodat		286
-#define __NR_fchownat		287
-#define __NR_futimesat		288
-#define __NR_fstatat64		289
-#define __NR_unlinkat		290
-#define __NR_renameat		291
-#define __NR_linkat		292
-#define __NR_symlinkat		293
-#define __NR_readlinkat		294
-#define __NR_fchmodat		295
-#define __NR_faccessat		296
-#define __NR_pselect6		297
-#define __NR_ppoll		298
-#define __NR_unshare		299
-#define __NR_set_robust_list	300
-#define __NR_get_robust_list	301
-#define __NR_migrate_pages	302
-#define __NR_mbind		303
-#define __NR_get_mempolicy	304
-#define __NR_set_mempolicy	305
-#define __NR_kexec_load		306
-#define __NR_move_pages		307
-#define __NR_getcpu		308
-#define __NR_epoll_pwait	309
-#define __NR_utimensat		310
-#define __NR_signalfd		311
-#define __NR_timerfd_create	312
-#define __NR_eventfd		313
-#define __NR_fallocate		314
-#define __NR_timerfd_settime	315
-#define __NR_timerfd_gettime	316
-
-#define NR_SYSCALLS		317
-
-/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
- * it never had the plain ones and there is no value to adding those
- * old versions into the syscall table.
- */
-#define __IGNORE_setresuid
-#define __IGNORE_getresuid
-#define __IGNORE_setresgid
-#define __IGNORE_getresgid
-
-#ifdef __KERNEL__
-#define __ARCH_WANT_IPC_PARSE_VERSION
-#define __ARCH_WANT_OLD_READDIR
-#define __ARCH_WANT_STAT64
-#define __ARCH_WANT_SYS_ALARM
-#define __ARCH_WANT_SYS_GETHOSTNAME
-#define __ARCH_WANT_SYS_PAUSE
-#define __ARCH_WANT_SYS_SGETMASK
-#define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_SYS_UTIME
-#define __ARCH_WANT_SYS_WAITPID
-#define __ARCH_WANT_SYS_SOCKETCALL
-#define __ARCH_WANT_SYS_FADVISE64
-#define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
-#define __ARCH_WANT_SYS_NICE
-#define __ARCH_WANT_SYS_OLDUMOUNT
-#define __ARCH_WANT_SYS_SIGPENDING
-#define __ARCH_WANT_SYS_SIGPROCMASK
-#define __ARCH_WANT_SYS_RT_SIGSUSPEND
-
-/*
- * "Conditional" syscalls
- *
- * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
- * but it doesn't work on all toolchains, so we just do it by hand
- */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
-
-#endif /* __KERNEL__ */
-#endif /* _SPARC_UNISTD_H */
+#ifndef _ASM_SPARC_UNISTD_H
+#define _ASM_SPARC_UNISTD_H
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm-sparc/unistd_64.h>
+#else
+#include <asm-sparc/unistd_32.h>
+#endif
+#endif
diff --git a/include/asm-sparc/unistd_32.h b/include/asm-sparc/unistd_32.h
new file mode 100644
index 0000000..2338a02
--- /dev/null
+++ b/include/asm-sparc/unistd_32.h
@@ -0,0 +1,378 @@
+#ifndef _SPARC_UNISTD_H
+#define _SPARC_UNISTD_H
+
+/*
+ * System calls under the Sparc.
+ *
+ * Don't be scared by the ugly clobbers, it is the only way I can
+ * think of right now to force the arguments into fixed registers
+ * before the trap into the system call with gcc 'asm' statements.
+ *
+ * Copyright (C) 1995, 2007 David S. Miller (davem@davemloft.net)
+ *
+ * SunOS compatibility based upon preliminary work which is:
+ *
+ * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
+ */
+
+#define __NR_restart_syscall      0 /* Linux Specific				   */
+#define __NR_exit                 1 /* Common                                      */
+#define __NR_fork                 2 /* Common                                      */
+#define __NR_read                 3 /* Common                                      */
+#define __NR_write                4 /* Common                                      */
+#define __NR_open                 5 /* Common                                      */
+#define __NR_close                6 /* Common                                      */
+#define __NR_wait4                7 /* Common                                      */
+#define __NR_creat                8 /* Common                                      */
+#define __NR_link                 9 /* Common                                      */
+#define __NR_unlink              10 /* Common                                      */
+#define __NR_execv               11 /* SunOS Specific                              */
+#define __NR_chdir               12 /* Common                                      */
+#define __NR_chown		 13 /* Common					   */
+#define __NR_mknod               14 /* Common                                      */
+#define __NR_chmod               15 /* Common                                      */
+#define __NR_lchown              16 /* Common                                      */
+#define __NR_brk                 17 /* Common                                      */
+#define __NR_perfctr             18 /* Performance counter operations              */
+#define __NR_lseek               19 /* Common                                      */
+#define __NR_getpid              20 /* Common                                      */
+#define __NR_capget		 21 /* Linux Specific				   */
+#define __NR_capset		 22 /* Linux Specific				   */
+#define __NR_setuid              23 /* Implemented via setreuid in SunOS           */
+#define __NR_getuid              24 /* Common                                      */
+#define __NR_vmsplice	         25 /* ENOSYS under SunOS			   */
+#define __NR_ptrace              26 /* Common                                      */
+#define __NR_alarm               27 /* Implemented via setitimer in SunOS          */
+#define __NR_sigaltstack	 28 /* Common					   */
+#define __NR_pause               29 /* Is sigblock(0)->sigpause() in SunOS         */
+#define __NR_utime               30 /* Implemented via utimes() under SunOS        */
+#define __NR_lchown32            31 /* Linux sparc32 specific                      */
+#define __NR_fchown32            32 /* Linux sparc32 specific                      */
+#define __NR_access              33 /* Common                                      */
+#define __NR_nice                34 /* Implemented via get/setpriority() in SunOS  */
+#define __NR_chown32             35 /* Linux sparc32 specific                      */
+#define __NR_sync                36 /* Common                                      */
+#define __NR_kill                37 /* Common                                      */
+#define __NR_stat                38 /* Common                                      */
+#define __NR_sendfile		 39 /* Linux Specific				   */
+#define __NR_lstat               40 /* Common                                      */
+#define __NR_dup                 41 /* Common                                      */
+#define __NR_pipe                42 /* Common                                      */
+#define __NR_times               43 /* Implemented via getrusage() in SunOS        */
+#define __NR_getuid32            44 /* Linux sparc32 specific                      */
+#define __NR_umount2             45 /* Linux Specific                              */
+#define __NR_setgid              46 /* Implemented via setregid() in SunOS         */
+#define __NR_getgid              47 /* Common                                      */
+#define __NR_signal              48 /* Implemented via sigvec() in SunOS           */
+#define __NR_geteuid             49 /* SunOS calls getuid()                        */
+#define __NR_getegid             50 /* SunOS calls getgid()                        */
+#define __NR_acct                51 /* Common                                      */
+/* #define __NR_memory_ordering  52    Linux sparc64 specific			   */
+#define __NR_getgid32            53 /* Linux sparc32 specific                      */
+#define __NR_ioctl               54 /* Common                                      */
+#define __NR_reboot              55 /* Common                                      */
+#define __NR_mmap2		 56 /* Linux sparc32 Specific			   */
+#define __NR_symlink             57 /* Common                                      */
+#define __NR_readlink            58 /* Common                                      */
+#define __NR_execve              59 /* Common                                      */
+#define __NR_umask               60 /* Common                                      */
+#define __NR_chroot              61 /* Common                                      */
+#define __NR_fstat               62 /* Common                                      */
+#define __NR_fstat64		 63 /* Linux Specific			           */
+#define __NR_getpagesize         64 /* Common                                      */
+#define __NR_msync               65 /* Common in newer 1.3.x revs...               */
+#define __NR_vfork               66 /* Common                                      */
+#define __NR_pread64             67 /* Linux Specific                              */
+#define __NR_pwrite64            68 /* Linux Specific                              */
+#define __NR_geteuid32           69 /* Linux sparc32, sbrk under SunOS             */
+#define __NR_getegid32           70 /* Linux sparc32, sstk under SunOS             */
+#define __NR_mmap                71 /* Common                                      */
+#define __NR_setreuid32          72 /* Linux sparc32, vadvise under SunOS          */
+#define __NR_munmap              73 /* Common                                      */
+#define __NR_mprotect            74 /* Common                                      */
+#define __NR_madvise             75 /* Common                                      */
+#define __NR_vhangup             76 /* Common                                      */
+#define __NR_truncate64		 77 /* Linux sparc32 Specific			   */
+#define __NR_mincore             78 /* Common                                      */
+#define __NR_getgroups           79 /* Common                                      */
+#define __NR_setgroups           80 /* Common                                      */
+#define __NR_getpgrp             81 /* Common                                      */
+#define __NR_setgroups32         82 /* Linux sparc32, setpgrp under SunOS          */
+#define __NR_setitimer           83 /* Common                                      */
+#define __NR_ftruncate64	 84 /* Linux sparc32 Specific			   */
+#define __NR_swapon              85 /* Common                                      */
+#define __NR_getitimer           86 /* Common                                      */
+#define __NR_setuid32            87 /* Linux sparc32, gethostname under SunOS      */
+#define __NR_sethostname         88 /* Common                                      */
+#define __NR_setgid32            89 /* Linux sparc32, getdtablesize under SunOS    */
+#define __NR_dup2                90 /* Common                                      */
+#define __NR_setfsuid32          91 /* Linux sparc32, getdopt under SunOS          */
+#define __NR_fcntl               92 /* Common                                      */
+#define __NR_select              93 /* Common                                      */
+#define __NR_setfsgid32          94 /* Linux sparc32, setdopt under SunOS          */
+#define __NR_fsync               95 /* Common                                      */
+#define __NR_setpriority         96 /* Common                                      */
+#define __NR_socket              97 /* Common                                      */
+#define __NR_connect             98 /* Common                                      */
+#define __NR_accept              99 /* Common                                      */
+#define __NR_getpriority        100 /* Common                                      */
+#define __NR_rt_sigreturn       101 /* Linux Specific                              */
+#define __NR_rt_sigaction       102 /* Linux Specific                              */
+#define __NR_rt_sigprocmask     103 /* Linux Specific                              */
+#define __NR_rt_sigpending      104 /* Linux Specific                              */
+#define __NR_rt_sigtimedwait    105 /* Linux Specific                              */
+#define __NR_rt_sigqueueinfo    106 /* Linux Specific                              */
+#define __NR_rt_sigsuspend      107 /* Linux Specific                              */
+#define __NR_setresuid32        108 /* Linux Specific, sigvec under SunOS	   */
+#define __NR_getresuid32        109 /* Linux Specific, sigblock under SunOS	   */
+#define __NR_setresgid32        110 /* Linux Specific, sigsetmask under SunOS	   */
+#define __NR_getresgid32        111 /* Linux Specific, sigpause under SunOS	   */
+#define __NR_setregid32         112 /* Linux sparc32, sigstack under SunOS         */
+#define __NR_recvmsg            113 /* Common                                      */
+#define __NR_sendmsg            114 /* Common                                      */
+#define __NR_getgroups32        115 /* Linux sparc32, vtrace under SunOS           */
+#define __NR_gettimeofday       116 /* Common                                      */
+#define __NR_getrusage          117 /* Common                                      */
+#define __NR_getsockopt         118 /* Common                                      */
+#define __NR_getcwd		119 /* Linux Specific				   */
+#define __NR_readv              120 /* Common                                      */
+#define __NR_writev             121 /* Common                                      */
+#define __NR_settimeofday       122 /* Common                                      */
+#define __NR_fchown             123 /* Common                                      */
+#define __NR_fchmod             124 /* Common                                      */
+#define __NR_recvfrom           125 /* Common                                      */
+#define __NR_setreuid           126 /* Common                                      */
+#define __NR_setregid           127 /* Common                                      */
+#define __NR_rename             128 /* Common                                      */
+#define __NR_truncate           129 /* Common                                      */
+#define __NR_ftruncate          130 /* Common                                      */
+#define __NR_flock              131 /* Common                                      */
+#define __NR_lstat64		132 /* Linux Specific			           */
+#define __NR_sendto             133 /* Common                                      */
+#define __NR_shutdown           134 /* Common                                      */
+#define __NR_socketpair         135 /* Common                                      */
+#define __NR_mkdir              136 /* Common                                      */
+#define __NR_rmdir              137 /* Common                                      */
+#define __NR_utimes             138 /* SunOS Specific                              */
+#define __NR_stat64		139 /* Linux Specific			           */
+#define __NR_sendfile64         140 /* adjtime under SunOS                         */
+#define __NR_getpeername        141 /* Common                                      */
+#define __NR_futex              142 /* gethostid under SunOS                       */
+#define __NR_gettid             143 /* ENOSYS under SunOS                          */
+#define __NR_getrlimit          144 /* Common                                      */
+#define __NR_setrlimit          145 /* Common                                      */
+#define __NR_pivot_root		146 /* Linux Specific, killpg under SunOS          */
+#define __NR_prctl		147 /* ENOSYS under SunOS                          */
+#define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
+#define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
+#define __NR_getsockname        150 /* Common                                      */
+#define __NR_inotify_init       151 /* Linux specific                              */
+#define __NR_inotify_add_watch  152 /* Linux specific                              */
+#define __NR_poll               153 /* Common                                      */
+#define __NR_getdents64		154 /* Linux specific				   */
+#define __NR_fcntl64		155 /* Linux sparc32 Specific                      */
+#define __NR_inotify_rm_watch   156 /* Linux specific				   */
+#define __NR_statfs             157 /* Common                                      */
+#define __NR_fstatfs            158 /* Common                                      */
+#define __NR_umount             159 /* Common                                      */
+#define __NR_sched_set_affinity 160 /* Linux specific, async_daemon under SunOS    */
+#define __NR_sched_get_affinity 161 /* Linux specific, getfh under SunOS           */
+#define __NR_getdomainname      162 /* SunOS Specific                              */
+#define __NR_setdomainname      163 /* Common                                      */
+/* #define __NR_utrap_install   164    Linux sparc64 specific			   */
+#define __NR_quotactl           165 /* Common                                      */
+#define __NR_set_tid_address    166 /* Linux specific, exportfs under SunOS        */
+#define __NR_mount              167 /* Common                                      */
+#define __NR_ustat              168 /* Common                                      */
+#define __NR_setxattr           169 /* SunOS: semsys                               */
+#define __NR_lsetxattr          170 /* SunOS: msgsys                               */
+#define __NR_fsetxattr          171 /* SunOS: shmsys                               */
+#define __NR_getxattr           172 /* SunOS: auditsys                             */
+#define __NR_lgetxattr          173 /* SunOS: rfssys                               */
+#define __NR_getdents           174 /* Common                                      */
+#define __NR_setsid             175 /* Common                                      */
+#define __NR_fchdir             176 /* Common                                      */
+#define __NR_fgetxattr          177 /* SunOS: fchroot                              */
+#define __NR_listxattr          178 /* SunOS: vpixsys                              */
+#define __NR_llistxattr         179 /* SunOS: aioread                              */
+#define __NR_flistxattr         180 /* SunOS: aiowrite                             */
+#define __NR_removexattr        181 /* SunOS: aiowait                              */
+#define __NR_lremovexattr       182 /* SunOS: aiocancel                            */
+#define __NR_sigpending         183 /* Common                                      */
+#define __NR_query_module	184 /* Linux Specific				   */
+#define __NR_setpgid            185 /* Common                                      */
+#define __NR_fremovexattr       186 /* SunOS: pathconf                             */
+#define __NR_tkill              187 /* SunOS: fpathconf                            */
+#define __NR_exit_group		188 /* Linux specific, sysconf undef SunOS         */
+#define __NR_uname              189 /* Linux Specific                              */
+#define __NR_init_module        190 /* Linux Specific                              */
+#define __NR_personality        191 /* Linux Specific                              */
+#define __NR_remap_file_pages   192 /* Linux Specific                              */
+#define __NR_epoll_create       193 /* Linux Specific                              */
+#define __NR_epoll_ctl          194 /* Linux Specific                              */
+#define __NR_epoll_wait         195 /* Linux Specific                              */
+#define __NR_ioprio_set         196 /* Linux Specific                              */
+#define __NR_getppid            197 /* Linux Specific                              */
+#define __NR_sigaction          198 /* Linux Specific                              */
+#define __NR_sgetmask           199 /* Linux Specific                              */
+#define __NR_ssetmask           200 /* Linux Specific                              */
+#define __NR_sigsuspend         201 /* Linux Specific                              */
+#define __NR_oldlstat           202 /* Linux Specific                              */
+#define __NR_uselib             203 /* Linux Specific                              */
+#define __NR_readdir            204 /* Linux Specific                              */
+#define __NR_readahead          205 /* Linux Specific                              */
+#define __NR_socketcall         206 /* Linux Specific                              */
+#define __NR_syslog             207 /* Linux Specific                              */
+#define __NR_lookup_dcookie     208 /* Linux Specific                              */
+#define __NR_fadvise64          209 /* Linux Specific                              */
+#define __NR_fadvise64_64       210 /* Linux Specific                              */
+#define __NR_tgkill             211 /* Linux Specific                              */
+#define __NR_waitpid            212 /* Linux Specific                              */
+#define __NR_swapoff            213 /* Linux Specific                              */
+#define __NR_sysinfo            214 /* Linux Specific                              */
+#define __NR_ipc                215 /* Linux Specific                              */
+#define __NR_sigreturn          216 /* Linux Specific                              */
+#define __NR_clone              217 /* Linux Specific                              */
+#define __NR_ioprio_get         218 /* Linux Specific                              */
+#define __NR_adjtimex           219 /* Linux Specific                              */
+#define __NR_sigprocmask        220 /* Linux Specific                              */
+#define __NR_create_module      221 /* Linux Specific                              */
+#define __NR_delete_module      222 /* Linux Specific                              */
+#define __NR_get_kernel_syms    223 /* Linux Specific                              */
+#define __NR_getpgid            224 /* Linux Specific                              */
+#define __NR_bdflush            225 /* Linux Specific                              */
+#define __NR_sysfs              226 /* Linux Specific                              */
+#define __NR_afs_syscall        227 /* Linux Specific                              */
+#define __NR_setfsuid           228 /* Linux Specific                              */
+#define __NR_setfsgid           229 /* Linux Specific                              */
+#define __NR__newselect         230 /* Linux Specific                              */
+#define __NR_time               231 /* Linux Specific                              */
+#define __NR_splice             232 /* Linux Specific                              */
+#define __NR_stime              233 /* Linux Specific                              */
+#define __NR_statfs64           234 /* Linux Specific                              */
+#define __NR_fstatfs64          235 /* Linux Specific                              */
+#define __NR__llseek            236 /* Linux Specific                              */
+#define __NR_mlock              237
+#define __NR_munlock            238
+#define __NR_mlockall           239
+#define __NR_munlockall         240
+#define __NR_sched_setparam     241
+#define __NR_sched_getparam     242
+#define __NR_sched_setscheduler 243
+#define __NR_sched_getscheduler 244
+#define __NR_sched_yield        245
+#define __NR_sched_get_priority_max 246
+#define __NR_sched_get_priority_min 247
+#define __NR_sched_rr_get_interval  248
+#define __NR_nanosleep          249
+#define __NR_mremap             250
+#define __NR__sysctl            251
+#define __NR_getsid             252
+#define __NR_fdatasync          253
+#define __NR_nfsservctl         254
+#define __NR_sync_file_range	255
+#define __NR_clock_settime	256
+#define __NR_clock_gettime	257
+#define __NR_clock_getres	258
+#define __NR_clock_nanosleep	259
+#define __NR_sched_getaffinity	260
+#define __NR_sched_setaffinity	261
+#define __NR_timer_settime	262
+#define __NR_timer_gettime	263
+#define __NR_timer_getoverrun	264
+#define __NR_timer_delete	265
+#define __NR_timer_create	266
+/* #define __NR_vserver		267 Reserved for VSERVER */
+#define __NR_io_setup		268
+#define __NR_io_destroy		269
+#define __NR_io_submit		270
+#define __NR_io_cancel		271
+#define __NR_io_getevents	272
+#define __NR_mq_open		273
+#define __NR_mq_unlink		274
+#define __NR_mq_timedsend	275
+#define __NR_mq_timedreceive	276
+#define __NR_mq_notify		277
+#define __NR_mq_getsetattr	278
+#define __NR_waitid		279
+#define __NR_tee		280
+#define __NR_add_key		281
+#define __NR_request_key	282
+#define __NR_keyctl		283
+#define __NR_openat		284
+#define __NR_mkdirat		285
+#define __NR_mknodat		286
+#define __NR_fchownat		287
+#define __NR_futimesat		288
+#define __NR_fstatat64		289
+#define __NR_unlinkat		290
+#define __NR_renameat		291
+#define __NR_linkat		292
+#define __NR_symlinkat		293
+#define __NR_readlinkat		294
+#define __NR_fchmodat		295
+#define __NR_faccessat		296
+#define __NR_pselect6		297
+#define __NR_ppoll		298
+#define __NR_unshare		299
+#define __NR_set_robust_list	300
+#define __NR_get_robust_list	301
+#define __NR_migrate_pages	302
+#define __NR_mbind		303
+#define __NR_get_mempolicy	304
+#define __NR_set_mempolicy	305
+#define __NR_kexec_load		306
+#define __NR_move_pages		307
+#define __NR_getcpu		308
+#define __NR_epoll_pwait	309
+#define __NR_utimensat		310
+#define __NR_signalfd		311
+#define __NR_timerfd_create	312
+#define __NR_eventfd		313
+#define __NR_fallocate		314
+#define __NR_timerfd_settime	315
+#define __NR_timerfd_gettime	316
+
+#define NR_SYSCALLS		317
+
+/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
+ * it never had the plain ones and there is no value to adding those
+ * old versions into the syscall table.
+ */
+#define __IGNORE_setresuid
+#define __IGNORE_getresuid
+#define __IGNORE_setresgid
+#define __IGNORE_getresgid
+
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
+
+/*
+ * "Conditional" syscalls
+ *
+ * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
+ * but it doesn't work on all toolchains, so we just do it by hand
+ */
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
+
+#endif /* __KERNEL__ */
+#endif /* _SPARC_UNISTD_H */
diff --git a/include/asm-sparc/unistd_64.h b/include/asm-sparc/unistd_64.h
new file mode 100644
index 0000000..13be445
--- /dev/null
+++ b/include/asm-sparc/unistd_64.h
@@ -0,0 +1,373 @@
+#ifndef _SPARC64_UNISTD_H
+#define _SPARC64_UNISTD_H
+
+/*
+ * System calls under the Sparc.
+ *
+ * Don't be scared by the ugly clobbers, it is the only way I can
+ * think of right now to force the arguments into fixed registers
+ * before the trap into the system call with gcc 'asm' statements.
+ *
+ * Copyright (C) 1995, 2007 David S. Miller (davem@davemloft.net)
+ *
+ * SunOS compatibility based upon preliminary work which is:
+ *
+ * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
+ */
+
+#define __NR_restart_syscall      0 /* Linux Specific				   */
+#define __NR_exit                 1 /* Common                                      */
+#define __NR_fork                 2 /* Common                                      */
+#define __NR_read                 3 /* Common                                      */
+#define __NR_write                4 /* Common                                      */
+#define __NR_open                 5 /* Common                                      */
+#define __NR_close                6 /* Common                                      */
+#define __NR_wait4                7 /* Common                                      */
+#define __NR_creat                8 /* Common                                      */
+#define __NR_link                 9 /* Common                                      */
+#define __NR_unlink              10 /* Common                                      */
+#define __NR_execv               11 /* SunOS Specific                              */
+#define __NR_chdir               12 /* Common                                      */
+#define __NR_chown		 13 /* Common					   */
+#define __NR_mknod               14 /* Common                                      */
+#define __NR_chmod               15 /* Common                                      */
+#define __NR_lchown              16 /* Common                                      */
+#define __NR_brk                 17 /* Common                                      */
+#define __NR_perfctr             18 /* Performance counter operations              */
+#define __NR_lseek               19 /* Common                                      */
+#define __NR_getpid              20 /* Common                                      */
+#define __NR_capget		 21 /* Linux Specific				   */
+#define __NR_capset		 22 /* Linux Specific				   */
+#define __NR_setuid              23 /* Implemented via setreuid in SunOS           */
+#define __NR_getuid              24 /* Common                                      */
+#define __NR_vmsplice	         25 /* ENOSYS under SunOS			   */
+#define __NR_ptrace              26 /* Common                                      */
+#define __NR_alarm               27 /* Implemented via setitimer in SunOS          */
+#define __NR_sigaltstack	 28 /* Common					   */
+#define __NR_pause               29 /* Is sigblock(0)->sigpause() in SunOS         */
+#define __NR_utime               30 /* Implemented via utimes() under SunOS        */
+/* #define __NR_lchown32         31    Linux sparc32 specific                      */
+/* #define __NR_fchown32         32    Linux sparc32 specific                      */
+#define __NR_access              33 /* Common                                      */
+#define __NR_nice                34 /* Implemented via get/setpriority() in SunOS  */
+/* #define __NR_chown32          35    Linux sparc32 specific                      */
+#define __NR_sync                36 /* Common                                      */
+#define __NR_kill                37 /* Common                                      */
+#define __NR_stat                38 /* Common                                      */
+#define __NR_sendfile		 39 /* Linux Specific				   */
+#define __NR_lstat               40 /* Common                                      */
+#define __NR_dup                 41 /* Common                                      */
+#define __NR_pipe                42 /* Common                                      */
+#define __NR_times               43 /* Implemented via getrusage() in SunOS        */
+/* #define __NR_getuid32         44    Linux sparc32 specific                      */
+#define __NR_umount2             45 /* Linux Specific                              */
+#define __NR_setgid              46 /* Implemented via setregid() in SunOS         */
+#define __NR_getgid              47 /* Common                                      */
+#define __NR_signal              48 /* Implemented via sigvec() in SunOS           */
+#define __NR_geteuid             49 /* SunOS calls getuid()                        */
+#define __NR_getegid             50 /* SunOS calls getgid()                        */
+#define __NR_acct                51 /* Common                                      */
+#define __NR_memory_ordering	 52 /* Linux Specific				   */
+/* #define __NR_getgid32         53    Linux sparc32 specific                      */
+#define __NR_ioctl               54 /* Common                                      */
+#define __NR_reboot              55 /* Common                                      */
+/* #define __NR_mmap2		 56    Linux sparc32 Specific                      */
+#define __NR_symlink             57 /* Common                                      */
+#define __NR_readlink            58 /* Common                                      */
+#define __NR_execve              59 /* Common                                      */
+#define __NR_umask               60 /* Common                                      */
+#define __NR_chroot              61 /* Common                                      */
+#define __NR_fstat               62 /* Common                                      */
+#define __NR_fstat64             63 /* Linux Specific                              */
+#define __NR_getpagesize         64 /* Common                                      */
+#define __NR_msync               65 /* Common in newer 1.3.x revs...               */
+#define __NR_vfork               66 /* Common                                      */
+#define __NR_pread64             67 /* Linux Specific                              */
+#define __NR_pwrite64            68 /* Linux Specific                              */
+/* #define __NR_geteuid32        69    Linux sparc32, sbrk under SunOS             */
+/* #define __NR_getegid32        70    Linux sparc32, sstk under SunOS             */
+#define __NR_mmap                71 /* Common                                      */
+/* #define __NR_setreuid32       72    Linux sparc32, vadvise under SunOS          */
+#define __NR_munmap              73 /* Common                                      */
+#define __NR_mprotect            74 /* Common                                      */
+#define __NR_madvise             75 /* Common                                      */
+#define __NR_vhangup             76 /* Common                                      */
+/* #define __NR_truncate64       77    Linux sparc32 Specific			   */
+#define __NR_mincore             78 /* Common                                      */
+#define __NR_getgroups           79 /* Common                                      */
+#define __NR_setgroups           80 /* Common                                      */
+#define __NR_getpgrp             81 /* Common                                      */
+/* #define __NR_setgroups32      82    Linux sparc32, setpgrp under SunOS          */
+#define __NR_setitimer           83 /* Common                                      */
+/* #define __NR_ftruncate64      84    Linux sparc32 Specific			   */
+#define __NR_swapon              85 /* Common                                      */
+#define __NR_getitimer           86 /* Common                                      */
+/* #define __NR_setuid32         87    Linux sparc32, gethostname under SunOS      */
+#define __NR_sethostname         88 /* Common                                      */
+/* #define __NR_setgid32         89    Linux sparc32, getdtablesize under SunOS    */
+#define __NR_dup2                90 /* Common                                      */
+/* #define __NR_setfsuid32       91    Linux sparc32, getdopt under SunOS          */
+#define __NR_fcntl               92 /* Common                                      */
+#define __NR_select              93 /* Common                                      */
+/* #define __NR_setfsgid32       94    Linux sparc32, setdopt under SunOS          */
+#define __NR_fsync               95 /* Common                                      */
+#define __NR_setpriority         96 /* Common                                      */
+#define __NR_socket              97 /* Common                                      */
+#define __NR_connect             98 /* Common                                      */
+#define __NR_accept              99 /* Common                                      */
+#define __NR_getpriority        100 /* Common                                      */
+#define __NR_rt_sigreturn       101 /* Linux Specific                              */
+#define __NR_rt_sigaction       102 /* Linux Specific                              */
+#define __NR_rt_sigprocmask     103 /* Linux Specific                              */
+#define __NR_rt_sigpending      104 /* Linux Specific                              */
+#define __NR_rt_sigtimedwait    105 /* Linux Specific                              */
+#define __NR_rt_sigqueueinfo    106 /* Linux Specific                              */
+#define __NR_rt_sigsuspend      107 /* Linux Specific                              */
+#define __NR_setresuid          108 /* Linux Specific, sigvec under SunOS	   */
+#define __NR_getresuid          109 /* Linux Specific, sigblock under SunOS	   */
+#define __NR_setresgid          110 /* Linux Specific, sigsetmask under SunOS	   */
+#define __NR_getresgid          111 /* Linux Specific, sigpause under SunOS	   */
+/* #define __NR_setregid32       75    Linux sparc32, sigstack under SunOS         */
+#define __NR_recvmsg            113 /* Common                                      */
+#define __NR_sendmsg            114 /* Common                                      */
+/* #define __NR_getgroups32     115    Linux sparc32, vtrace under SunOS           */
+#define __NR_gettimeofday       116 /* Common                                      */
+#define __NR_getrusage          117 /* Common                                      */
+#define __NR_getsockopt         118 /* Common                                      */
+#define __NR_getcwd		119 /* Linux Specific				   */
+#define __NR_readv              120 /* Common                                      */
+#define __NR_writev             121 /* Common                                      */
+#define __NR_settimeofday       122 /* Common                                      */
+#define __NR_fchown             123 /* Common                                      */
+#define __NR_fchmod             124 /* Common                                      */
+#define __NR_recvfrom           125 /* Common                                      */
+#define __NR_setreuid           126 /* Common                                      */
+#define __NR_setregid           127 /* Common                                      */
+#define __NR_rename             128 /* Common                                      */
+#define __NR_truncate           129 /* Common                                      */
+#define __NR_ftruncate          130 /* Common                                      */
+#define __NR_flock              131 /* Common                                      */
+#define __NR_lstat64		132 /* Linux Specific                              */
+#define __NR_sendto             133 /* Common                                      */
+#define __NR_shutdown           134 /* Common                                      */
+#define __NR_socketpair         135 /* Common                                      */
+#define __NR_mkdir              136 /* Common                                      */
+#define __NR_rmdir              137 /* Common                                      */
+#define __NR_utimes             138 /* SunOS Specific                              */
+#define __NR_stat64		139 /* Linux Specific			           */
+#define __NR_sendfile64         140 /* adjtime under SunOS                         */
+#define __NR_getpeername        141 /* Common                                      */
+#define __NR_futex              142 /* gethostid under SunOS                       */
+#define __NR_gettid             143 /* ENOSYS under SunOS                          */
+#define __NR_getrlimit		144 /* Common                                      */
+#define __NR_setrlimit          145 /* Common                                      */
+#define __NR_pivot_root		146 /* Linux Specific, killpg under SunOS          */
+#define __NR_prctl		147 /* ENOSYS under SunOS                          */
+#define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
+#define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
+#define __NR_getsockname        150 /* Common                                      */
+#define __NR_inotify_init       151 /* Linux specific                              */
+#define __NR_inotify_add_watch  152 /* Linux specific                              */
+#define __NR_poll               153 /* Common                                      */
+#define __NR_getdents64		154 /* Linux specific				   */
+/* #define __NR_fcntl64         155    Linux sparc32 Specific                      */
+#define __NR_inotify_rm_watch   156 /* Linux specific				   */
+#define __NR_statfs             157 /* Common                                      */
+#define __NR_fstatfs            158 /* Common                                      */
+#define __NR_umount             159 /* Common                                      */
+#define __NR_sched_set_affinity 160 /* Linux specific, async_daemon under SunOS    */
+#define __NR_sched_get_affinity 161 /* Linux specific, getfh under SunOS           */
+#define __NR_getdomainname      162 /* SunOS Specific                              */
+#define __NR_setdomainname      163 /* Common                                      */
+#define __NR_utrap_install	164 /* SYSV ABI/v9 required			   */
+#define __NR_quotactl           165 /* Common                                      */
+#define __NR_set_tid_address    166 /* Linux specific, exportfs under SunOS        */
+#define __NR_mount              167 /* Common                                      */
+#define __NR_ustat              168 /* Common                                      */
+#define __NR_setxattr           169 /* SunOS: semsys                               */
+#define __NR_lsetxattr          170 /* SunOS: msgsys                               */
+#define __NR_fsetxattr          171 /* SunOS: shmsys                               */
+#define __NR_getxattr           172 /* SunOS: auditsys                             */
+#define __NR_lgetxattr          173 /* SunOS: rfssys                               */
+#define __NR_getdents           174 /* Common                                      */
+#define __NR_setsid             175 /* Common                                      */
+#define __NR_fchdir             176 /* Common                                      */
+#define __NR_fgetxattr          177 /* SunOS: fchroot                              */
+#define __NR_listxattr          178 /* SunOS: vpixsys                              */
+#define __NR_llistxattr         179 /* SunOS: aioread                              */
+#define __NR_flistxattr         180 /* SunOS: aiowrite                             */
+#define __NR_removexattr        181 /* SunOS: aiowait                              */
+#define __NR_lremovexattr       182 /* SunOS: aiocancel                            */
+#define __NR_sigpending         183 /* Common                                      */
+#define __NR_query_module	184 /* Linux Specific				   */
+#define __NR_setpgid            185 /* Common                                      */
+#define __NR_fremovexattr       186 /* SunOS: pathconf                             */
+#define __NR_tkill              187 /* SunOS: fpathconf                            */
+#define __NR_exit_group		188 /* Linux specific, sysconf undef SunOS         */
+#define __NR_uname              189 /* Linux Specific                              */
+#define __NR_init_module        190 /* Linux Specific                              */
+#define __NR_personality        191 /* Linux Specific                              */
+#define __NR_remap_file_pages   192 /* Linux Specific                              */
+#define __NR_epoll_create       193 /* Linux Specific                              */
+#define __NR_epoll_ctl          194 /* Linux Specific                              */
+#define __NR_epoll_wait         195 /* Linux Specific                              */
+#define __NR_ioprio_set         196 /* Linux Specific                              */
+#define __NR_getppid            197 /* Linux Specific                              */
+#define __NR_sigaction          198 /* Linux Specific                              */
+#define __NR_sgetmask           199 /* Linux Specific                              */
+#define __NR_ssetmask           200 /* Linux Specific                              */
+#define __NR_sigsuspend         201 /* Linux Specific                              */
+#define __NR_oldlstat           202 /* Linux Specific                              */
+#define __NR_uselib             203 /* Linux Specific                              */
+#define __NR_readdir            204 /* Linux Specific                              */
+#define __NR_readahead          205 /* Linux Specific                              */
+#define __NR_socketcall         206 /* Linux Specific                              */
+#define __NR_syslog             207 /* Linux Specific                              */
+#define __NR_lookup_dcookie     208 /* Linux Specific                              */
+#define __NR_fadvise64          209 /* Linux Specific                              */
+#define __NR_fadvise64_64       210 /* Linux Specific                              */
+#define __NR_tgkill             211 /* Linux Specific                              */
+#define __NR_waitpid            212 /* Linux Specific                              */
+#define __NR_swapoff            213 /* Linux Specific                              */
+#define __NR_sysinfo            214 /* Linux Specific                              */
+#define __NR_ipc                215 /* Linux Specific                              */
+#define __NR_sigreturn          216 /* Linux Specific                              */
+#define __NR_clone              217 /* Linux Specific                              */
+#define __NR_ioprio_get         218 /* Linux Specific                              */
+#define __NR_adjtimex           219 /* Linux Specific                              */
+#define __NR_sigprocmask        220 /* Linux Specific                              */
+#define __NR_create_module      221 /* Linux Specific                              */
+#define __NR_delete_module      222 /* Linux Specific                              */
+#define __NR_get_kernel_syms    223 /* Linux Specific                              */
+#define __NR_getpgid            224 /* Linux Specific                              */
+#define __NR_bdflush            225 /* Linux Specific                              */
+#define __NR_sysfs              226 /* Linux Specific                              */
+#define __NR_afs_syscall        227 /* Linux Specific                              */
+#define __NR_setfsuid           228 /* Linux Specific                              */
+#define __NR_setfsgid           229 /* Linux Specific                              */
+#define __NR__newselect         230 /* Linux Specific                              */
+#ifdef __KERNEL__
+#define __NR_time		231 /* Linux sparc32                               */
+#endif
+#define __NR_splice             232 /* Linux Specific                              */
+#define __NR_stime              233 /* Linux Specific                              */
+#define __NR_statfs64           234 /* Linux Specific                              */
+#define __NR_fstatfs64          235 /* Linux Specific                              */
+#define __NR__llseek            236 /* Linux Specific                              */
+#define __NR_mlock              237
+#define __NR_munlock            238
+#define __NR_mlockall           239
+#define __NR_munlockall         240
+#define __NR_sched_setparam     241
+#define __NR_sched_getparam     242
+#define __NR_sched_setscheduler 243
+#define __NR_sched_getscheduler 244
+#define __NR_sched_yield        245
+#define __NR_sched_get_priority_max 246
+#define __NR_sched_get_priority_min 247
+#define __NR_sched_rr_get_interval  248
+#define __NR_nanosleep          249
+#define __NR_mremap             250
+#define __NR__sysctl            251
+#define __NR_getsid             252
+#define __NR_fdatasync          253
+#define __NR_nfsservctl         254
+#define __NR_sync_file_range	255
+#define __NR_clock_settime	256
+#define __NR_clock_gettime	257
+#define __NR_clock_getres	258
+#define __NR_clock_nanosleep	259
+#define __NR_sched_getaffinity	260
+#define __NR_sched_setaffinity	261
+#define __NR_timer_settime	262
+#define __NR_timer_gettime	263
+#define __NR_timer_getoverrun	264
+#define __NR_timer_delete	265
+#define __NR_timer_create	266
+/* #define __NR_vserver		267 Reserved for VSERVER */
+#define __NR_io_setup		268
+#define __NR_io_destroy		269
+#define __NR_io_submit		270
+#define __NR_io_cancel		271
+#define __NR_io_getevents	272
+#define __NR_mq_open		273
+#define __NR_mq_unlink		274
+#define __NR_mq_timedsend	275
+#define __NR_mq_timedreceive	276
+#define __NR_mq_notify		277
+#define __NR_mq_getsetattr	278
+#define __NR_waitid		279
+#define __NR_tee		280
+#define __NR_add_key		281
+#define __NR_request_key	282
+#define __NR_keyctl		283
+#define __NR_openat		284
+#define __NR_mkdirat		285
+#define __NR_mknodat		286
+#define __NR_fchownat		287
+#define __NR_futimesat		288
+#define __NR_fstatat64		289
+#define __NR_unlinkat		290
+#define __NR_renameat		291
+#define __NR_linkat		292
+#define __NR_symlinkat		293
+#define __NR_readlinkat		294
+#define __NR_fchmodat		295
+#define __NR_faccessat		296
+#define __NR_pselect6		297
+#define __NR_ppoll		298
+#define __NR_unshare		299
+#define __NR_set_robust_list	300
+#define __NR_get_robust_list	301
+#define __NR_migrate_pages	302
+#define __NR_mbind		303
+#define __NR_get_mempolicy	304
+#define __NR_set_mempolicy	305
+#define __NR_kexec_load		306
+#define __NR_move_pages		307
+#define __NR_getcpu		308
+#define __NR_epoll_pwait	309
+#define __NR_utimensat		310
+#define __NR_signalfd		311
+#define __NR_timerfd_create	312
+#define __NR_eventfd		313
+#define __NR_fallocate		314
+#define __NR_timerfd_settime	315
+#define __NR_timerfd_gettime	316
+
+#define NR_SYSCALLS		317
+
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_COMPAT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
+#define __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
+
+/*
+ * "Conditional" syscalls
+ *
+ * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
+ * but it doesn't work on all toolchains, so we just do it by hand
+ */
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
+
+#endif /* __KERNEL__ */
+#endif /* _SPARC64_UNISTD_H */
diff --git a/include/asm-sparc64/asi.h b/include/asm-sparc64/asi.h
index bc57c40..9b7110c 100644
--- a/include/asm-sparc64/asi.h
+++ b/include/asm-sparc64/asi.h
@@ -1,160 +1 @@
-#ifndef _SPARC64_ASI_H
-#define _SPARC64_ASI_H
-
-/* asi.h:  Address Space Identifier values for the V9.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- */
-
-/* V9 Architecture mandary ASIs. */
-#define ASI_N			0x04 /* Nucleus				*/
-#define ASI_NL			0x0c /* Nucleus, little endian		*/
-#define ASI_AIUP		0x10 /* Primary, user			*/
-#define ASI_AIUS		0x11 /* Secondary, user			*/
-#define ASI_AIUPL		0x18 /* Primary, user, little endian	*/
-#define ASI_AIUSL		0x19 /* Secondary, user, little endian	*/
-#define ASI_P			0x80 /* Primary, implicit		*/
-#define ASI_S			0x81 /* Secondary, implicit		*/
-#define ASI_PNF			0x82 /* Primary, no fault		*/
-#define ASI_SNF			0x83 /* Secondary, no fault		*/
-#define ASI_PL			0x88 /* Primary, implicit, l-endian	*/
-#define ASI_SL			0x89 /* Secondary, implicit, l-endian	*/
-#define ASI_PNFL		0x8a /* Primary, no fault, l-endian	*/
-#define ASI_SNFL		0x8b /* Secondary, no fault, l-endian	*/
-
-/* SpitFire and later extended ASIs.  The "(III)" marker designates
- * UltraSparc-III and later specific ASIs.  The "(CMT)" marker designates
- * Chip Multi Threading specific ASIs.  "(NG)" designates Niagara specific
- * ASIs, "(4V)" designates SUN4V specific ASIs.
- */
-#define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
-#define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
-#define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
-#define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
-#define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cachable, little endian*/
-#define ASI_PHYS_BYPASS_EC_E_L	0x1d /* PADDR, E-bit, little endian	*/
-#define ASI_BLK_AIUP_L_4V	0x1e /* (4V) Prim, user, block, l-endian*/
-#define ASI_BLK_AIUS_L_4V	0x1f /* (4V) Sec, user, block, l-endian	*/
-#define ASI_SCRATCHPAD		0x20 /* (4V) Scratch Pad Registers	*/
-#define ASI_MMU			0x21 /* (4V) MMU Context Registers	*/
-#define ASI_BLK_INIT_QUAD_LDD_AIUS 0x23 /* (NG) init-store, twin load,
-					 * secondary, user
-					 */
-#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cachable, qword load		*/
-#define ASI_QUEUE		0x25 /* (4V) Interrupt Queue Registers	*/
-#define ASI_QUAD_LDD_PHYS_4V	0x26 /* (4V) Physical, qword load	*/
-#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cachable, qword load, l-endian 	*/
-#define ASI_QUAD_LDD_PHYS_L_4V	0x2e /* (4V) Phys, qword load, l-endian	*/
-#define ASI_PCACHE_DATA_STATUS	0x30 /* (III) PCache data stat RAM diag	*/
-#define ASI_PCACHE_DATA		0x31 /* (III) PCache data RAM diag	*/
-#define ASI_PCACHE_TAG		0x32 /* (III) PCache tag RAM diag	*/
-#define ASI_PCACHE_SNOOP_TAG	0x33 /* (III) PCache snoop tag RAM diag	*/
-#define ASI_QUAD_LDD_PHYS	0x34 /* (III+) PADDR, qword load	*/
-#define ASI_WCACHE_VALID_BITS	0x38 /* (III) WCache Valid Bits diag	*/
-#define ASI_WCACHE_DATA		0x39 /* (III) WCache data RAM diag	*/
-#define ASI_WCACHE_TAG		0x3a /* (III) WCache tag RAM diag	*/
-#define ASI_WCACHE_SNOOP_TAG	0x3b /* (III) WCache snoop tag RAM diag	*/
-#define ASI_QUAD_LDD_PHYS_L	0x3c /* (III+) PADDR, qw-load, l-endian	*/
-#define ASI_SRAM_FAST_INIT	0x40 /* (III+) Fast SRAM init		*/
-#define ASI_CORE_AVAILABLE	0x41 /* (CMT) LP Available		*/
-#define ASI_CORE_ENABLE_STAT	0x41 /* (CMT) LP Enable Status		*/
-#define ASI_CORE_ENABLE		0x41 /* (CMT) LP Enable RW		*/
-#define ASI_XIR_STEERING	0x41 /* (CMT) XIR Steering RW		*/
-#define ASI_CORE_RUNNING_RW	0x41 /* (CMT) LP Running RW		*/
-#define ASI_CORE_RUNNING_W1S	0x41 /* (CMT) LP Running Write-One Set	*/
-#define ASI_CORE_RUNNING_W1C	0x41 /* (CMT) LP Running Write-One Clr	*/
-#define ASI_CORE_RUNNING_STAT	0x41 /* (CMT) LP Running Status		*/
-#define ASI_CMT_ERROR_STEERING	0x41 /* (CMT) Error Steering RW		*/
-#define ASI_DCACHE_INVALIDATE	0x42 /* (III) DCache Invalidate diag	*/
-#define ASI_DCACHE_UTAG		0x43 /* (III) DCache uTag diag		*/
-#define ASI_DCACHE_SNOOP_TAG	0x44 /* (III) DCache snoop tag RAM diag	*/
-#define ASI_LSU_CONTROL		0x45 /* Load-store control unit		*/
-#define ASI_DCU_CONTROL_REG	0x45 /* (III) DCache Unit Control reg	*/
-#define ASI_DCACHE_DATA		0x46 /* DCache data-ram diag access	*/
-#define ASI_DCACHE_TAG		0x47 /* Dcache tag/valid ram diag access*/
-#define ASI_INTR_DISPATCH_STAT	0x48 /* IRQ vector dispatch status	*/
-#define ASI_INTR_RECEIVE	0x49 /* IRQ vector receive status	*/
-#define ASI_UPA_CONFIG		0x4a /* UPA config space		*/
-#define ASI_JBUS_CONFIG		0x4a /* (IIIi) JBUS Config Register	*/
-#define ASI_SAFARI_CONFIG	0x4a /* (III) Safari Config Register	*/
-#define ASI_SAFARI_ADDRESS	0x4a /* (III) Safari Address Register	*/
-#define ASI_ESTATE_ERROR_EN	0x4b /* E-cache error enable space	*/
-#define ASI_AFSR		0x4c /* Async fault status register	*/
-#define ASI_AFAR		0x4d /* Async fault address register	*/
-#define ASI_EC_TAG_DATA		0x4e /* E-cache tag/valid ram diag acc	*/
-#define ASI_IMMU		0x50 /* Insn-MMU main register space	*/
-#define ASI_IMMU_TSB_8KB_PTR	0x51 /* Insn-MMU 8KB TSB pointer reg	*/
-#define ASI_IMMU_TSB_64KB_PTR	0x52 /* Insn-MMU 64KB TSB pointer reg	*/
-#define ASI_ITLB_DATA_IN	0x54 /* Insn-MMU TLB data in reg	*/
-#define ASI_ITLB_DATA_ACCESS	0x55 /* Insn-MMU TLB data access reg	*/
-#define ASI_ITLB_TAG_READ	0x56 /* Insn-MMU TLB tag read reg	*/
-#define ASI_IMMU_DEMAP		0x57 /* Insn-MMU TLB demap		*/
-#define ASI_DMMU		0x58 /* Data-MMU main register space	*/
-#define ASI_DMMU_TSB_8KB_PTR	0x59 /* Data-MMU 8KB TSB pointer reg	*/
-#define ASI_DMMU_TSB_64KB_PTR	0x5a /* Data-MMU 16KB TSB pointer reg	*/
-#define ASI_DMMU_TSB_DIRECT_PTR	0x5b /* Data-MMU TSB direct pointer reg	*/
-#define ASI_DTLB_DATA_IN	0x5c /* Data-MMU TLB data in reg	*/
-#define ASI_DTLB_DATA_ACCESS	0x5d /* Data-MMU TLB data access reg	*/
-#define ASI_DTLB_TAG_READ	0x5e /* Data-MMU TLB tag read reg	*/
-#define ASI_DMMU_DEMAP		0x5f /* Data-MMU TLB demap		*/
-#define ASI_IIU_INST_TRAP	0x60 /* (III) Instruction Breakpoint	*/
-#define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
-#define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
-#define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
-#define ASI_IC_INSTR		0x66 /* Insn cache instrucion ram diag	*/
-#define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
-#define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
-#define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
-#define ASI_IC_NEXT_FIELD	0x6f /* Insn cache next-field ram diag	*/
-#define ASI_BRPRED_ARRAY	0x6f /* (III) Branch Prediction RAM diag*/
-#define ASI_BLK_AIUP		0x70 /* Primary, user, block load/store	*/
-#define ASI_BLK_AIUS		0x71 /* Secondary, user, block ld/st	*/
-#define ASI_MCU_CTRL_REG	0x72 /* (III) Memory controller regs	*/
-#define ASI_EC_DATA		0x74 /* (III) E-cache data staging reg	*/
-#define ASI_EC_CTRL		0x75 /* (III) E-cache control reg	*/
-#define ASI_EC_W		0x76 /* E-cache diag write access	*/
-#define ASI_UDB_ERROR_W		0x77 /* External UDB error regs W	*/
-#define ASI_UDB_CONTROL_W	0x77 /* External UDB control regs W	*/
-#define ASI_INTR_W		0x77 /* IRQ vector dispatch write	*/
-#define ASI_INTR_DATAN_W	0x77 /* (III) Out irq vector data reg N	*/
-#define ASI_INTR_DISPATCH_W	0x77 /* (III) Interrupt vector dispatch	*/
-#define ASI_BLK_AIUPL		0x78 /* Primary, user, little, blk ld/st*/
-#define ASI_BLK_AIUSL		0x79 /* Secondary, user, little, blk ld/st*/
-#define ASI_EC_R		0x7e /* E-cache diag read access	*/
-#define ASI_UDBH_ERROR_R	0x7f /* External UDB error regs rd hi	*/
-#define ASI_UDBL_ERROR_R	0x7f /* External UDB error regs rd low	*/
-#define ASI_UDBH_CONTROL_R	0x7f /* External UDB control regs rd hi	*/
-#define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
-#define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
-#define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
-#define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
-#define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
-#define ASI_PST16_P		0xc2 /* Primary, 4 16-bit, partial	*/
-#define ASI_PST16_S		0xc3 /* Secondary, 4 16-bit, partial	*/
-#define ASI_PST32_P		0xc4 /* Primary, 2 32-bit, partial	*/
-#define ASI_PST32_S		0xc5 /* Secondary, 2 32-bit, partial	*/
-#define ASI_PST8_PL		0xc8 /* Primary, 8 8-bit, partial, L	*/
-#define ASI_PST8_SL		0xc9 /* Secondary, 8 8-bit, partial, L	*/
-#define ASI_PST16_PL		0xca /* Primary, 4 16-bit, partial, L	*/
-#define ASI_PST16_SL		0xcb /* Secondary, 4 16-bit, partial, L	*/
-#define ASI_PST32_PL		0xcc /* Primary, 2 32-bit, partial, L	*/
-#define ASI_PST32_SL		0xcd /* Secondary, 2 32-bit, partial, L	*/
-#define ASI_FL8_P		0xd0 /* Primary, 1 8-bit, fpu ld/st	*/
-#define ASI_FL8_S		0xd1 /* Secondary, 1 8-bit, fpu ld/st	*/
-#define ASI_FL16_P		0xd2 /* Primary, 1 16-bit, fpu ld/st	*/
-#define ASI_FL16_S		0xd3 /* Secondary, 1 16-bit, fpu ld/st	*/
-#define ASI_FL8_PL		0xd8 /* Primary, 1 8-bit, fpu ld/st, L	*/
-#define ASI_FL8_SL		0xd9 /* Secondary, 1 8-bit, fpu ld/st, L*/
-#define ASI_FL16_PL		0xda /* Primary, 1 16-bit, fpu ld/st, L	*/
-#define ASI_FL16_SL		0xdb /* Secondary, 1 16-bit, fpu ld/st,L*/
-#define ASI_BLK_COMMIT_P	0xe0 /* Primary, blk store commit	*/
-#define ASI_BLK_COMMIT_S	0xe1 /* Secondary, blk store commit	*/
-#define ASI_BLK_INIT_QUAD_LDD_P	0xe2 /* (NG) init-store, twin load,
-				      * primary, implicit
-				      */
-#define ASI_BLK_P		0xf0 /* Primary, blk ld/st		*/
-#define ASI_BLK_S		0xf1 /* Secondary, blk ld/st		*/
-#define ASI_BLK_PL		0xf8 /* Primary, blk ld/st, little	*/
-#define ASI_BLK_SL		0xf9 /* Secondary, blk ld/st, little	*/
-
-#endif /* _SPARC64_ASI_H */
+#include <asm-sparc/asi.h>
diff --git a/include/asm-sparc64/ipcbuf.h b/include/asm-sparc64/ipcbuf.h
index 9c5bf1b..41dfaf1 100644
--- a/include/asm-sparc64/ipcbuf.h
+++ b/include/asm-sparc64/ipcbuf.h
@@ -1,28 +1 @@
-#ifndef _SPARC64_IPCBUF_H
-#define _SPARC64_IPCBUF_H
-
-/* 
- * The ipc64_perm structure for sparc64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 32-bit seq
- * - 2 miscellaneous 64-bit values
- */
-
-struct ipc64_perm
-{
-	__kernel_key_t	key;
-	__kernel_uid_t	uid;
-	__kernel_gid_t	gid;
-	__kernel_uid_t	cuid;
-	__kernel_gid_t	cgid;
-	__kernel_mode_t	mode; 
-	unsigned short	__pad1;
-	unsigned short	seq;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* _SPARC64_IPCBUF_H */
+#include <asm-sparc/ipcbuf.h>
diff --git a/include/asm-sparc64/openprom.h b/include/asm-sparc64/openprom.h
index b69e4a8..acf4b23 100644
--- a/include/asm-sparc64/openprom.h
+++ b/include/asm-sparc64/openprom.h
@@ -1,280 +1 @@
-#ifndef __SPARC64_OPENPROM_H
-#define __SPARC64_OPENPROM_H
-
-/* openprom.h:  Prom structures and defines for access to the OPENBOOT
- *              prom routines and data areas.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef __ASSEMBLY__
-/* V0 prom device operations. */
-struct linux_dev_v0_funcs {
-	int (*v0_devopen)(char *device_str);
-	int (*v0_devclose)(int dev_desc);
-	int (*v0_rdblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
-	int (*v0_wrblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
-	int (*v0_wrnetdev)(int dev_desc, int num_bytes, char *buf);
-	int (*v0_rdnetdev)(int dev_desc, int num_bytes, char *buf);
-	int (*v0_rdchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
-	int (*v0_wrchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
-	int (*v0_seekdev)(int dev_desc, long logical_offst, int from);
-};
-
-/* V2 and later prom device operations. */
-struct linux_dev_v2_funcs {
-	int (*v2_inst2pkg)(int d);	/* Convert ihandle to phandle */
-	char * (*v2_dumb_mem_alloc)(char *va, unsigned sz);
-	void (*v2_dumb_mem_free)(char *va, unsigned sz);
-
-	/* To map devices into virtual I/O space. */
-	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned paddr, unsigned sz);
-	void (*v2_dumb_munmap)(char *virta, unsigned size);
-
-	int (*v2_dev_open)(char *devpath);
-	void (*v2_dev_close)(int d);
-	int (*v2_dev_read)(int d, char *buf, int nbytes);
-	int (*v2_dev_write)(int d, char *buf, int nbytes);
-	int (*v2_dev_seek)(int d, int hi, int lo);
-
-	/* Never issued (multistage load support) */
-	void (*v2_wheee2)(void);
-	void (*v2_wheee3)(void);
-};
-
-struct linux_mlist_v0 {
-	struct linux_mlist_v0 *theres_more;
-	unsigned start_adr;
-	unsigned num_bytes;
-};
-
-struct linux_mem_v0 {
-	struct linux_mlist_v0 **v0_totphys;
-	struct linux_mlist_v0 **v0_prommap;
-	struct linux_mlist_v0 **v0_available; /* What we can use */
-};
-
-/* Arguments sent to the kernel from the boot prompt. */
-struct linux_arguments_v0 {
-	char *argv[8];
-	char args[100];
-	char boot_dev[2];
-	int boot_dev_ctrl;
-	int boot_dev_unit;
-	int dev_partition;
-	char *kernel_file_name;
-	void *aieee1;           /* XXX */
-};
-
-/* V2 and up boot things. */
-struct linux_bootargs_v2 {
-	char **bootpath;
-	char **bootargs;
-	int *fd_stdin;
-	int *fd_stdout;
-};
-
-/* The top level PROM vector. */
-struct linux_romvec {
-	/* Version numbers. */
-	unsigned int pv_magic_cookie;
-	unsigned int pv_romvers;
-	unsigned int pv_plugin_revision;
-	unsigned int pv_printrev;
-
-	/* Version 0 memory descriptors. */
-	struct linux_mem_v0 pv_v0mem;
-
-	/* Node operations. */
-	struct linux_nodeops *pv_nodeops;
-
-	char **pv_bootstr;
-	struct linux_dev_v0_funcs pv_v0devops;
-
-	char *pv_stdin;
-	char *pv_stdout;
-#define	PROMDEV_KBD	0		/* input from keyboard */
-#define	PROMDEV_SCREEN	0		/* output to screen */
-#define	PROMDEV_TTYA	1		/* in/out to ttya */
-#define	PROMDEV_TTYB	2		/* in/out to ttyb */
-
-	/* Blocking getchar/putchar.  NOT REENTRANT! (grr) */
-	int (*pv_getchar)(void);
-	void (*pv_putchar)(int ch);
-
-	/* Non-blocking variants. */
-	int (*pv_nbgetchar)(void);
-	int (*pv_nbputchar)(int ch);
-
-	void (*pv_putstr)(char *str, int len);
-
-	/* Miscellany. */
-	void (*pv_reboot)(char *bootstr);
-	void (*pv_printf)(__const__ char *fmt, ...);
-	void (*pv_abort)(void);
-	__volatile__ int *pv_ticks;
-	void (*pv_halt)(void);
-	void (**pv_synchook)(void);
-
-	/* Evaluate a forth string, not different proto for V0 and V2->up. */
-	union {
-		void (*v0_eval)(int len, char *str);
-		void (*v2_eval)(char *str);
-	} pv_fortheval;
-
-	struct linux_arguments_v0 **pv_v0bootargs;
-
-	/* Get ether address. */
-	unsigned int (*pv_enaddr)(int d, char *enaddr);
-
-	struct linux_bootargs_v2 pv_v2bootargs;
-	struct linux_dev_v2_funcs pv_v2devops;
-
-	int filler[15];
-
-	/* This one is sun4c/sun4 only. */
-	void (*pv_setctxt)(int ctxt, char *va, int pmeg);
-
-	/* Prom version 3 Multiprocessor routines. This stuff is crazy.
-	 * No joke. Calling these when there is only one cpu probably
-	 * crashes the machine, have to test this. :-)
-	 */
-
-	/* v3_cpustart() will start the cpu 'whichcpu' in mmu-context
-	 * 'thiscontext' executing at address 'prog_counter'
-	 */
-	int (*v3_cpustart)(unsigned int whichcpu, int ctxtbl_ptr,
-			   int thiscontext, char *prog_counter);
-
-	/* v3_cpustop() will cause cpu 'whichcpu' to stop executing
-	 * until a resume cpu call is made.
-	 */
-	int (*v3_cpustop)(unsigned int whichcpu);
-
-	/* v3_cpuidle() will idle cpu 'whichcpu' until a stop or
-	 * resume cpu call is made.
-	 */
-	int (*v3_cpuidle)(unsigned int whichcpu);
-
-	/* v3_cpuresume() will resume processor 'whichcpu' executing
-	 * starting with whatever 'pc' and 'npc' were left at the
-	 * last 'idle' or 'stop' call.
-	 */
-	int (*v3_cpuresume)(unsigned int whichcpu);
-};
-
-/* Routines for traversing the prom device tree. */
-struct linux_nodeops {
-	int (*no_nextnode)(int node);
-	int (*no_child)(int node);
-	int (*no_proplen)(int node, char *name);
-	int (*no_getprop)(int node, char *name, char *val);
-	int (*no_setprop)(int node, char *name, char *val, int len);
-	char * (*no_nextprop)(int node, char *name);
-};
-
-/* More fun PROM structures for device probing. */
-#define PROMREG_MAX     24
-#define PROMVADDR_MAX   16
-#define PROMINTR_MAX    32
-
-struct linux_prom_registers {
-	unsigned which_io;	/* hi part of physical address			*/
-	unsigned phys_addr;	/* The physical address of this register	*/
-	int reg_size;		/* How many bytes does this register take up?	*/
-};
-
-struct linux_prom64_registers {
-	unsigned long phys_addr;
-	unsigned long reg_size;
-};
-
-struct linux_prom_irqs {
-	int pri;    /* IRQ priority */
-	int vector; /* This is foobar, what does it do? */
-};
-
-/* Element of the "ranges" vector */
-struct linux_prom_ranges {
-	unsigned int ot_child_space;
-	unsigned int ot_child_base;		/* Bus feels this */
-	unsigned int ot_parent_space;
-	unsigned int ot_parent_base;		/* CPU looks from here */
-	unsigned int or_size;
-};
-
-struct linux_prom64_ranges {
-	unsigned long ot_child_base;		/* Bus feels this */
-	unsigned long ot_parent_base;		/* CPU looks from here */
-	unsigned long or_size;
-};
-
-/* Ranges and reg properties are a bit different for PCI. */
-struct linux_prom_pci_registers {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_ranges {
-	unsigned int child_phys_hi;	/* Only certain bits are encoded here. */
-	unsigned int child_phys_mid;
-	unsigned int child_phys_lo;
-
-	unsigned int parent_phys_hi;
-	unsigned int parent_phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_intmap {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-
-	unsigned int interrupt;
-
-	int          cnode;
-	unsigned int cinterrupt;
-};
-
-struct linux_prom_pci_intmask {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-	unsigned int interrupt;
-};
-
-struct linux_prom_ebus_ranges {
-	unsigned int child_phys_hi;
-	unsigned int child_phys_lo;
-
-	unsigned int parent_phys_hi;
-	unsigned int parent_phys_mid;
-	unsigned int parent_phys_lo;
-
-	unsigned int size;
-};
-
-struct linux_prom_ebus_intmap {
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int interrupt;
-
-	int          cnode;
-	unsigned int cinterrupt;
-};
-
-struct linux_prom_ebus_intmask {
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-	unsigned int interrupt;
-};
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(__SPARC64_OPENPROM_H) */
+#include <asm-sparc/openprom.h>
diff --git a/include/asm-sparc64/posix_types.h b/include/asm-sparc64/posix_types.h
index 4eaaa01..8cee992 100644
--- a/include/asm-sparc64/posix_types.h
+++ b/include/asm-sparc64/posix_types.h
@@ -1,122 +1 @@
-#ifndef __ARCH_SPARC64_POSIX_TYPES_H
-#define __ARCH_SPARC64_POSIX_TYPES_H
-
-/*
- * This file is generally used by user-level software, so you need to
- * be a little careful about namespace pollution etc.  Also, we cannot
- * assume GCC is being used.
- */
-
-typedef unsigned long          __kernel_size_t;
-typedef long                   __kernel_ssize_t;
-typedef long                   __kernel_ptrdiff_t;
-typedef long                   __kernel_time_t;
-typedef long                   __kernel_clock_t;
-typedef int                    __kernel_pid_t;
-typedef int                    __kernel_ipc_pid_t;
-typedef unsigned int           __kernel_uid_t;
-typedef unsigned int           __kernel_gid_t;
-typedef unsigned long          __kernel_ino_t;
-typedef unsigned int           __kernel_mode_t;
-typedef unsigned short         __kernel_umode_t;
-typedef unsigned int           __kernel_nlink_t;
-typedef int                    __kernel_daddr_t;
-typedef long                   __kernel_off_t;
-typedef char *                 __kernel_caddr_t;
-typedef unsigned short	       __kernel_uid16_t;
-typedef unsigned short	       __kernel_gid16_t;
-typedef int                    __kernel_clockid_t;
-typedef int                    __kernel_timer_t;
-
-typedef unsigned short 	       __kernel_old_uid_t;
-typedef unsigned short         __kernel_old_gid_t;
-typedef __kernel_uid_t	       __kernel_uid32_t;
-typedef __kernel_gid_t	       __kernel_gid32_t;
-
-typedef unsigned int	       __kernel_old_dev_t;
-
-/* Note this piece of asymmetry from the v9 ABI.  */
-typedef int		       __kernel_suseconds_t;
-
-#ifdef __GNUC__
-typedef long long              __kernel_loff_t;
-#endif
-
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-
-#if defined(__KERNEL__)
-
-#undef __FD_SET
-static inline void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static inline void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static inline int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
-{ 
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant cases (8 or 32 longs,
- * for 256 and 1024-bit fd_sets respectively)
- */
-#undef __FD_ZERO
-static inline void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 32:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
-			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
-			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
-			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
-			  return;
-			case 16:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  return;
-			case 8:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  return;
-			case 4:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) */
-
-#endif /* !(__ARCH_SPARC64_POSIX_TYPES_H) */
+#include <asm-sparc/posix_types.h>
diff --git a/include/asm-sparc64/ptrace.h b/include/asm-sparc64/ptrace.h
index b163da7..1a55b9f 100644
--- a/include/asm-sparc64/ptrace.h
+++ b/include/asm-sparc64/ptrace.h
@@ -1,346 +1 @@
-#ifndef _SPARC64_PTRACE_H
-#define _SPARC64_PTRACE_H
-
-#include <asm/pstate.h>
-
-/* This struct defines the way the registers are stored on the 
- * stack during a system call and basically all traps.
- */
-
-/* This magic value must have the low 9 bits clear,
- * as that is where we encode the %tt value, see below.
- */
-#define PT_REGS_MAGIC 0x57ac6c00
-
-#ifndef __ASSEMBLY__
-
-#include <linux/types.h>
-
-struct pt_regs {
-	unsigned long u_regs[16]; /* globals and ins */
-	unsigned long tstate;
-	unsigned long tpc;
-	unsigned long tnpc;
-	unsigned int y;
-
-	/* We encode a magic number, PT_REGS_MAGIC, along
-	 * with the %tt (trap type) register value at trap
-	 * entry time.  The magic number allows us to identify
-	 * accurately a trap stack frame in the stack
-	 * unwinder, and the %tt value allows us to test
-	 * things like "in a system call" etc. for an arbitray
-	 * process.
-	 *
-	 * The PT_REGS_MAGIC is choosen such that it can be
-	 * loaded completely using just a sethi instruction.
-	 */
-	unsigned int magic;
-};
-
-static inline int pt_regs_trap_type(struct pt_regs *regs)
-{
-	return regs->magic & 0x1ff;
-}
-
-static inline bool pt_regs_is_syscall(struct pt_regs *regs)
-{
-	return (regs->tstate & TSTATE_SYSCALL);
-}
-
-static inline bool pt_regs_clear_syscall(struct pt_regs *regs)
-{
-	return (regs->tstate &= ~TSTATE_SYSCALL);
-}
-
-struct pt_regs32 {
-	unsigned int psr;
-	unsigned int pc;
-	unsigned int npc;
-	unsigned int y;
-	unsigned int u_regs[16]; /* globals and ins */
-};
-
-#define UREG_G0        0
-#define UREG_G1        1
-#define UREG_G2        2
-#define UREG_G3        3
-#define UREG_G4        4
-#define UREG_G5        5
-#define UREG_G6        6
-#define UREG_G7        7
-#define UREG_I0        8
-#define UREG_I1        9
-#define UREG_I2        10
-#define UREG_I3        11
-#define UREG_I4        12
-#define UREG_I5        13
-#define UREG_I6        14
-#define UREG_I7        15
-#define UREG_FP        UREG_I6
-#define UREG_RETPC     UREG_I7
-
-/* A V9 register window */
-struct reg_window {
-	unsigned long locals[8];
-	unsigned long ins[8];
-};
-
-/* A 32-bit register window. */
-struct reg_window32 {
-	unsigned int locals[8];
-	unsigned int ins[8];
-};
-
-/* A V9 Sparc stack frame */
-struct sparc_stackf {
-	unsigned long locals[8];
-        unsigned long ins[6];
-	struct sparc_stackf *fp;
-	unsigned long callers_pc;
-	char *structptr;
-	unsigned long xargs[6];
-	unsigned long xxargs[1];
-};	
-
-/* A 32-bit Sparc stack frame */
-struct sparc_stackf32 {
-	unsigned int locals[8];
-        unsigned int ins[6];
-	unsigned int fp;
-	unsigned int callers_pc;
-	unsigned int structptr;
-	unsigned int xargs[6];
-	unsigned int xxargs[1];
-};	
-
-struct sparc_trapf {
-	unsigned long locals[8];
-	unsigned long ins[8];
-	unsigned long _unused;
-	struct pt_regs *regs;
-};
-
-#define TRACEREG_SZ	sizeof(struct pt_regs)
-#define STACKFRAME_SZ	sizeof(struct sparc_stackf)
-
-#define TRACEREG32_SZ	sizeof(struct pt_regs32)
-#define STACKFRAME32_SZ	sizeof(struct sparc_stackf32)
-
-#ifdef __KERNEL__
-
-struct global_reg_snapshot {
-	unsigned long		tstate;
-	unsigned long		tpc;
-	unsigned long		tnpc;
-	unsigned long		o7;
-	unsigned long		i7;
-	struct thread_info	*thread;
-	unsigned long		pad1;
-	unsigned long		pad2;
-};
-
-#define __ARCH_WANT_COMPAT_SYS_PTRACE
-
-#define force_successful_syscall_return()	    \
-do {	current_thread_info()->syscall_noerror = 1; \
-} while (0)
-#define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
-#define instruction_pointer(regs) ((regs)->tpc)
-#define regs_return_value(regs) ((regs)->u_regs[UREG_I0])
-#ifdef CONFIG_SMP
-extern unsigned long profile_pc(struct pt_regs *);
-#else
-#define profile_pc(regs) instruction_pointer(regs)
-#endif
-extern void show_regs(struct pt_regs *);
-extern void __show_regs(struct pt_regs *);
-#endif
-
-#else /* __ASSEMBLY__ */
-/* For assembly code. */
-#define TRACEREG_SZ		0xa0
-#define STACKFRAME_SZ		0xc0
-
-#define TRACEREG32_SZ		0x50
-#define STACKFRAME32_SZ		0x60
-#endif
-
-#ifdef __KERNEL__
-#define STACK_BIAS		2047
-#endif
-
-/* These are for pt_regs. */
-#define PT_V9_G0     0x00
-#define PT_V9_G1     0x08
-#define PT_V9_G2     0x10
-#define PT_V9_G3     0x18
-#define PT_V9_G4     0x20
-#define PT_V9_G5     0x28
-#define PT_V9_G6     0x30
-#define PT_V9_G7     0x38
-#define PT_V9_I0     0x40
-#define PT_V9_I1     0x48
-#define PT_V9_I2     0x50
-#define PT_V9_I3     0x58
-#define PT_V9_I4     0x60
-#define PT_V9_I5     0x68
-#define PT_V9_I6     0x70
-#define PT_V9_FP     PT_V9_I6
-#define PT_V9_I7     0x78
-#define PT_V9_TSTATE 0x80
-#define PT_V9_TPC    0x88
-#define PT_V9_TNPC   0x90
-#define PT_V9_Y      0x98
-#define PT_V9_MAGIC  0x9c
-#define PT_TSTATE	PT_V9_TSTATE
-#define PT_TPC		PT_V9_TPC
-#define PT_TNPC		PT_V9_TNPC
-
-/* These for pt_regs32. */
-#define PT_PSR    0x0
-#define PT_PC     0x4
-#define PT_NPC    0x8
-#define PT_Y      0xc
-#define PT_G0     0x10
-#define PT_WIM    PT_G0
-#define PT_G1     0x14
-#define PT_G2     0x18
-#define PT_G3     0x1c
-#define PT_G4     0x20
-#define PT_G5     0x24
-#define PT_G6     0x28
-#define PT_G7     0x2c
-#define PT_I0     0x30
-#define PT_I1     0x34
-#define PT_I2     0x38
-#define PT_I3     0x3c
-#define PT_I4     0x40
-#define PT_I5     0x44
-#define PT_I6     0x48
-#define PT_FP     PT_I6
-#define PT_I7     0x4c
-
-/* Reg_window offsets */
-#define RW_V9_L0     0x00
-#define RW_V9_L1     0x08
-#define RW_V9_L2     0x10
-#define RW_V9_L3     0x18
-#define RW_V9_L4     0x20
-#define RW_V9_L5     0x28
-#define RW_V9_L6     0x30
-#define RW_V9_L7     0x38
-#define RW_V9_I0     0x40
-#define RW_V9_I1     0x48
-#define RW_V9_I2     0x50
-#define RW_V9_I3     0x58
-#define RW_V9_I4     0x60
-#define RW_V9_I5     0x68
-#define RW_V9_I6     0x70
-#define RW_V9_I7     0x78
-
-#define RW_L0     0x00
-#define RW_L1     0x04
-#define RW_L2     0x08
-#define RW_L3     0x0c
-#define RW_L4     0x10
-#define RW_L5     0x14
-#define RW_L6     0x18
-#define RW_L7     0x1c
-#define RW_I0     0x20
-#define RW_I1     0x24
-#define RW_I2     0x28
-#define RW_I3     0x2c
-#define RW_I4     0x30
-#define RW_I5     0x34
-#define RW_I6     0x38
-#define RW_I7     0x3c
-
-/* Stack_frame offsets */
-#define SF_V9_L0     0x00
-#define SF_V9_L1     0x08
-#define SF_V9_L2     0x10
-#define SF_V9_L3     0x18
-#define SF_V9_L4     0x20
-#define SF_V9_L5     0x28
-#define SF_V9_L6     0x30
-#define SF_V9_L7     0x38
-#define SF_V9_I0     0x40
-#define SF_V9_I1     0x48
-#define SF_V9_I2     0x50
-#define SF_V9_I3     0x58
-#define SF_V9_I4     0x60
-#define SF_V9_I5     0x68
-#define SF_V9_FP     0x70
-#define SF_V9_PC     0x78
-#define SF_V9_RETP   0x80
-#define SF_V9_XARG0  0x88
-#define SF_V9_XARG1  0x90
-#define SF_V9_XARG2  0x98
-#define SF_V9_XARG3  0xa0
-#define SF_V9_XARG4  0xa8
-#define SF_V9_XARG5  0xb0
-#define SF_V9_XXARG  0xb8
-
-#define SF_L0     0x00
-#define SF_L1     0x04
-#define SF_L2     0x08
-#define SF_L3     0x0c
-#define SF_L4     0x10
-#define SF_L5     0x14
-#define SF_L6     0x18
-#define SF_L7     0x1c
-#define SF_I0     0x20
-#define SF_I1     0x24
-#define SF_I2     0x28
-#define SF_I3     0x2c
-#define SF_I4     0x30
-#define SF_I5     0x34
-#define SF_FP     0x38
-#define SF_PC     0x3c
-#define SF_RETP   0x40
-#define SF_XARG0  0x44
-#define SF_XARG1  0x48
-#define SF_XARG2  0x4c
-#define SF_XARG3  0x50
-#define SF_XARG4  0x54
-#define SF_XARG5  0x58
-#define SF_XXARG  0x5c
-
-#ifdef __KERNEL__
-
-/* global_reg_snapshot offsets */
-#define GR_SNAP_TSTATE	0x00
-#define GR_SNAP_TPC	0x08
-#define GR_SNAP_TNPC	0x10
-#define GR_SNAP_O7	0x18
-#define GR_SNAP_I7	0x20
-#define GR_SNAP_THREAD	0x28
-#define GR_SNAP_PAD1	0x30
-#define GR_SNAP_PAD2	0x38
-
-#endif  /*  __KERNEL__  */
-
-/* Stuff for the ptrace system call */
-#define PTRACE_SPARC_DETACH       11
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_READDATA           16
-#define PTRACE_WRITEDATA          17
-#define PTRACE_READTEXT           18
-#define PTRACE_WRITETEXT          19
-#define PTRACE_GETFPAREGS         20
-#define PTRACE_SETFPAREGS         21
-
-/* There are for debugging 64-bit processes, either from a 32 or 64 bit
- * parent.  Thus their complements are for debugging 32-bit processes only.
- */
-
-#define PTRACE_GETREGS64	  22
-#define PTRACE_SETREGS64	  23
-/* PTRACE_SYSCALL is 24 */
-#define PTRACE_GETFPREGS64	  25
-#define PTRACE_SETFPREGS64	  26
-
-#endif /* !(_SPARC64_PTRACE_H) */
+#include <asm-sparc/ptrace.h>
diff --git a/include/asm-sparc64/reg.h b/include/asm-sparc64/reg.h
index 77aa480..495bab2 100644
--- a/include/asm-sparc64/reg.h
+++ b/include/asm-sparc64/reg.h
@@ -1,56 +1 @@
-/*
- * linux/asm-sparc64/reg.h
- * Layout of the registers as expected by gdb on the Sparc
- * we should replace the user.h definitions with those in
- * this file, we don't even use the other 
- * -miguel
- *
- * The names of the structures, constants and aliases in this file
- * have the same names as the sunos ones, some programs rely on these
- * names (gdb for example).
- *
- */
-
-#ifndef __SPARC64_REG_H
-#define __SPARC64_REG_H
-
-struct regs {
-        unsigned long r_g1;
-        unsigned long r_g2;
-        unsigned long r_g3;
-        unsigned long r_g4;
-        unsigned long r_g5;
-        unsigned long r_g6;
-        unsigned long r_g7;
-        unsigned long r_o0;
-        unsigned long r_o1;
-        unsigned long r_o2;
-        unsigned long r_o3;
-        unsigned long r_o4;
-        unsigned long r_o5;
-        unsigned long r_o6;
-        unsigned long r_o7;
-        unsigned long __pad;
-        unsigned long r_tstate;
-        unsigned long r_tpc;
-        unsigned long r_tnpc;
-        unsigned int  r_y;
-        unsigned int  r_fprs;
-};
-
-#define FPU_REGS_TYPE unsigned int
-#define FPU_FSR_TYPE unsigned long
-
-struct fp_status {
-        unsigned long fpu_fr[32];
-        unsigned long Fpu_fsr;
-};
-
-struct fpu {
-	struct fp_status f_fpstatus;
-};
-
-#define fpu_regs  f_fpstatus.fpu_fr
-#define fpu_fsr   f_fpstatus.Fpu_fsr
-
-#endif /* __SPARC64_REG_H */
+#include <asm-sparc/reg.h>
diff --git a/include/asm-sparc64/sigcontext.h b/include/asm-sparc64/sigcontext.h
index 1c868d6..5b16dcc 100644
--- a/include/asm-sparc64/sigcontext.h
+++ b/include/asm-sparc64/sigcontext.h
@@ -1,87 +1 @@
-#ifndef __SPARC64_SIGCONTEXT_H
-#define __SPARC64_SIGCONTEXT_H
-
-#ifdef __KERNEL__
-#include <asm/ptrace.h>
-#endif
-
-#ifndef __ASSEMBLY__
-
-#ifdef __KERNEL__
-
-#define __SUNOS_MAXWIN   31
-
-/* This is what SunOS does, so shall I unless we use new 32bit signals or rt signals. */
-struct sigcontext32 {
-	int sigc_onstack;      /* state to restore */
-	int sigc_mask;         /* sigmask to restore */
-	int sigc_sp;           /* stack pointer */
-	int sigc_pc;           /* program counter */
-	int sigc_npc;          /* next program counter */
-	int sigc_psr;          /* for condition codes etc */
-	int sigc_g1;           /* User uses these two registers */
-	int sigc_o0;           /* within the trampoline code. */
-
-	/* Now comes information regarding the users window set
-	 * at the time of the signal.
-	 */
-	int sigc_oswins;       /* outstanding windows */
-
-	/* stack ptrs for each regwin buf */
-	unsigned sigc_spbuf[__SUNOS_MAXWIN];
-
-	/* Windows to restore after signal */
-	struct reg_window32 sigc_wbuf[__SUNOS_MAXWIN];
-};
-
-#endif
-
-#ifdef __KERNEL__
-
-/* This is what we use for 32bit new non-rt signals. */
-
-typedef struct {
-	struct {
-		unsigned int psr;
-		unsigned int pc;
-		unsigned int npc;
-		unsigned int y;
-		unsigned int u_regs[16]; /* globals and ins */
-	}			si_regs;
-	int			si_mask;
-} __siginfo32_t;
-
-#endif
-
-typedef struct {
-	unsigned   int si_float_regs [64];
-	unsigned   long si_fsr;
-	unsigned   long si_gsr;
-	unsigned   long si_fprs;
-} __siginfo_fpu_t;
-
-/* This is what SunOS doesn't, so we have to write this alone
-   and do it properly. */
-struct sigcontext {
-	/* The size of this array has to match SI_MAX_SIZE from siginfo.h */
-	char			sigc_info[128];
-	struct {
-		unsigned long	u_regs[16]; /* globals and ins */
-		unsigned long	tstate;
-		unsigned long	tpc;
-		unsigned long	tnpc;
-		unsigned int	y;
-		unsigned int	fprs;
-	}			sigc_regs;
-	__siginfo_fpu_t *	sigc_fpu_save;
-	struct {
-		void	*	ss_sp;
-		int		ss_flags;
-		unsigned long	ss_size;
-	}			sigc_stack;
-	unsigned long		sigc_mask;
-};
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(__SPARC64_SIGCONTEXT_H) */
+#include <asm-sparc/sigcontext.h>
diff --git a/include/asm-sparc64/siginfo.h b/include/asm-sparc64/siginfo.h
index c96e6c3..8ffd6eb 100644
--- a/include/asm-sparc64/siginfo.h
+++ b/include/asm-sparc64/siginfo.h
@@ -1,32 +1 @@
-#ifndef _SPARC64_SIGINFO_H
-#define _SPARC64_SIGINFO_H
-
-#define SI_PAD_SIZE32	((SI_MAX_SIZE/sizeof(int)) - 3)
-
-#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
-#define __ARCH_SI_TRAPNO
-#define __ARCH_SI_BAND_T int
-
-#include <asm-generic/siginfo.h>
-
-#ifdef __KERNEL__
-
-#include <linux/compat.h>
-
-#ifdef CONFIG_COMPAT
-
-struct compat_siginfo;
-
-#endif /* CONFIG_COMPAT */
-
-#endif /* __KERNEL__ */
-
-#define SI_NOINFO	32767		/* no information in siginfo_t */
-
-/*
- * SIGEMT si_codes
- */
-#define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
-#define NSIGEMT		1
-
-#endif
+#include <asm-sparc/siginfo.h>
diff --git a/include/asm-sparc64/signal.h b/include/asm-sparc64/signal.h
index 2a7c793..79705e5 100644
--- a/include/asm-sparc64/signal.h
+++ b/include/asm-sparc64/signal.h
@@ -1,194 +1 @@
-#ifndef _ASMSPARC64_SIGNAL_H
-#define _ASMSPARC64_SIGNAL_H
-
-#include <asm/sigcontext.h>
-
-#ifdef __KERNEL__
-#ifndef __ASSEMBLY__
-#include <linux/personality.h>
-#include <linux/types.h>
-#endif
-#endif
-
-/* On the Sparc the signal handlers get passed a 'sub-signal' code
- * for certain signal types, which we document here.
- */
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define    SUBSIG_STACK       0
-#define    SUBSIG_ILLINST     2
-#define    SUBSIG_PRIVINST    3
-#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
-
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-
-#define SIGEMT           7
-#define    SUBSIG_TAG    10
-
-#define SIGFPE		 8
-#define    SUBSIG_FPDISABLED     0x400
-#define    SUBSIG_FPERROR        0x404
-#define    SUBSIG_FPINTOVFL      0x001
-#define    SUBSIG_FPSTSIG        0x002
-#define    SUBSIG_IDIVZERO       0x014
-#define    SUBSIG_FPINEXACT      0x0c4
-#define    SUBSIG_FPDIVZERO      0x0c8
-#define    SUBSIG_FPUNFLOW       0x0cc
-#define    SUBSIG_FPOPERROR      0x0d0
-#define    SUBSIG_FPOVFLOW       0x0d4
-
-#define SIGKILL		 9
-#define SIGBUS          10
-#define    SUBSIG_BUSTIMEOUT    1
-#define    SUBSIG_ALIGNMENT     2
-#define    SUBSIG_MISCERROR     5
-
-#define SIGSEGV		11
-#define    SUBSIG_NOMAPPING     3
-#define    SUBSIG_PROTECTION    4
-#define    SUBSIG_SEGERROR      5
-
-#define SIGSYS		12
-
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGURG          16
-
-/* SunOS values which deviate from the Linux/i386 ones */
-#define SIGSTOP		17
-#define SIGTSTP		18
-#define SIGCONT		19
-#define SIGCHLD		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGIO		23
-#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGLOST		29
-#define SIGPWR		SIGLOST
-#define SIGUSR1		30
-#define SIGUSR2		31
-
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
-
-#define __OLD_NSIG	32
-#define __NEW_NSIG      64
-#define _NSIG_BPW     	64
-#define _NSIG_WORDS   	(__NEW_NSIG / _NSIG_BPW)
-
-#define SIGRTMIN       32
-#define SIGRTMAX       __NEW_NSIG
-
-#if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
-#define _NSIG			__NEW_NSIG
-#define __new_sigset_t		sigset_t
-#define __new_sigaction		sigaction
-#define __new_sigaction32	sigaction32
-#define __old_sigset_t		old_sigset_t
-#define __old_sigaction		old_sigaction
-#define __old_sigaction32	old_sigaction32
-#else
-#define _NSIG			__OLD_NSIG
-#define NSIG			_NSIG
-#define __old_sigset_t		sigset_t
-#define __old_sigaction		sigaction
-#define __old_sigaction32	sigaction32
-#endif
-
-#ifndef __ASSEMBLY__
-
-typedef unsigned long __old_sigset_t;            /* at least 32 bits */
-
-typedef struct {
-       unsigned long sig[_NSIG_WORDS];
-} __new_sigset_t;
-
-/* A SunOS sigstack */
-struct sigstack {
-	/* XXX 32-bit pointers pinhead XXX */
-	char *the_stack;
-	int   cur_status;
-};
-
-/* Sigvec flags */
-#define _SV_SSTACK    1u    /* This signal handler should use sig-stack */
-#define _SV_INTR      2u    /* Sig return should not restart system call */
-#define _SV_RESET     4u    /* Set handler to SIG_DFL upon taken signal */
-#define _SV_IGNCHILD  8u    /* Do not send SIGCHLD */
-
-/*
- * sa_flags values: SA_STACK is not currently supported, but will allow the
- * usage of signal stacks by using the (now obsolete) sa_restorer field in
- * the sigaction structure as a stack pointer. This is now possible due to
- * the changes in signal handling. LBT 010493.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- */
-#define SA_NOCLDSTOP	_SV_IGNCHILD
-#define SA_STACK	_SV_SSTACK
-#define SA_ONSTACK	_SV_SSTACK
-#define SA_RESTART	_SV_INTR
-#define SA_ONESHOT	_SV_RESET
-#define SA_NOMASK	0x20u
-#define SA_NOCLDWAIT    0x100u
-#define SA_SIGINFO      0x200u
-
-
-#define SIG_BLOCK          0x01	/* for blocking signals */
-#define SIG_UNBLOCK        0x02	/* for unblocking signals */
-#define SIG_SETMASK        0x04	/* for setting the signal mask */
-
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	4096
-#define SIGSTKSZ	16384
-
-#include <asm-generic/signal.h>
-
-struct __new_sigaction {
-	__sighandler_t		sa_handler;
-	unsigned long		sa_flags;
-	__sigrestore_t 		sa_restorer;  /* not used by Linux/SPARC yet */
-	__new_sigset_t		sa_mask;
-};
-
-struct __old_sigaction {
-	__sighandler_t  	sa_handler;
-	__old_sigset_t  	sa_mask;
-	unsigned long   	sa_flags;
-	void 			(*sa_restorer)(void);     /* not used by Linux/SPARC yet */
-};
-
-typedef struct sigaltstack {
-	void			__user *ss_sp;
-	int			ss_flags;
-	size_t			ss_size;
-} stack_t;
-
-#ifdef __KERNEL__
-
-struct k_sigaction {
-	struct __new_sigaction 	sa;
-	void __user		*ka_restorer;
-};
-
-#define ptrace_signal_deliver(regs, cookie) do { } while (0)
-
-#endif /* !(__KERNEL__) */
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(_ASMSPARC64_SIGNAL_H) */
+#include <asm-sparc/signal.h>
diff --git a/include/asm-sparc64/stat.h b/include/asm-sparc64/stat.h
index 9650fde..b108a86 100644
--- a/include/asm-sparc64/stat.h
+++ b/include/asm-sparc64/stat.h
@@ -1,47 +1 @@
-#ifndef _SPARC64_STAT_H
-#define _SPARC64_STAT_H
-
-#include <linux/types.h>
-
-struct stat {
-	unsigned   st_dev;
-	ino_t   st_ino;
-	mode_t  st_mode;
-	short   st_nlink;
-	uid_t   st_uid;
-	gid_t   st_gid;
-	unsigned   st_rdev;
-	off_t   st_size;
-	time_t  st_atime;
-	time_t  st_mtime;
-	time_t  st_ctime;
-	off_t   st_blksize;
-	off_t   st_blocks;
-	unsigned long  __unused4[2];
-};
-
-struct stat64 {
-	unsigned long	st_dev;
-	unsigned long	st_ino;
-	unsigned long	st_nlink;
-
-	unsigned int	st_mode;
-	unsigned int	st_uid;
-	unsigned int	st_gid;
-	unsigned int	__pad0;
-
-	unsigned long	st_rdev;
-	long		st_size;
-	long		st_blksize;
-	long		st_blocks;
-
-	unsigned long	st_atime;
-	unsigned long	st_atime_nsec;
-	unsigned long	st_mtime;
-	unsigned long	st_mtime_nsec;
-	unsigned long	st_ctime;
-	unsigned long	st_ctime_nsec;
-	long		__unused[3];
-};
-
-#endif
+#include <asm-sparc/stat.h>
diff --git a/include/asm-sparc64/statfs.h b/include/asm-sparc64/statfs.h
index 79b3c89..5503d6a 100644
--- a/include/asm-sparc64/statfs.h
+++ b/include/asm-sparc64/statfs.h
@@ -1,54 +1 @@
-#ifndef _SPARC64_STATFS_H
-#define _SPARC64_STATFS_H
-
-#ifndef __KERNEL_STRICT_NAMES
-
-#include <linux/types.h>
-
-typedef __kernel_fsid_t	fsid_t;
-
-#endif
-
-struct statfs {
-	long f_type;
-	long f_bsize;
-	long f_blocks;
-	long f_bfree;
-	long f_bavail;
-	long f_files;
-	long f_ffree;
-	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_frsize;
-	long f_spare[5];
-};
-
-struct statfs64 {
-	long f_type;
-	long f_bsize;
-	long f_blocks;
-	long f_bfree;
-	long f_bavail;
-	long f_files;
-	long f_ffree;
-	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_frsize;
-	long f_spare[5];
-};
-
-struct compat_statfs64 {
-	__u32 f_type;
-	__u32 f_bsize;
-	__u64 f_blocks;
-	__u64 f_bfree;
-	__u64 f_bavail;
-	__u64 f_files;
-	__u64 f_ffree;
-	__kernel_fsid_t f_fsid;
-	__u32 f_namelen;
-	__u32 f_frsize;
-	__u32 f_spare[5];
-};
-
-#endif
+#include <asm-sparc/statfs.h>
diff --git a/include/asm-sparc64/unistd.h b/include/asm-sparc64/unistd.h
index 13be445..ad86e0b 100644
--- a/include/asm-sparc64/unistd.h
+++ b/include/asm-sparc64/unistd.h
@@ -1,373 +1 @@
-#ifndef _SPARC64_UNISTD_H
-#define _SPARC64_UNISTD_H
-
-/*
- * System calls under the Sparc.
- *
- * Don't be scared by the ugly clobbers, it is the only way I can
- * think of right now to force the arguments into fixed registers
- * before the trap into the system call with gcc 'asm' statements.
- *
- * Copyright (C) 1995, 2007 David S. Miller (davem@davemloft.net)
- *
- * SunOS compatibility based upon preliminary work which is:
- *
- * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
- */
-
-#define __NR_restart_syscall      0 /* Linux Specific				   */
-#define __NR_exit                 1 /* Common                                      */
-#define __NR_fork                 2 /* Common                                      */
-#define __NR_read                 3 /* Common                                      */
-#define __NR_write                4 /* Common                                      */
-#define __NR_open                 5 /* Common                                      */
-#define __NR_close                6 /* Common                                      */
-#define __NR_wait4                7 /* Common                                      */
-#define __NR_creat                8 /* Common                                      */
-#define __NR_link                 9 /* Common                                      */
-#define __NR_unlink              10 /* Common                                      */
-#define __NR_execv               11 /* SunOS Specific                              */
-#define __NR_chdir               12 /* Common                                      */
-#define __NR_chown		 13 /* Common					   */
-#define __NR_mknod               14 /* Common                                      */
-#define __NR_chmod               15 /* Common                                      */
-#define __NR_lchown              16 /* Common                                      */
-#define __NR_brk                 17 /* Common                                      */
-#define __NR_perfctr             18 /* Performance counter operations              */
-#define __NR_lseek               19 /* Common                                      */
-#define __NR_getpid              20 /* Common                                      */
-#define __NR_capget		 21 /* Linux Specific				   */
-#define __NR_capset		 22 /* Linux Specific				   */
-#define __NR_setuid              23 /* Implemented via setreuid in SunOS           */
-#define __NR_getuid              24 /* Common                                      */
-#define __NR_vmsplice	         25 /* ENOSYS under SunOS			   */
-#define __NR_ptrace              26 /* Common                                      */
-#define __NR_alarm               27 /* Implemented via setitimer in SunOS          */
-#define __NR_sigaltstack	 28 /* Common					   */
-#define __NR_pause               29 /* Is sigblock(0)->sigpause() in SunOS         */
-#define __NR_utime               30 /* Implemented via utimes() under SunOS        */
-/* #define __NR_lchown32         31    Linux sparc32 specific                      */
-/* #define __NR_fchown32         32    Linux sparc32 specific                      */
-#define __NR_access              33 /* Common                                      */
-#define __NR_nice                34 /* Implemented via get/setpriority() in SunOS  */
-/* #define __NR_chown32          35    Linux sparc32 specific                      */
-#define __NR_sync                36 /* Common                                      */
-#define __NR_kill                37 /* Common                                      */
-#define __NR_stat                38 /* Common                                      */
-#define __NR_sendfile		 39 /* Linux Specific				   */
-#define __NR_lstat               40 /* Common                                      */
-#define __NR_dup                 41 /* Common                                      */
-#define __NR_pipe                42 /* Common                                      */
-#define __NR_times               43 /* Implemented via getrusage() in SunOS        */
-/* #define __NR_getuid32         44    Linux sparc32 specific                      */
-#define __NR_umount2             45 /* Linux Specific                              */
-#define __NR_setgid              46 /* Implemented via setregid() in SunOS         */
-#define __NR_getgid              47 /* Common                                      */
-#define __NR_signal              48 /* Implemented via sigvec() in SunOS           */
-#define __NR_geteuid             49 /* SunOS calls getuid()                        */
-#define __NR_getegid             50 /* SunOS calls getgid()                        */
-#define __NR_acct                51 /* Common                                      */
-#define __NR_memory_ordering	 52 /* Linux Specific				   */
-/* #define __NR_getgid32         53    Linux sparc32 specific                      */
-#define __NR_ioctl               54 /* Common                                      */
-#define __NR_reboot              55 /* Common                                      */
-/* #define __NR_mmap2		 56    Linux sparc32 Specific                      */
-#define __NR_symlink             57 /* Common                                      */
-#define __NR_readlink            58 /* Common                                      */
-#define __NR_execve              59 /* Common                                      */
-#define __NR_umask               60 /* Common                                      */
-#define __NR_chroot              61 /* Common                                      */
-#define __NR_fstat               62 /* Common                                      */
-#define __NR_fstat64             63 /* Linux Specific                              */
-#define __NR_getpagesize         64 /* Common                                      */
-#define __NR_msync               65 /* Common in newer 1.3.x revs...               */
-#define __NR_vfork               66 /* Common                                      */
-#define __NR_pread64             67 /* Linux Specific                              */
-#define __NR_pwrite64            68 /* Linux Specific                              */
-/* #define __NR_geteuid32        69    Linux sparc32, sbrk under SunOS             */
-/* #define __NR_getegid32        70    Linux sparc32, sstk under SunOS             */
-#define __NR_mmap                71 /* Common                                      */
-/* #define __NR_setreuid32       72    Linux sparc32, vadvise under SunOS          */
-#define __NR_munmap              73 /* Common                                      */
-#define __NR_mprotect            74 /* Common                                      */
-#define __NR_madvise             75 /* Common                                      */
-#define __NR_vhangup             76 /* Common                                      */
-/* #define __NR_truncate64       77    Linux sparc32 Specific			   */
-#define __NR_mincore             78 /* Common                                      */
-#define __NR_getgroups           79 /* Common                                      */
-#define __NR_setgroups           80 /* Common                                      */
-#define __NR_getpgrp             81 /* Common                                      */
-/* #define __NR_setgroups32      82    Linux sparc32, setpgrp under SunOS          */
-#define __NR_setitimer           83 /* Common                                      */
-/* #define __NR_ftruncate64      84    Linux sparc32 Specific			   */
-#define __NR_swapon              85 /* Common                                      */
-#define __NR_getitimer           86 /* Common                                      */
-/* #define __NR_setuid32         87    Linux sparc32, gethostname under SunOS      */
-#define __NR_sethostname         88 /* Common                                      */
-/* #define __NR_setgid32         89    Linux sparc32, getdtablesize under SunOS    */
-#define __NR_dup2                90 /* Common                                      */
-/* #define __NR_setfsuid32       91    Linux sparc32, getdopt under SunOS          */
-#define __NR_fcntl               92 /* Common                                      */
-#define __NR_select              93 /* Common                                      */
-/* #define __NR_setfsgid32       94    Linux sparc32, setdopt under SunOS          */
-#define __NR_fsync               95 /* Common                                      */
-#define __NR_setpriority         96 /* Common                                      */
-#define __NR_socket              97 /* Common                                      */
-#define __NR_connect             98 /* Common                                      */
-#define __NR_accept              99 /* Common                                      */
-#define __NR_getpriority        100 /* Common                                      */
-#define __NR_rt_sigreturn       101 /* Linux Specific                              */
-#define __NR_rt_sigaction       102 /* Linux Specific                              */
-#define __NR_rt_sigprocmask     103 /* Linux Specific                              */
-#define __NR_rt_sigpending      104 /* Linux Specific                              */
-#define __NR_rt_sigtimedwait    105 /* Linux Specific                              */
-#define __NR_rt_sigqueueinfo    106 /* Linux Specific                              */
-#define __NR_rt_sigsuspend      107 /* Linux Specific                              */
-#define __NR_setresuid          108 /* Linux Specific, sigvec under SunOS	   */
-#define __NR_getresuid          109 /* Linux Specific, sigblock under SunOS	   */
-#define __NR_setresgid          110 /* Linux Specific, sigsetmask under SunOS	   */
-#define __NR_getresgid          111 /* Linux Specific, sigpause under SunOS	   */
-/* #define __NR_setregid32       75    Linux sparc32, sigstack under SunOS         */
-#define __NR_recvmsg            113 /* Common                                      */
-#define __NR_sendmsg            114 /* Common                                      */
-/* #define __NR_getgroups32     115    Linux sparc32, vtrace under SunOS           */
-#define __NR_gettimeofday       116 /* Common                                      */
-#define __NR_getrusage          117 /* Common                                      */
-#define __NR_getsockopt         118 /* Common                                      */
-#define __NR_getcwd		119 /* Linux Specific				   */
-#define __NR_readv              120 /* Common                                      */
-#define __NR_writev             121 /* Common                                      */
-#define __NR_settimeofday       122 /* Common                                      */
-#define __NR_fchown             123 /* Common                                      */
-#define __NR_fchmod             124 /* Common                                      */
-#define __NR_recvfrom           125 /* Common                                      */
-#define __NR_setreuid           126 /* Common                                      */
-#define __NR_setregid           127 /* Common                                      */
-#define __NR_rename             128 /* Common                                      */
-#define __NR_truncate           129 /* Common                                      */
-#define __NR_ftruncate          130 /* Common                                      */
-#define __NR_flock              131 /* Common                                      */
-#define __NR_lstat64		132 /* Linux Specific                              */
-#define __NR_sendto             133 /* Common                                      */
-#define __NR_shutdown           134 /* Common                                      */
-#define __NR_socketpair         135 /* Common                                      */
-#define __NR_mkdir              136 /* Common                                      */
-#define __NR_rmdir              137 /* Common                                      */
-#define __NR_utimes             138 /* SunOS Specific                              */
-#define __NR_stat64		139 /* Linux Specific			           */
-#define __NR_sendfile64         140 /* adjtime under SunOS                         */
-#define __NR_getpeername        141 /* Common                                      */
-#define __NR_futex              142 /* gethostid under SunOS                       */
-#define __NR_gettid             143 /* ENOSYS under SunOS                          */
-#define __NR_getrlimit		144 /* Common                                      */
-#define __NR_setrlimit          145 /* Common                                      */
-#define __NR_pivot_root		146 /* Linux Specific, killpg under SunOS          */
-#define __NR_prctl		147 /* ENOSYS under SunOS                          */
-#define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
-#define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
-#define __NR_getsockname        150 /* Common                                      */
-#define __NR_inotify_init       151 /* Linux specific                              */
-#define __NR_inotify_add_watch  152 /* Linux specific                              */
-#define __NR_poll               153 /* Common                                      */
-#define __NR_getdents64		154 /* Linux specific				   */
-/* #define __NR_fcntl64         155    Linux sparc32 Specific                      */
-#define __NR_inotify_rm_watch   156 /* Linux specific				   */
-#define __NR_statfs             157 /* Common                                      */
-#define __NR_fstatfs            158 /* Common                                      */
-#define __NR_umount             159 /* Common                                      */
-#define __NR_sched_set_affinity 160 /* Linux specific, async_daemon under SunOS    */
-#define __NR_sched_get_affinity 161 /* Linux specific, getfh under SunOS           */
-#define __NR_getdomainname      162 /* SunOS Specific                              */
-#define __NR_setdomainname      163 /* Common                                      */
-#define __NR_utrap_install	164 /* SYSV ABI/v9 required			   */
-#define __NR_quotactl           165 /* Common                                      */
-#define __NR_set_tid_address    166 /* Linux specific, exportfs under SunOS        */
-#define __NR_mount              167 /* Common                                      */
-#define __NR_ustat              168 /* Common                                      */
-#define __NR_setxattr           169 /* SunOS: semsys                               */
-#define __NR_lsetxattr          170 /* SunOS: msgsys                               */
-#define __NR_fsetxattr          171 /* SunOS: shmsys                               */
-#define __NR_getxattr           172 /* SunOS: auditsys                             */
-#define __NR_lgetxattr          173 /* SunOS: rfssys                               */
-#define __NR_getdents           174 /* Common                                      */
-#define __NR_setsid             175 /* Common                                      */
-#define __NR_fchdir             176 /* Common                                      */
-#define __NR_fgetxattr          177 /* SunOS: fchroot                              */
-#define __NR_listxattr          178 /* SunOS: vpixsys                              */
-#define __NR_llistxattr         179 /* SunOS: aioread                              */
-#define __NR_flistxattr         180 /* SunOS: aiowrite                             */
-#define __NR_removexattr        181 /* SunOS: aiowait                              */
-#define __NR_lremovexattr       182 /* SunOS: aiocancel                            */
-#define __NR_sigpending         183 /* Common                                      */
-#define __NR_query_module	184 /* Linux Specific				   */
-#define __NR_setpgid            185 /* Common                                      */
-#define __NR_fremovexattr       186 /* SunOS: pathconf                             */
-#define __NR_tkill              187 /* SunOS: fpathconf                            */
-#define __NR_exit_group		188 /* Linux specific, sysconf undef SunOS         */
-#define __NR_uname              189 /* Linux Specific                              */
-#define __NR_init_module        190 /* Linux Specific                              */
-#define __NR_personality        191 /* Linux Specific                              */
-#define __NR_remap_file_pages   192 /* Linux Specific                              */
-#define __NR_epoll_create       193 /* Linux Specific                              */
-#define __NR_epoll_ctl          194 /* Linux Specific                              */
-#define __NR_epoll_wait         195 /* Linux Specific                              */
-#define __NR_ioprio_set         196 /* Linux Specific                              */
-#define __NR_getppid            197 /* Linux Specific                              */
-#define __NR_sigaction          198 /* Linux Specific                              */
-#define __NR_sgetmask           199 /* Linux Specific                              */
-#define __NR_ssetmask           200 /* Linux Specific                              */
-#define __NR_sigsuspend         201 /* Linux Specific                              */
-#define __NR_oldlstat           202 /* Linux Specific                              */
-#define __NR_uselib             203 /* Linux Specific                              */
-#define __NR_readdir            204 /* Linux Specific                              */
-#define __NR_readahead          205 /* Linux Specific                              */
-#define __NR_socketcall         206 /* Linux Specific                              */
-#define __NR_syslog             207 /* Linux Specific                              */
-#define __NR_lookup_dcookie     208 /* Linux Specific                              */
-#define __NR_fadvise64          209 /* Linux Specific                              */
-#define __NR_fadvise64_64       210 /* Linux Specific                              */
-#define __NR_tgkill             211 /* Linux Specific                              */
-#define __NR_waitpid            212 /* Linux Specific                              */
-#define __NR_swapoff            213 /* Linux Specific                              */
-#define __NR_sysinfo            214 /* Linux Specific                              */
-#define __NR_ipc                215 /* Linux Specific                              */
-#define __NR_sigreturn          216 /* Linux Specific                              */
-#define __NR_clone              217 /* Linux Specific                              */
-#define __NR_ioprio_get         218 /* Linux Specific                              */
-#define __NR_adjtimex           219 /* Linux Specific                              */
-#define __NR_sigprocmask        220 /* Linux Specific                              */
-#define __NR_create_module      221 /* Linux Specific                              */
-#define __NR_delete_module      222 /* Linux Specific                              */
-#define __NR_get_kernel_syms    223 /* Linux Specific                              */
-#define __NR_getpgid            224 /* Linux Specific                              */
-#define __NR_bdflush            225 /* Linux Specific                              */
-#define __NR_sysfs              226 /* Linux Specific                              */
-#define __NR_afs_syscall        227 /* Linux Specific                              */
-#define __NR_setfsuid           228 /* Linux Specific                              */
-#define __NR_setfsgid           229 /* Linux Specific                              */
-#define __NR__newselect         230 /* Linux Specific                              */
-#ifdef __KERNEL__
-#define __NR_time		231 /* Linux sparc32                               */
-#endif
-#define __NR_splice             232 /* Linux Specific                              */
-#define __NR_stime              233 /* Linux Specific                              */
-#define __NR_statfs64           234 /* Linux Specific                              */
-#define __NR_fstatfs64          235 /* Linux Specific                              */
-#define __NR__llseek            236 /* Linux Specific                              */
-#define __NR_mlock              237
-#define __NR_munlock            238
-#define __NR_mlockall           239
-#define __NR_munlockall         240
-#define __NR_sched_setparam     241
-#define __NR_sched_getparam     242
-#define __NR_sched_setscheduler 243
-#define __NR_sched_getscheduler 244
-#define __NR_sched_yield        245
-#define __NR_sched_get_priority_max 246
-#define __NR_sched_get_priority_min 247
-#define __NR_sched_rr_get_interval  248
-#define __NR_nanosleep          249
-#define __NR_mremap             250
-#define __NR__sysctl            251
-#define __NR_getsid             252
-#define __NR_fdatasync          253
-#define __NR_nfsservctl         254
-#define __NR_sync_file_range	255
-#define __NR_clock_settime	256
-#define __NR_clock_gettime	257
-#define __NR_clock_getres	258
-#define __NR_clock_nanosleep	259
-#define __NR_sched_getaffinity	260
-#define __NR_sched_setaffinity	261
-#define __NR_timer_settime	262
-#define __NR_timer_gettime	263
-#define __NR_timer_getoverrun	264
-#define __NR_timer_delete	265
-#define __NR_timer_create	266
-/* #define __NR_vserver		267 Reserved for VSERVER */
-#define __NR_io_setup		268
-#define __NR_io_destroy		269
-#define __NR_io_submit		270
-#define __NR_io_cancel		271
-#define __NR_io_getevents	272
-#define __NR_mq_open		273
-#define __NR_mq_unlink		274
-#define __NR_mq_timedsend	275
-#define __NR_mq_timedreceive	276
-#define __NR_mq_notify		277
-#define __NR_mq_getsetattr	278
-#define __NR_waitid		279
-#define __NR_tee		280
-#define __NR_add_key		281
-#define __NR_request_key	282
-#define __NR_keyctl		283
-#define __NR_openat		284
-#define __NR_mkdirat		285
-#define __NR_mknodat		286
-#define __NR_fchownat		287
-#define __NR_futimesat		288
-#define __NR_fstatat64		289
-#define __NR_unlinkat		290
-#define __NR_renameat		291
-#define __NR_linkat		292
-#define __NR_symlinkat		293
-#define __NR_readlinkat		294
-#define __NR_fchmodat		295
-#define __NR_faccessat		296
-#define __NR_pselect6		297
-#define __NR_ppoll		298
-#define __NR_unshare		299
-#define __NR_set_robust_list	300
-#define __NR_get_robust_list	301
-#define __NR_migrate_pages	302
-#define __NR_mbind		303
-#define __NR_get_mempolicy	304
-#define __NR_set_mempolicy	305
-#define __NR_kexec_load		306
-#define __NR_move_pages		307
-#define __NR_getcpu		308
-#define __NR_epoll_pwait	309
-#define __NR_utimensat		310
-#define __NR_signalfd		311
-#define __NR_timerfd_create	312
-#define __NR_eventfd		313
-#define __NR_fallocate		314
-#define __NR_timerfd_settime	315
-#define __NR_timerfd_gettime	316
-
-#define NR_SYSCALLS		317
-
-#ifdef __KERNEL__
-#define __ARCH_WANT_IPC_PARSE_VERSION
-#define __ARCH_WANT_OLD_READDIR
-#define __ARCH_WANT_STAT64
-#define __ARCH_WANT_SYS_ALARM
-#define __ARCH_WANT_SYS_GETHOSTNAME
-#define __ARCH_WANT_SYS_PAUSE
-#define __ARCH_WANT_SYS_SGETMASK
-#define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_COMPAT_SYS_TIME
-#define __ARCH_WANT_SYS_UTIME
-#define __ARCH_WANT_SYS_WAITPID
-#define __ARCH_WANT_SYS_SOCKETCALL
-#define __ARCH_WANT_SYS_FADVISE64
-#define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
-#define __ARCH_WANT_SYS_NICE
-#define __ARCH_WANT_SYS_OLDUMOUNT
-#define __ARCH_WANT_SYS_SIGPENDING
-#define __ARCH_WANT_SYS_SIGPROCMASK
-#define __ARCH_WANT_SYS_RT_SIGSUSPEND
-#define __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
-
-/*
- * "Conditional" syscalls
- *
- * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
- * but it doesn't work on all toolchains, so we just do it by hand
- */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
-
-#endif /* __KERNEL__ */
-#endif /* _SPARC64_UNISTD_H */
+#include <asm-sparc/unistd.h>
-- 
1.5.4.1.143.ge7e51

