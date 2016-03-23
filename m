From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 23 Mar 2016 22:41:08 +0000
Subject: [Patch V2 2/2] sparc64 changes
Message-Id: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Based on original work by Karl Volz <karl.volz@oracle.com>
---
 Makefile            |    9 +-
 configure.c         |   23 +
 defs.h              |  191 ++++++++-
 diskdump.c          |   36 ++-
 lkcd_vmdump_v2_v3.h |    2 +-
 sparc64.c           | 1186 +++++++++++++++++++++++++++++++++++++++++++++++++++
 symbols.c           |   10 +
 task.c              |   23 +-
 8 files changed, 1471 insertions(+), 9 deletions(-)
 create mode 100644 sparc64.c

diff --git a/Makefile b/Makefile
index e3e4d7d..ed5b43a 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,7 @@
 PROGRAM=crash
 
 #
-# Supported targets: X86 ALPHA PPC IA64 PPC64
+# Supported targets: X86 ALPHA PPC IA64 PPC64 SPARC64
 # TARGET and GDB_CONF_FLAGS will be configured automatically by configure
 #
 TARGET@@ -62,7 +62,7 @@ VMWARE_HFILES=vmware_vmss.h
 CFILES=main.c tools.c global_data.c memory.c filesys.c help.c task.c \
 	kernel.c test.c gdb_interface.c configure.c net.c dev.c \
 	alpha.c x86.c ppc.c ia64.c s390.c s390x.c s390dbf.c ppc64.c x86_64.c \
-	arm.c arm64.c mips.c \
+	arm.c arm64.c mips.c sparc64.c \
 	extensions.c remote.c va_server.c va_server_v1.c symbols.c cmdline.c \
 	lkcd_common.c lkcd_v1.c lkcd_v2_v3.c lkcd_v5.c lkcd_v7.c lkcd_v8.c\
 	lkcd_fix_mem.c s390_dump.c lkcd_x86_trace.c \
@@ -81,7 +81,7 @@ SOURCE_FILES=${CFILES} ${GENERIC_HFILES} ${MCORE_HFILES} \
 OBJECT_FILES=main.o tools.o global_data.o memory.o filesys.o help.o task.o \
 	build_data.o kernel.o test.o gdb_interface.o net.o dev.o \
 	alpha.o x86.o ppc.o ia64.o s390.o s390x.o s390dbf.o ppc64.o x86_64.o \
-	arm.o arm64.o mips.o \
+	arm.o arm64.o mips.o sparc64.o \
 	extensions.o remote.o va_server.o va_server_v1.o symbols.o cmdline.o \
 	lkcd_common.o lkcd_v1.o lkcd_v2_v3.o lkcd_v5.o lkcd_v7.o lkcd_v8.o \
 	lkcd_fix_mem.o s390_dump.o netdump.o diskdump.o makedumpfile.o xendump.o \
@@ -422,6 +422,9 @@ arm64.o: ${GENERIC_HFILES} ${REDHAT_HFILES} arm64.c
 mips.o: ${GENERIC_HFILES} ${REDHAT_HFILES} mips.c
 	${CC} -c ${CRASH_CFLAGS} mips.c ${WARNING_OPTIONS} ${WARNING_ERROR}
 
+sparc64.o: ${GENERIC_HFILES} ${REDHAT_HFILES} sparc64.c
+	${CC} -c ${CRASH_CFLAGS} sparc64.c ${WARNING_OPTIONS} ${WARNING_ERROR}
+
 s390.o: ${GENERIC_HFILES} ${IBM_HFILES} s390.c
 	${CC} -c ${CRASH_CFLAGS} s390.c ${WARNING_OPTIONS} ${WARNING_ERROR}
 
diff --git a/configure.c b/configure.c
index a5167db..a416b86 100644
--- a/configure.c
+++ b/configure.c
@@ -104,6 +104,7 @@ void add_extra_lib(char *);
 #undef X86_64
 #undef ARM
 #undef ARM64
+#undef SPARC64
 
 #define UNKNOWN 0
 #define X86     1
@@ -117,6 +118,7 @@ void add_extra_lib(char *);
 #define ARM	9
 #define ARM64   10
 #define MIPS    11
+#define SPARC64 12
 
 #define TARGET_X86    "TARGET=X86"
 #define TARGET_ALPHA  "TARGET=ALPHA"
@@ -129,6 +131,7 @@ void add_extra_lib(char *);
 #define TARGET_ARM    "TARGET=ARM"
 #define TARGET_ARM64  "TARGET=ARM64"
 #define TARGET_MIPS   "TARGET=MIPS"
+#define TARGET_SPARC64 "TARGET=SPARC64"
 
 #define TARGET_CFLAGS_X86    "TARGET_CFLAGS=-D_FILE_OFFSET_BITSd"
 #define TARGET_CFLAGS_ALPHA  "TARGET_CFLAGS="
@@ -149,6 +152,7 @@ void add_extra_lib(char *);
 #define TARGET_CFLAGS_MIPS            "TARGET_CFLAGS=-D_FILE_OFFSET_BITSd"
 #define TARGET_CFLAGS_MIPS_ON_X86     "TARGET_CFLAGS=-D_FILE_OFFSET_BITSd"
 #define TARGET_CFLAGS_MIPS_ON_X86_64  "TARGET_CFLAGS=-m32 -D_FILE_OFFSET_BITSd"
+#define TARGET_CFLAGS_SPARC64         "TARGET_CFLAGS=-mcpu=v9 -fPIC -fno-builtin"
 
 #define GDB_TARGET_DEFAULT        "GDB_CONF_FLAGS="
 #define GDB_TARGET_ARM_ON_X86     "GDB_CONF_FLAGS=--target=arm-elf-linux"
@@ -378,6 +382,9 @@ get_current_configuration(struct supported_gdb_version *sp)
 #ifdef __mips__
         target_data.target = MIPS;
 #endif
+#if defined(__sparc__) && defined(__arch64__)
+	target_data.target = SPARC64;
+#endif
 
 	set_initial_target(sp);
 
@@ -510,6 +517,10 @@ get_current_configuration(struct supported_gdb_version *sp)
 		if ((target_data.target = PPC) &&
 		    (target_data.initial_gdb_target != PPC))
 			arch_mismatch(sp);
+
+		if ((target_data.target = SPARC64) &&
+		    (target_data.initial_gdb_target != SPARC64))
+			arch_mismatch(sp);
 	}
 
         if ((fp = fopen("Makefile", "r")) = NULL) {
@@ -620,6 +631,9 @@ show_configuration(void)
 	case MIPS:
 		printf("TARGET: MIPS\n");
 		break;
+	case SPARC64:
+		printf("TARGET: SPARC64\n");
+		break;
 	}
 
 	if (strlen(target_data.program)) {
@@ -729,6 +743,10 @@ build_configure(struct supported_gdb_version *sp)
 		} else
                         target_CFLAGS = TARGET_CFLAGS_MIPS;
                 break;
+	case SPARC64:
+		target = TARGET_SPARC64;
+		target_CFLAGS = TARGET_CFLAGS_SPARC64;
+		break;
 	}
 
 	ldflags = get_extra_flags("LDFLAGS.extra", NULL);
@@ -1554,6 +1572,8 @@ set_initial_target(struct supported_gdb_version *sp)
 		target_data.initial_gdb_target = ARM;
 	else if (strncmp(buf, "MIPS", strlen("MIPS")) = 0)
 		target_data.initial_gdb_target = MIPS;
+	else if (strncmp(buf, "SPARC64", strlen("SPARC64")) = 0)
+		target_data.initial_gdb_target = SPARC64;
 }
 
 char *
@@ -1572,6 +1592,7 @@ target_to_name(int target)
 	case ARM:    return("ARM"); 
 	case ARM64:  return("ARM64");
 	case MIPS:   return("MIPS");
+	case SPARC64: return("SPARC64");
 	}
 
 	return "UNKNOWN";
@@ -1630,6 +1651,8 @@ name_to_target(char *name)
                 return MIPS;
         else if (strncmp(name, "MIPS", strlen("MIPS")) = 0)
                 return MIPS;
+	else if (strncmp(name, "sparc64", strlen("sparc64")) = 0)
+		return SPARC64;
 
 	return UNKNOWN;
 }
diff --git a/defs.h b/defs.h
index 2ecfa03..2039c52 100644
--- a/defs.h
+++ b/defs.h
@@ -71,7 +71,7 @@
 
 #if !defined(X86) && !defined(X86_64) && !defined(ALPHA) && !defined(PPC) && \
     !defined(IA64) && !defined(PPC64) && !defined(S390) && !defined(S390X) && \
-    !defined(ARM) && !defined(ARM64) && !defined(MIPS)
+    !defined(ARM) && !defined(ARM64) && !defined(MIPS) && !defined(SPARC64)
 #ifdef __alpha__
 #define ALPHA
 #endif
@@ -106,6 +106,9 @@
 #ifdef __mipsel__
 #define MIPS
 #endif
+#ifdef __sparc_v9__
+#define SPARC64
+#endif
 #endif
 
 #ifdef X86
@@ -141,6 +144,14 @@
 #ifdef MIPS
 #define NR_CPUS  (32)
 #endif
+#ifdef SPARC64
+#define NR_CPUS  (4096)
+#endif
+
+/* Some architectures require memory accesses to be aligned.  */
+#if defined(SPARC64)
+#define NEED_ALIGNED_MEM_ACCESS
+#endif
 
 #define BUFSIZE  (1500)
 #define NULLCHAR ('\0')
@@ -2091,6 +2102,7 @@ struct size_table {         /* stash of commonly-used sizes */
 	long hrtimer_base;
 	long tnt;
 	long trace_print_flags;
+	long task_struct_flags;
 };
 
 struct array_table {
@@ -2184,6 +2196,45 @@ struct builtin_debug_table {
  *  Facilitators for pulling correctly-sized data out of a buffer at a
  *  known address. 
  */
+
+#ifdef NEED_ALIGNED_MEM_ACCESS
+
+#define DEF_LOADER(TYPE)			\
+static inline TYPE				\
+load_##TYPE (char *addr)			\
+{						\
+	TYPE ret;				\
+	size_t i = sizeof(TYPE);		\
+	while (i--)				\
+		((char *)&ret)[i] = addr[i];	\
+	return ret;				\
+}
+
+DEF_LOADER(int);
+DEF_LOADER(uint);
+DEF_LOADER(long);
+DEF_LOADER(ulong);
+DEF_LOADER(ulonglong);
+DEF_LOADER(ushort);
+DEF_LOADER(short);
+typedef void *pointer_t;
+DEF_LOADER(pointer_t);
+
+#define LOADER(TYPE) load_##TYPE
+
+#define INT(ADDR)       LOADER(int) ((char *)(ADDR))
+#define UINT(ADDR)      LOADER(uint) ((char *)(ADDR))
+#define LONG(ADDR)      LOADER(long) ((char *)(ADDR))
+#define ULONG(ADDR)     LOADER(ulong) ((char *)(ADDR))
+#define ULONGLONG(ADDR) LOADER(ulonglong) ((char *)(ADDR))
+#define ULONG_PTR(ADDR) ((ulong *) (LOADER(pointer_t) ((char *)(ADDR))))
+#define USHORT(ADDR)    LOADER(ushort) ((char *)(ADDR))
+#define SHORT(ADDR)     LOADER(short) ((char *)(ADDR))
+#define UCHAR(ADDR)     *((unsigned char *)((char *)(ADDR)))
+#define VOID_PTR(ADDR)  ((void *) (LOADER(pointer_t) ((char *)(ADDR))))
+
+#else
+
 #define INT(ADDR)       *((int *)((char *)(ADDR)))
 #define UINT(ADDR)      *((uint *)((char *)(ADDR)))
 #define LONG(ADDR)      *((long *)((char *)(ADDR)))
@@ -2195,6 +2246,8 @@ struct builtin_debug_table {
 #define UCHAR(ADDR)     *((unsigned char *)((char *)(ADDR)))
 #define VOID_PTR(ADDR)  *((void **)((char *)(ADDR)))
 
+#endif /* NEED_ALIGNED_MEM_ACCESS */
+
 struct node_table {
 	int node_id;
 	ulong pgdat;
@@ -3799,6 +3852,121 @@ struct efi_memory_desc_t {
 
 #endif  /* S390X */
 
+#ifdef SPARC64
+#define _64BIT_
+#define MACHINE_TYPE       "SPARC64"
+
+#define PTOV(X) \
+	((unsigned long)(X)-(machdep->machspec->phys_offset)+(machdep->kvbase))
+#define VTOP(X) \
+	((unsigned long)(X)-(machdep->kvbase)+(machdep->machspec->phys_offset))
+
+#define USERSPACE_TOP   (machdep->machspec->userspace_top)
+#define PAGE_OFFSET     (machdep->machspec->page_offset)
+#define VMALLOC_START   (machdep->machspec->vmalloc_start_addr)
+#define VMALLOC_END     (machdep->machspec->vmalloc_end)
+#define MODULES_VADDR   (machdep->machspec->modules_vaddr)
+#define MODULES_END     (machdep->machspec->modules_end)
+
+extern int sparc64_IS_VMALLOC_ADDR(ulong vaddr);
+#define IS_VMALLOC_ADDR(X)    sparc64_IS_VMALLOC_ADDR((ulong)(X))
+#define PAGE_SHIFT	(13)
+#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGEBASE(X)     (((ulong)(X)) & (ulong)machdep->pagemask)
+#define THREAD_SIZE	(2*PAGE_SIZE)
+
+/* S3 Core
+ *	Core 48-bit physical address supported.
+ *	Bit 47 distinguishes memory or I/O. When set to "1" it is I/O.
+ */
+#define PHYS_MASK_SHIFT   (47)
+#define PHYS_MASK         (((1UL) << PHYS_MASK_SHIFT) - 1)
+
+typedef signed int s32;
+
+/*
+ * This next two defines are convenience defines for normal page table.
+ */
+#define PTES_PER_PAGE		(1UL << (PAGE_SHIFT - 3))
+#define PTES_PER_PAGE_MASK	(PTES_PER_PAGE - 1)
+
+/* 4-levels / 8K pages */
+#define PG_LVL4_PDIRS_BITS	(53)
+#define PG_LVL4_PGDIR_SHIFT	(43)
+#define PG_LVL4_PTRS_PER_PGD	(1024)
+#define PG_LVL4_PUD_SHIFT	(33)
+#define PG_LVL4_PTRS_PER_PUD	(1024)
+#define PG_LVL4_PMD_SHIFT	(23)
+#define PG_LVL4_PTRS_PER_PMD	(1024)
+#define PG_LVL4_PTRS_PER_PTE	(1UL << (PAGE_SHIFT-3))
+/* Down one huge page */
+#define PG_LVL4_SPARC64_USERSPACE_TOP  (-(1UL << 23UL))
+#define PAGE_PMD_HUGE		 (0x0100000000000000UL)
+#define HPAGE_SHIFT		(23)
+
+/* These are for SUN4V.  */
+#define _PAGE_VALID		(0x8000000000000000UL)
+#define _PAGE_NFO_4V		(0x4000000000000000UL)
+#define	_PAGE_MODIFIED_4V	(0x2000000000000000UL)
+#define	_PAGE_ACCESSED_4V	(0x1000000000000000UL)
+#define	_PAGE_READ_4V		(0x0800000000000000UL)
+#define	_PAGE_WRITE_4V		(0x0400000000000000UL)
+#define	_PAGE_PADDR_4V		(0x00FFFFFFFFFFE000UL)
+#define _PAGE_PFN_MASK		(_PAGE_PADDR_4V)
+#define	_PAGE_P_4V		(0x0000000000000100UL)
+#define	_PAGE_EXEC_4V		(0x0000000000000080UL)
+#define	_PAGE_W_4V		(0x0000000000000040UL)
+#define _PAGE_PRESENT_4V	(0x0000000000000010UL)
+#define	_PAGE_SZALL_4V		(0x0000000000000007UL)
+/* There are other page sizes. Some supported. */
+#define	_PAGE_SZ4MB_4V		(0x0000000000000003UL)
+#define	_PAGE_SZ512K_4V		(0x0000000000000002UL)
+#define	_PAGE_SZ64K_4V		(0x0000000000000001UL)
+#define _PAGE_SZ8K_4V		(0x0000000000000000UL)
+
+#define SPARC64_MODULES_VADDR	(0x0000000010000000UL)
+#define SPARC64_MODULES_END	(0x00000000f0000000UL)
+#define LOW_OBP_ADDRESS		(0x00000000f0000000UL)
+#define HI_OBP_ADDRESS		(0x0000000100000000UL)
+#define SPARC64_VMALLOC_START	(0x0000000100000000UL)
+
+#define SPARC64_STACK_SIZE	0x4000
+#define PTRS_PER_PGD		(1024)
+
+/* sparsemem */
+#define _SECTION_SIZE_BITS      30
+#define _MAX_PHYSMEM_BITS_LVL4  53
+
+#define STACK_BIAS	2047
+
+struct machine_specific {
+	ulong flags;
+	ulong userspace_top;
+	ulong page_offset;
+	ulong vmalloc_start;
+	ulong vmalloc_end;
+	ulong modules_vaddr;
+	ulong modules_end;
+	ulong phys_offset;
+	ulong __exception_text_start;
+	ulong __exception_text_end;
+	struct pt_regs *panic_task_regs;
+	ulong pte_protnone;
+	ulong pte_file;
+	uint pgd_shift;
+	uint pud_shift;
+	uint pmd_shift;
+	uint ptes_per_pte;
+};
+
+#define TIF_SIGPENDING	(2)
+#define SWP_OFFSET(E)	((E) >> (13UL+8UL))
+#define SWP_TYPE(E)	(((E) >> (13UL)) & 0xffUL)
+#define __swp_type(E)	SWP_TYPE(E)
+#define	__swp_offset(E)	SWP_OFFSET(E)
+#endif /* SPARC64 */
+
 #ifdef PLATFORM
 
 #define SWP_TYPE(entry)   (error("PLATFORM_SWP_TYPE: TBD\n"))
@@ -3863,6 +4031,10 @@ struct efi_memory_desc_t {
 #define MAX_HEXADDR_STRLEN (8)
 #define UVADDR_PRLEN       (8)
 #endif
+#ifdef SPARC64
+#define MAX_HEXADDR_STRLEN (16)
+#define UVADDR_PRLEN      (16)
+#endif
 
 #define BADADDR  ((ulong)(-1))
 #define BADVAL   ((ulong)(-1))
@@ -4404,6 +4576,9 @@ void dump_build_data(void);
 #ifdef MIPS
 #define machdep_init(X) mips_init(X)
 #endif
+#ifdef SPARC64
+#define machdep_init(X) sparc64_init(X)
+#endif
 int clean_exit(int);
 int untrusted_file(FILE *, char *);
 char *readmem_function_name(void);
@@ -4838,6 +5013,9 @@ void display_help_screen(char *);
 #ifdef MIPS
 #define dump_machdep_table(X) mips_dump_machdep_table(X)
 #endif
+#ifdef SPARC64
+#define dump_machdep_table(X) sparc64_dump_machdep_table(X)
+#endif
 extern char *help_pointer[];
 extern char *help_alias[];
 extern char *help_ascii[];
@@ -5690,6 +5868,17 @@ struct machine_specific {
 #endif /* MIPS */
 
 /*
+ * sparc64.c
+ */
+#ifdef SPARC64
+void sparc64_init(int);
+void sparc64_dump_machdep_table(ulong);
+int sparc64_vmalloc_addr(ulong);
+#define display_idt_table() \
+	error(FATAL, "The -d option is not applicable to sparc64.\n")
+#endif
+
+/*
  *  netdump.c 
  */
 int is_netdump(char *, ulong);
diff --git a/diskdump.c b/diskdump.c
index f5ec23d..48667ad 100644
--- a/diskdump.c
+++ b/diskdump.c
@@ -730,6 +730,8 @@ restart:
 		dd->machine_type = EM_S390;
 	else if (machine_type("ARM64"))
 		dd->machine_type = EM_AARCH64;
+	else if (machine_type("SPARC64"))
+		dd->machine_type = EM_SPARCV9;
 	else {
 		error(INFO, "%s: unsupported machine type: %s\n", 
 			DISKDUMP_VALID() ? "diskdump" : "compressed kdump",
@@ -1382,6 +1384,31 @@ get_diskdump_regs_arm64(struct bt_info *bt, ulong *eip, ulong *esp)
 	machdep->get_stack_frame(bt, eip, esp);
 }
 
+static void
+get_diskdump_regs_sparc64(struct bt_info *bt, ulong *eip, ulong *esp)
+{
+	Elf64_Nhdr *note;
+	int len;
+
+	if (KDUMP_CMPRS_VALID() &&
+		(bt->task = tt->panic_task ||
+		(is_task_active(bt->task) && dd->num_prstatus_notes > 1))) {
+		note  = (Elf64_Nhdr *)dd->nt_prstatus_percpu[bt->tc->processor];
+		if (!note)
+			error(FATAL,
+				    "cannot determine NT_PRSTATUS ELF note "
+				    "for %s task: %lx\n",
+					(bt->task = tt->panic_task) ?
+					"panic" : "active", bt->task);
+		len = sizeof(Elf64_Nhdr);
+		len = roundup(len + note->n_namesz, 4);
+		bt->machdep = (void *)((char *)note + len +
+			MEMBER_OFFSET("elf_prstatus", "pr_reg"));
+	}
+
+	machdep->get_stack_frame(bt, eip, esp);
+}
+
 /*
  *  Send the request to the proper architecture hander.
  */
@@ -1432,6 +1459,10 @@ get_diskdump_regs(struct bt_info *bt, ulong *eip, ulong *esp)
 		get_diskdump_regs_arm64(bt, eip, esp);
 		break;
 
+	case EM_SPARCV9:
+		get_diskdump_regs_sparc64(bt, eip, esp);
+		break;
+
 	default:
 		error(FATAL, "%s: unsupported machine type: %s\n",
 			DISKDUMP_VALID() ? "diskdump" : "compressed kdump",
@@ -1577,7 +1608,8 @@ dump_note_offsets(FILE *fp)
 		for (tot = cnt = 0; tot < size; tot += len) {
 			qemu = FALSE;
 			if (machine_type("X86_64") || machine_type("S390X") ||
-			    machine_type("ARM64") || machine_type("PPC64")) {
+			    machine_type("ARM64") || machine_type("PPC64") ||
+			    machine_type("SPARC64")) {
 				note64 = (void *)dd->notes_buf + tot;
 				len = sizeof(Elf64_Nhdr);
 				if (STRNEQ((char *)note64 + len, "QEMU"))
@@ -1684,6 +1716,8 @@ __diskdump_memory_dump(FILE *fp)
 		fprintf(fp, "(EM_S390)\n"); break;
 	case EM_AARCH64:
 		fprintf(fp, "(EM_AARCH64)\n"); break;
+	case EM_SPARCV9:
+		fprintf(fp, "(EM_SPARCV9)\n"); break;
 	default:
 		fprintf(fp, "(unknown)\n"); break;
 	}
diff --git a/lkcd_vmdump_v2_v3.h b/lkcd_vmdump_v2_v3.h
index 7b014ec..8d5eae4 100644
--- a/lkcd_vmdump_v2_v3.h
+++ b/lkcd_vmdump_v2_v3.h
@@ -36,7 +36,7 @@
 #endif
 
 #if defined(ARM) || defined(X86) || defined(PPC) || defined(S390) || \
-	defined(S390X) || defined(ARM64) || defined(MIPS)
+	defined(S390X) || defined(ARM64) || defined(MIPS) || defined(SPARC64)
 
 /*
  * Kernel header file for Linux crash dumps.
diff --git a/sparc64.c b/sparc64.c
new file mode 100644
index 0000000..7d26137
--- /dev/null
+++ b/sparc64.c
@@ -0,0 +1,1186 @@
+#ifdef SPARC64
+
+#include "defs.h"
+#include <stdio.h>
+#include <elf.h>
+#include <asm/ptrace.h>
+#include <linux/const.h>
+
+/* Things not done, debugged or tested at this point:
+ * 1) uvtop swap handling
+ * 2) uniform page table layout - like we had in 1st quarter of 2013
+ * 3) and whatever can't be thought of.
+ */
+#define	true	(1)
+#define	false	(0)
+
+static const unsigned long not_valid_pte = ~0UL;
+static struct machine_specific sparc64_machine_specific;
+static unsigned long sparc64_ksp_offset;
+#define	MAGIC_TT		(0x1ff)
+
+static unsigned long __va(unsigned long paddr)
+{
+	return paddr + PAGE_OFFSET;
+}
+
+static unsigned long __pa(unsigned long vaddr)
+{
+	return vaddr - PAGE_OFFSET;
+}
+
+static uint page_size(void)
+{
+	return machdep->pagesize;
+}
+
+static void sparc64_parse_cmdline_args(void)
+{
+}
+
+/* This interface might not be required. */
+static void sparc64_clear_machdep_cache(void)
+{
+}
+
+/*
+ *  "mach" command output.
+ */
+static void
+sparc64_display_machine_stats(void)
+{
+	int c;
+	struct new_utsname *uts;
+	char buf[BUFSIZE];
+	ulong mhz;
+
+	uts = &kt->utsname;
+
+	fprintf(fp, "          MACHINE TYPE: %s\n", uts->machine);
+	fprintf(fp, "           MEMORY SIZE: %s\n", get_memory_size(buf));
+	fprintf(fp, "                  CPUS: %d\n", kt->cpus);
+	fprintf(fp, "       PROCESSOR SPEED: ");
+	if ((mhz = machdep->processor_speed()))
+		fprintf(fp, "%ld Mhz\n", mhz);
+	else
+		fprintf(fp, "(unknown)\n");
+	fprintf(fp, "                    HZ: %d\n", machdep->hz);
+	fprintf(fp, "             PAGE SIZE: %d\n", PAGESIZE());
+	fprintf(fp, "   KERNEL VIRTUAL BASE: %lx\n", machdep->kvbase);
+	fprintf(fp, "   KERNEL VMALLOC BASE: %lx\n", vt->vmalloc_start);
+	fprintf(fp, "   KERNEL MODULES BASE: %lx\n", MODULES_VADDR);
+	fprintf(fp, "     KERNEL STACK SIZE: %ld\n", STACKSIZE());
+
+	fprintf(fp, "HARD IRQ STACK SIZE: %ld\n", THREAD_SIZE);
+	fprintf(fp, "    HARD IRQ STACKS:\n");
+
+	for (c = 0; c < kt->cpus; c++) {
+		if (!tt->hardirq_ctx[c])
+			continue;
+		sprintf(buf, "CPU %d", c);
+		fprintf(fp, "%19s: %lx\n", buf, tt->hardirq_ctx[c]);
+	}
+
+	fprintf(fp, "SOFT IRQ STACK SIZE: %ld\n", THREAD_SIZE);
+	fprintf(fp, "    SOFT IRQ STACKS:\n");
+	for (c = 0; c < kt->cpus; c++) {
+		if (!tt->softirq_ctx[c])
+			continue;
+		sprintf(buf, "CPU %d", c);
+		fprintf(fp, "%19s: %lx\n", buf, tt->softirq_ctx[c]);
+	}
+}
+
+static void sparc64_display_memmap(void)
+{
+	unsigned long iomem_resource;
+	unsigned long resource;
+	unsigned long start, end, nameptr;
+	int size = STRUCT_SIZE("resource");
+	char *buf = GETBUF(size);
+	char name[32];
+
+	iomem_resource = symbol_value("iomem_resource");
+
+	readmem(iomem_resource + MEMBER_OFFSET("resource", "child"), KVADDR,
+		&resource, sizeof(resource), "iomem_resource", FAULT_ON_ERROR);
+
+	fprintf(fp, "      PHYSICAL ADDRESS RANGE         TYPE\n");
+
+	while (resource) {
+		readmem(resource, KVADDR, buf, size, "resource",
+			FAULT_ON_ERROR);
+		start = ULONG(buf + MEMBER_OFFSET("resource", "start"));
+		end = ULONG(buf + MEMBER_OFFSET("resource", "end"));
+		nameptr = ULONG(buf + MEMBER_OFFSET("resource", "name"));
+
+		readmem(nameptr, KVADDR, name, sizeof(name), "resource.name",
+			FAULT_ON_ERROR);
+
+		fprintf(fp, "%016lx - %016lx  %-32s\n", start, end, name);
+
+		resource = ULONG(buf + MEMBER_OFFSET("resource", "sibling"));
+	}
+}
+
+static void sparc64_cmd_mach(void)
+{
+	int c;
+	int mflag = 0;
+
+	while ((c = getopt(argcnt, args, "cm")) != EOF) {
+		switch (c) {
+		case 'm':
+			mflag++;
+			sparc64_display_memmap();
+			break;
+		case 'c':
+			fprintf(fp, "SPARC64: '-%c' option is not supported\n",
+				c);
+			break;
+		default:
+			argerrs++;
+			break;
+		}
+	}
+
+	if (argerrs)
+		cmd_usage(pc->curcmd, SYNOPSIS);
+
+	if (!mflag)
+		sparc64_display_machine_stats();
+}
+
+struct sparc64_mem_ranges {
+	unsigned long start;
+	unsigned long end;
+};
+
+#define NR_PHYS_RANGES	(128)
+static unsigned int nr_phys_ranges;
+struct sparc64_mem_ranges phys_ranges[NR_PHYS_RANGES];
+
+#define NR_IMAGE_RANGES (16)
+static unsigned int nr_kimage_ranges;
+struct sparc64_mem_ranges kimage_ranges[NR_IMAGE_RANGES];
+
+/* There are three live cases:
+ *  one) normal kernel
+ *  two) --load-panic kernel
+ *  and
+ *  three) --load kernel
+ * One and two can be treated the same because the kernel is physically
+ * contiguous. Three isn't contiguous. The kernel is allocated in order
+ * nine allocation pages. We don't handle case three yet.
+ */
+
+static int sparc64_phys_live_valid(unsigned long paddr)
+{
+	unsigned int nr;
+	int rc = false;
+
+	for (nr = 0U; nr != nr_phys_ranges; nr++) {
+		if (paddr >= phys_ranges[nr].start &&
+			paddr < phys_ranges[nr].end) {
+			rc = true;
+			break;
+		}
+	}
+	return rc;
+}
+
+static int sparc64_phys_kdump_valid(unsigned long paddr)
+{
+	return true;
+}
+
+static int sparc64_verify_paddr(unsigned long paddr)
+{
+	int rc;
+
+	if (ACTIVE())
+		rc = sparc64_phys_live_valid(paddr);
+	else
+		rc = sparc64_phys_kdump_valid(paddr);
+
+	return rc;
+}
+
+static void sparc6_phys_base_live_limits(void)
+{
+	if (nr_phys_ranges >= NR_PHYS_RANGES)
+		error(FATAL, "sparc6_phys_base_live_limits: "
+			"NR_PHYS_RANGES exceeded.\n");
+	else if (nr_kimage_ranges >= NR_IMAGE_RANGES)
+		error(FATAL, "sparc6_phys_base_live_limits: "
+			"NR_IMAGE_RANGES exceeded.\n");
+}
+
+static void sparc64_phys_base_live_valid(void)
+{
+	if (!nr_phys_ranges)
+		error(FATAL, "No physical memory ranges.");
+	else if (!nr_kimage_ranges)
+		error(FATAL, "No vmlinux memory ranges.");
+}
+
+static void sparc64_phys_base_live(void)
+{
+	char line[BUFSIZE];
+	FILE *fp;
+
+	fp = fopen("/proc/iomem", "r");
+	if (fp = NULL)
+		error(FATAL, "Can't open /proc/iomem. We can't proceed.");
+
+	while (fgets(line, sizeof(line), fp) != 0) {
+		unsigned long start, end;
+		int count, consumed;
+		char *ch;
+
+		sparc6_phys_base_live_limits();
+		count = sscanf(line, "%lx-%lx : %n", &start, &end, &consumed);
+		if (count != 2)
+			continue;
+		ch = line + consumed;
+		if (memcmp(ch, "System RAM\n", 11) = 0) {
+			end = end + 1;
+			phys_ranges[nr_phys_ranges].start = start;
+			phys_ranges[nr_phys_ranges].end = end;
+			nr_phys_ranges++;
+		} else if ((memcmp(ch, "Kernel code\n", 12) = 0) ||
+				(memcmp(ch, "Kernel data\n", 12) = 0) ||
+				(memcmp(ch, "Kernel bss\n", 11) = 0)) {
+			kimage_ranges[nr_kimage_ranges].start = start;
+			kimage_ranges[nr_kimage_ranges].end = end;
+			nr_kimage_ranges++;
+		}
+	}
+
+	(void) fclose(fp);
+	sparc64_phys_base_live_valid();
+}
+
+static void sparc64_phys_base_kdump(void)
+{
+}
+
+static void sparc64_phys_base(void)
+{
+	if (ACTIVE())
+		return sparc64_phys_base_live();
+	else
+		return sparc64_phys_base_kdump();
+}
+
+static unsigned long kva_start, kva_end;
+static unsigned long kpa_start, kpa_end;
+
+static void sparc64_kimage_limits_live(void)
+{
+	kpa_start = kimage_ranges[0].start;
+	kpa_end = kpa_start + (kva_end - kva_start);
+}
+
+static void sparc64_kimage_limits_kdump(void)
+{
+	unsigned long phys_base;
+
+	if (DISKDUMP_DUMPFILE()) {
+		if (diskdump_phys_base(&phys_base)) {
+			kpa_start = phys_base | (kva_start & 0xffff);
+			kpa_end = kpa_start + (kva_end - kva_start);
+			return;
+		}
+	}
+	fprintf(stderr, "Can't determine phys_base\n");
+}
+
+static unsigned long kimage_va_translate(unsigned long addr)
+{
+	unsigned long paddr = (addr - kva_start) + kpa_start;
+
+	return paddr;
+}
+
+static int kimage_va_range(unsigned long addr)
+{
+	if (addr >= kva_start && addr < kva_end)
+		return true;
+	else
+		return false;
+}
+
+static void sparc64_kimage_limits(void)
+{
+	kva_start = symbol_value("_stext");
+	kva_end = symbol_value("_end");
+
+	if (ACTIVE())
+		sparc64_kimage_limits_live();
+	else
+		sparc64_kimage_limits_kdump();
+}
+
+static int sparc64_is_linear_mapped(unsigned long vaddr)
+{
+	int rc = 0;
+
+	if  ((vaddr & PAGE_OFFSET) = PAGE_OFFSET)
+		rc = 1;
+	return rc;
+}
+
+static unsigned long pte_to_pa(unsigned long pte)
+{
+	unsigned long paddr = pte & _PAGE_PFN_MASK;
+
+	return paddr;
+}
+
+static unsigned long fetch_page_table_level(unsigned long pte_kva,
+				unsigned long vaddr, unsigned int shift,
+				unsigned int mask, const char *name,
+				int verbose)
+{
+	unsigned int pte_index = (vaddr >> shift) & mask;
+	unsigned long page_table[PTES_PER_PAGE];
+	unsigned long pte = 0UL;
+	int rc;
+
+	rc = readmem(pte_kva, KVADDR, page_table, sizeof(page_table),
+		     (char *)name, RETURN_ON_ERROR);
+	if (!rc)
+		goto out;
+	pte = page_table[pte_index];
+	if (verbose)
+		fprintf(fp,
+			"%s(0x%.16lx) fetch of pte @index[0x%.4x]=0x%.16lx\n",
+			name, pte_kva, pte_index, pte);
+out:
+	return pte;
+}
+
+static unsigned int ptes_per_page_mask(void)
+{
+	return PTES_PER_PAGE_MASK;
+}
+
+static unsigned long pmd_is_huge(unsigned long pmd, unsigned long vaddr,
+							int verbose)
+{
+	unsigned long hpage_mask;
+	unsigned long paddr = 0UL;
+
+	/* We use the pud_shift again to check for uniform versus
+	 * non-uniform page table layout.
+	 */
+	if ((pmd & PAGE_PMD_HUGE) = 0UL)
+		goto out;
+	hpage_mask = ~((1UL << HPAGE_SHIFT) - 1UL);
+	paddr = pte_to_pa(pmd) + (vaddr & ~hpage_mask);
+	if (verbose)
+		fprintf(fp, "Huge Page/THP pmd=0x%.16lx paddr=0x%.16lx\n",
+			pmd, paddr);
+out:
+	return paddr;
+}
+
+static unsigned long sparc64_page_table_walk(unsigned long pgd,
+					unsigned long vaddr, int verbose)
+{
+	struct machine_specific *ms = &sparc64_machine_specific;
+	static const char *pgd_text = "pgd fetch";
+	static const char *pud_text = "pud fetch";
+	static const char *pmd_text = "pmd fetch";
+	static const char *pte_text = "pte fetch";
+	unsigned long kva = pgd;
+	unsigned long paddr;
+	unsigned long pte;
+
+	if (!sparc64_is_linear_mapped(kva))
+		error(FATAL,
+			"sparc64_page_table_walk: pgd must be identity mapped"
+			" but isn't (0xlx).", pgd);
+
+	pte = fetch_page_table_level(kva, vaddr, ms->pgd_shift,
+				     ptes_per_page_mask(), pgd_text, verbose);
+	if (!pte)
+		goto bad;
+	kva = __va(pte);
+	/* For PUD folding skip this step. */
+	if (ms->pud_shift) {
+		pte = fetch_page_table_level(kva, vaddr, ms->pud_shift,
+					     ptes_per_page_mask(), pud_text,
+					     verbose);
+		if (!pte)
+			goto bad;
+	}
+	kva = __va(pte);
+	pte = fetch_page_table_level(kva, vaddr, ms->pmd_shift,
+				     ptes_per_page_mask(), pmd_text, verbose);
+	if (!pte)
+		goto bad;
+	/* Check for a huge/THP page */
+	paddr = pmd_is_huge(pte, vaddr, verbose);
+	if (paddr)
+		goto out;
+	kva = __va(pte);
+	pte = fetch_page_table_level(kva, vaddr, PAGE_SHIFT,
+				     ms->ptes_per_pte - 1, pte_text, verbose);
+	if ((pte & _PAGE_VALID) = 0UL)
+		goto bad;
+	paddr = pte_to_pa(pte);
+	paddr = paddr | (vaddr & ~PAGE_MASK);
+out:
+	return paddr;
+bad:
+	return not_valid_pte;
+}
+
+static void sparc64_init_kernel_pgd(void)
+{
+	int cpu, rc;
+	ulong v;
+
+	v = symbol_value("init_mm");
+	rc = readmem(v + OFFSET(mm_struct_pgd), KVADDR, &v, sizeof(v),
+		"init_mm.pgd", RETURN_ON_ERROR);
+	if (!rc) {
+		error(WARNING, "Can not determine pgd location.\n");
+		goto out;
+	}
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		vt->kernel_pgd[cpu] = v;
+out:
+	return;
+}
+
+static int sparc64_get_smp_cpus(void)
+{
+	int ncpu = MAX(get_cpus_online(), get_highest_cpu_online() + 1);
+
+	return ncpu;
+}
+
+static void sparc64_init_level4(void)
+{
+	struct machine_specific *machspec = &sparc64_machine_specific;
+
+	machspec->userspace_top = PG_LVL4_SPARC64_USERSPACE_TOP;
+	machspec->pgd_shift = PG_LVL4_PGDIR_SHIFT;
+	machspec->pud_shift = PG_LVL4_PUD_SHIFT;
+	machspec->pmd_shift = PG_LVL4_PMD_SHIFT;
+	machspec->ptes_per_pte = PG_LVL4_PTRS_PER_PTE;
+	machdep->max_physmem_bits = _MAX_PHYSMEM_BITS_LVL4;
+}
+
+static ulong sparc64_vmalloc_start(void)
+{
+	return machdep->machspec->vmalloc_start;
+}
+
+int sparc64_IS_VMALLOC_ADDR(ulong vaddr)
+{
+	int ret = (vaddr >= machdep->machspec->vmalloc_start &&
+		vaddr < machdep->machspec->vmalloc_end);
+
+	return ret;
+}
+
+static void pt_clear_cache(void)
+{
+	machdep->last_pgd_read = 0UL;
+	machdep->last_pud_read = 0UL;
+	machdep->last_pmd_read = 0UL;
+	machdep->last_ptbl_read = 0UL;
+}
+
+static void pt_level_alloc(char **lvl, char *name)
+{
+	size_t sz = page_size();
+	void *pointer = malloc(sz);
+
+	if (!pointer)
+		error(FATAL, name);
+	*lvl = pointer;
+}
+
+static int sparc64_verify_symbol(const char *name, unsigned long value,
+		char type)
+{
+	return true;
+}
+
+static int sparc64_verify_line_number(unsigned long pc, unsigned long low,
+		unsigned long high)
+{
+	return true;
+}
+
+static int sparc64_dis_filter(ulong vaddr, char *inbuf, unsigned int radix)
+{
+		return false;
+}
+
+static int sparc64_eframe_search(struct bt_info *bt)
+{
+	struct {struct sparc_stackf sf; struct pt_regs pr; }
+		exception_frame_data;
+	unsigned long exception_frame = bt->stacktop;
+	unsigned long first_frame;
+	struct reg_window one_down;
+	int rc;
+
+	exception_frame = exception_frame - TRACEREG_SZ - STACKFRAME_SZ;
+	rc = readmem(exception_frame, KVADDR, &exception_frame_data,
+		sizeof(exception_frame_data), "EF fetch.", RETURN_ON_ERROR);
+	if (!rc)
+		goto out;
+	if (exception_frame_data.pr.magic != 0x57ac6c00)
+		goto out;
+	first_frame = exception_frame - sizeof(struct reg_window);
+
+	rc = readmem(first_frame, KVADDR, &one_down, sizeof(struct reg_window),
+		"Stack fetch.", RETURN_ON_ERROR);
+	if (!rc)
+		goto out;
+	/* Extra arguments. */
+	first_frame = first_frame - (6 * 8);
+
+	rc = readmem(first_frame, KVADDR, &one_down, sizeof(struct reg_window),
+		"Stack fetch.", RETURN_ON_ERROR);
+	if (!rc)
+		goto out;
+out:
+	return rc;
+}
+
+/* Need to handle hardirq and softirq stacks. */
+static int kstack_valid(struct bt_info *bt, unsigned long sp)
+{
+	unsigned long thread_info = SIZE(thread_info);
+	unsigned long base = bt->stackbase + thread_info;
+	unsigned long top = bt->stacktop - sizeof(struct sparc_stackf) -
+		sizeof(struct pt_regs);
+	int rc = false;
+
+	if (sp & (16U - 1))
+		goto out;
+
+	if ((sp >= base) && (sp <= top))
+		rc = true;
+out:
+	return rc;
+}
+
+static void sparc64_print_eframe(struct bt_info *bt, unsigned long stack_top)
+{
+	struct {struct sparc_stackf sf; struct pt_regs pr; } k_entry;
+	struct pt_regs *regs = &k_entry.pr;
+	unsigned long efp;
+	unsigned int tt;
+	int rc;
+	struct reg_window window;
+	unsigned long rw;
+
+	efp = bt->stkptr + STACK_BIAS - TRACEREG_SZ - STACKFRAME_SZ;
+	rc = readmem(efp, KVADDR, &k_entry, sizeof(k_entry),
+		     "Stack frame and pt_regs.", RETURN_ON_ERROR);
+	if (!rc)
+		goto out;
+	if ((regs->magic & ~MAGIC_TT) != PT_REGS_MAGIC) {
+		efp = stack_top - (sizeof(struct pt_regs) +
+			sizeof(struct sparc_stackf));
+		rc = readmem(efp, KVADDR, &k_entry, sizeof(k_entry),
+			"Stack frame and pt_regs.", RETURN_ON_ERROR);
+		if (!rc)
+			goto out;
+		/* Kernel thread or not in kernel any longer? */
+		if ((regs->magic & ~MAGIC_TT) != PT_REGS_MAGIC)
+			goto out;
+	}
+	tt = regs->magic & MAGIC_TT;
+	fprintf(fp, "TSTATE=0x%lx TT=0x%x TPC=0x%lx TNPC=0x%lx\n",
+		regs->tstate, tt, regs->tpc, regs->tnpc);
+	fprintf(fp, " g0=0x%.16lx  g1=0x%.16lx  g2=0x%.16lx\n",
+		regs->u_regs[0],
+		regs->u_regs[1],
+		regs->u_regs[2]);
+	fprintf(fp, " g3=0x%.16lx  g4=0x%.16lx  g5=0x%.16lx\n",
+		regs->u_regs[3],
+		regs->u_regs[4],
+		regs->u_regs[5]);
+#define	___INS	(8)
+	fprintf(fp, " g6=0x%.16lx  g7=0x%.16lx\n",
+		regs->u_regs[6],
+		regs->u_regs[7]);
+	fprintf(fp, " o0=0x%.16lx  o1=0x%.16lx  o2=0x%.16lx\n",
+		regs->u_regs[___INS+0],
+		regs->u_regs[___INS+1],
+		regs->u_regs[___INS+2]);
+	fprintf(fp, " o3=0x%.16lx  o4=0x%.16lx  o5=0x%.16lx\n",
+		regs->u_regs[___INS+3],
+		regs->u_regs[___INS+4],
+		regs->u_regs[___INS+5]);
+	fprintf(fp, " sp=0x%.16lx  ret_pc=0x%.16lx\n",
+		regs->u_regs[___INS+6],
+		regs->u_regs[___INS+7]);
+#undef	___INS
+	rw = bt->stkptr + STACK_BIAS;
+	if (!kstack_valid(bt, rw))
+		goto out;
+	rc = readmem(rw, KVADDR, &window, sizeof(window),
+		     "Register window.", RETURN_ON_ERROR);
+	if (!rc)
+		goto out;
+	fprintf(fp, " l0=0x%.16lx  l1=0x%.16lx  l2=0x%.16lx\n",
+		window.locals[0], window.locals[1], window.locals[2]);
+	fprintf(fp, " l3=0x%.16lx  l4=0x%.16lx  l5=0x%.16lx\n",
+		window.locals[3], window.locals[4], window.locals[5]);
+	fprintf(fp, " l6=0x%.16lx  l7=0x%.16lx\n",
+		window.locals[6], window.locals[7]);
+	fprintf(fp, " i0=0x%.16lx  i1=0x%.16lx  i2=0x%.16lx\n",
+		window.ins[0], window.ins[1], window.ins[2]);
+	fprintf(fp, " i3=0x%.16lx  i4=0x%.16lx  i5=0x%.16lx\n",
+		window.ins[3], window.ins[4], window.ins[5]);
+	fprintf(fp, " i6=0x%.16lx  i7=0x%.16lx\n",
+		window.ins[6], window.ins[7]);
+out:
+	return;
+}
+
+static void sparc64_print_frame(struct bt_info *bt, int cnt, unsigned long ip,
+						unsigned long ksp)
+{
+	char *symbol = closest_symbol(ip);
+
+	fprintf(fp, "#%d [%lx] %s at %lx\n", cnt, ksp, symbol, ip);
+
+	if (bt->flags & BT_LINE_NUMBERS) {
+		char buf[BUFSIZE];
+
+		get_line_number(ip, buf, false);
+		if (strlen(buf))
+			fprintf(fp, "\t%s\n", buf);
+	}
+}
+
+static void sparc64_back_trace(struct bt_info *bt)
+{
+	unsigned long stack_top = bt->stacktop;
+	unsigned long ip = bt->instptr;
+	unsigned long ksp = bt->stkptr;
+	struct reg_window window;
+	int cnt = 0;
+	int rc;
+
+	do {
+		if (!kstack_valid(bt, ksp + STACK_BIAS))
+			break;
+		rc = readmem(ksp + STACK_BIAS, KVADDR, &window, sizeof(window),
+			"KSP window fetch.", RETURN_ON_ERROR);
+		if (!rc)
+			goto out;
+		sparc64_print_frame(bt, cnt, ip, ksp);
+		ksp = window.ins[6];
+		ip = window.ins[7];
+		cnt++;
+	} while (cnt != 50);
+	sparc64_print_eframe(bt, stack_top);
+out:
+	return;
+}
+
+static ulong sparc64_processor_speed(void)
+{
+	int cpu;
+	unsigned long clock_tick;
+	struct syment *sp;
+
+	if (!MEMBER_EXISTS("cpuinfo_sparc", "clock_tick")) {
+		error(WARNING, "sparc64 expects clock_tick\n");
+		return 0UL;
+	}
+
+	sp = per_cpu_symbol_search("__cpu_data");
+	if (!sp)
+		return 0UL;
+	for (cpu = 0; cpu < kt->cpus; cpu++) {
+		if (!in_cpu_map(ONLINE, cpu))
+			continue;
+		if (!readmem(sp->value + kt->__per_cpu_offset[cpu] +
+			     MEMBER_OFFSET("cpuinfo_sparc", "clock_tick"),
+			     KVADDR, &clock_tick, sizeof(clock_tick),
+			     "clock_tick", QUIET|RETURN_ON_ERROR))
+			continue;
+		return clock_tick/1000000;
+	}
+	return 0UL;
+}
+
+static ulong sparc64_get_task_pgd(ulong task)
+{
+	struct task_context *tc = task_to_context(task);
+	ulong pgd = NO_TASK;
+
+	if (!tc)
+		goto out;
+	readmem(tc->mm_struct + OFFSET(mm_struct_pgd), KVADDR,
+		&pgd, sizeof(unsigned long), "User pgd.", RETURN_ON_ERROR);
+out:
+	return pgd;
+}
+
+static int sparc64_uvtop(struct task_context *tc, ulong va, physaddr_t *ppaddr,
+						int verbose)
+{
+	unsigned long pgd = sparc64_get_task_pgd(tc->task);
+	unsigned long paddr;
+	int rc = false;
+
+	if (pgd = NO_TASK)
+		goto out;
+	paddr = sparc64_page_table_walk(pgd, va, verbose);
+	/* For now not_valid_pte skips checking for swap pte. */
+	if (paddr = not_valid_pte) {
+		*ppaddr = 0UL;
+		goto out;
+	}
+	*ppaddr = paddr;
+	rc = true;
+out:
+	return rc;
+}
+
+static unsigned long sparc64_vmalloc_translate(unsigned long vaddr, int verbose)
+{
+	unsigned long paddr = sparc64_page_table_walk(vt->kernel_pgd[0],
+							vaddr, verbose);
+
+	return paddr;
+}
+
+static unsigned long sparc64_linear_translate(unsigned long vaddr)
+{
+	unsigned long paddr = __pa(vaddr);
+
+	if (sparc64_verify_paddr(paddr) = false)
+		error(FATAL,
+			"sparc64_linear_translate: This physical address"
+			" (0x%lx) is invalid.", paddr);
+
+	return paddr;
+}
+
+static int sparc64_is_vmalloc_mapped(unsigned long vaddr)
+{
+	struct machine_specific *ms = &sparc64_machine_specific;
+	int rc = 0;
+
+	/* We exclude OBP range whose TTEs were captured by kernel in
+	 * early boot. It is possible to fetch these but for what purpose?
+	 */
+	if ((vaddr >= ms->modules_vaddr && vaddr < ms->modules_end) ||
+		(vaddr >= ms->vmalloc_start && vaddr < ms->vmalloc_end))
+		rc = 1;
+	return rc;
+}
+
+static int sparc64_is_kvaddr(ulong vaddr)
+{
+	int rc = kimage_va_range(vaddr);
+
+	if (rc)
+		goto out;
+	rc = sparc64_is_linear_mapped(vaddr);
+	if (rc)
+		goto out;
+	rc = sparc64_is_vmalloc_mapped(vaddr);
+out:
+	return rc;
+}
+
+static int sparc64_kvtop(struct task_context *tc, ulong vaddr,
+					physaddr_t *paddr, int verbose)
+{
+	unsigned long phys_addr;
+	int rc = false;
+
+	if (kimage_va_range(vaddr))
+		phys_addr = kimage_va_translate(vaddr);
+	else if (sparc64_is_vmalloc_mapped(vaddr)) {
+		phys_addr = sparc64_vmalloc_translate(vaddr, verbose);
+		if (phys_addr = not_valid_pte)
+			goto out;
+	} else if (sparc64_is_linear_mapped(vaddr))
+		phys_addr = sparc64_linear_translate(vaddr);
+	else {
+		error(WARNING,
+		"This is an invalid kernel virtual address=0x%lx.",
+			vaddr);
+		goto out;
+	}
+
+	*paddr = phys_addr;
+	rc = true;
+out:
+	return rc;
+}
+
+static int sparc64_is_task_addr(ulong task)
+{
+	int rc = false;
+	int cpu;
+
+	if (sparc64_is_linear_mapped(task) || kimage_va_range(task))
+		rc = true;
+	else {
+		for (cpu = 0; cpu < kt->cpus; cpu++)
+			if (task = tt->idle_threads[cpu]) {
+				rc = true;
+				break;
+			}
+	}
+	return rc;
+}
+
+static int sparc64_is_uvaddr(ulong vaddr, struct task_context *tc)
+{
+	struct machine_specific *ms = &sparc64_machine_specific;
+	int rc = false;
+
+	if (vaddr < ms->userspace_top)
+		rc = true;
+	return rc;
+}
+
+static const char *pte_page_size(unsigned long pte)
+{
+	static const char *_4Mb = "4Mb";
+	static const char *_64Kb = "64Kb";
+	static const char *_8Kb = "8Kb";
+	static const char *_ns = "Not Supported";
+	const char *result;
+
+	switch (pte & _PAGE_SZALL_4V) {
+	case _PAGE_SZ8K_4V:
+		result = _8Kb;
+		break;
+	case _PAGE_SZ64K_4V:
+		result = _64Kb;
+		break;
+	case _PAGE_SZ4MB_4V:
+		result = _4Mb;
+		break;
+	default:
+		result = _ns;
+	}
+	return result;
+}
+
+static int sparc64_translate_pte(unsigned long pte, void *physaddr,
+							ulonglong unused)
+{
+	unsigned long paddr = pte_to_pa(pte);
+	int rc = false;
+	int cnt = 0;
+
+	/* Once again not handling swap pte.*/
+	if ((pte & _PAGE_VALID) = 0UL)
+		goto out;
+	if (pte & _PAGE_NFO_4V)
+		fprintf(fp, "%sNoFaultOn", cnt++ ? "|" : "");
+	if (pte & _PAGE_MODIFIED_4V)
+		fprintf(fp, "%sModified", cnt++ ? "|" : "");
+	if (pte & _PAGE_ACCESSED_4V)
+		fprintf(fp, "%sAccessed", cnt++ ? "|" : "");
+	if (pte & _PAGE_READ_4V)
+		fprintf(fp, "%sReadSoftware", cnt++ ? "|" : "");
+	if (pte & _PAGE_WRITE_4V)
+		fprintf(fp, "%sWriteSoftware", cnt++ ? "|" : "");
+	if (pte & _PAGE_P_4V)
+		fprintf(fp, "%sPriv", cnt++ ? "|" : "");
+	if (pte & _PAGE_EXEC_4V)
+		fprintf(fp, "%sExecute", cnt++ ? "|" : "");
+	if (pte & _PAGE_W_4V)
+		fprintf(fp, "%sWritable", cnt++ ? "|" : "");
+	if (pte & _PAGE_PRESENT_4V)
+		fprintf(fp, "%sPresent", cnt++ ? "|" : "");
+	fprintf(fp, "|PageSize(%s)\n", pte_page_size(pte));
+	if (physaddr)
+		*(unsigned long *)physaddr = paddr;
+	rc = true;
+out:
+	return rc;
+}
+
+static void sparc64_get_frame(struct bt_info *bt, unsigned long *r14,
+					unsigned long *r15)
+{
+	unsigned long ksp_offset = sparc64_ksp_offset + bt->tc->thread_info;
+	unsigned long ksp;
+	int rc;
+
+	/* We need thread_info's ksp. This is the stack for sleeping threads
+	 * and captured during switch_to. The rest is fetchable from there.
+	 */
+	rc = readmem(ksp_offset, KVADDR, &ksp, sizeof(ksp), "KSP Fetch.",
+		RETURN_ON_ERROR);
+	if (!rc)
+		goto out;
+	*r14 = ksp;
+	*r15 = symbol_value("switch_to_pc");
+out:
+	return;
+}
+
+static void sparc64_get_dumpfile_stack_frame(struct bt_info *bt,
+					unsigned long *psp, unsigned long *ppc)
+{
+	unsigned long *pt_regs;
+
+	pt_regs = (unsigned long *)bt->machdep;
+
+	if (!pt_regs)
+		fprintf(fp, "0%lx: registers not saved\n", bt->task);
+
+	/* pt_regs can be unaligned */
+	BCOPY(&pt_regs[30], psp, sizeof(ulong));
+	BCOPY(&pt_regs[33], ppc, sizeof(ulong));
+}
+
+static void sparc64_get_stack_frame(struct bt_info *bt, unsigned long *pcp,
+						unsigned long *psp)
+{
+	unsigned long r14, r15;
+
+	if (DUMPFILE() && is_task_active(bt->task))
+		sparc64_get_dumpfile_stack_frame(bt, &r14, &r15);
+	else
+		sparc64_get_frame(bt, &r14, &r15);
+	if (pcp)
+		*pcp = r15;
+	if (psp)
+		*psp = r14;
+}
+
+static int sparc64_get_kvaddr_ranges(struct vaddr_range *vrp)
+{
+	struct machine_specific *ms = machdep->machspec;
+
+	vrp[0].type = KVADDR_UNITY_MAP;
+	vrp[0].start = ms->page_offset;
+	vrp[0].end = ~0ULL;
+	vrp[1].type = KVADDR_VMALLOC;
+	vrp[1].start = ms->vmalloc_start;
+	vrp[1].end = ms->vmalloc_end;
+	vrp[2].type = KVADDR_START_MAP;
+	vrp[2].start = symbol_value("_start");
+	vrp[2].end = symbol_value("_end");
+	vrp[3].type = KVADDR_MODULES;
+	vrp[3].start = ms->modules_vaddr;
+	vrp[3].end = ms->modules_end;
+	return 4;
+}
+
+static void sparc64_get_crash_notes(void)
+{
+	unsigned long *notes_ptrs, size, crash_notes_address;
+	int ret;
+
+	if (!symbol_exists("crash_notes")) {
+		error(WARNING, "Could not retrieve crash_notes.");
+		goto out;
+	}
+
+	crash_notes_address = symbol_value("crash_notes");
+	size = kt->cpus * sizeof(notes_ptrs[0]);
+	notes_ptrs = (unsigned long *) GETBUF(size);
+	ret = readmem(crash_notes_address, KVADDR, notes_ptrs, size,
+		"crash_notes", RETURN_ON_ERROR);
+	if (!ret)
+		goto out2;
+out2:
+	FREEBUF(notes_ptrs);
+out:
+	return;
+}
+
+static void sparc64_init_kstack_info(void)
+{
+	sparc64_ksp_offset = MEMBER_OFFSET("thread_info", "ksp");
+}
+
+static void sparc64_init_irq_stacks(void)
+{
+	void *irq_stack;
+	unsigned long stack_size;
+
+	stack_size = get_array_length("hardirq_stack", NULL, 0) *
+		     sizeof(unsigned long);
+	irq_stack = malloc(stack_size);
+	if (!irq_stack)
+		error(FATAL, "malloc failure in sparc64_init_irq_stacks");
+
+	get_symbol_data("hardirq_stack", stack_size, irq_stack);
+	tt->hardirq_ctx = irq_stack;
+
+	stack_size = get_array_length("softirq_stack", NULL, 0) *
+		     sizeof(unsigned long);
+	irq_stack = malloc(stack_size);
+	if (!irq_stack)
+		error(FATAL, "malloc failure in sparc64_init_irq_stacks");
+
+	get_symbol_data("softirq_stack", stack_size, irq_stack);
+	tt->softirq_ctx = irq_stack;
+}
+
+static void sparc64_init_vmemmap_info(void)
+{
+	struct machine_specific *ms = &sparc64_machine_specific;
+	unsigned long page_struct_size = STRUCT_SIZE("page");
+
+	/*
+	 * vmemmap memory is addressed as vmalloc memory, so we
+	 * treat it as an etension of the latter.
+	 */
+	ms->vmalloc_end ++		((1UL << (machdep->max_physmem_bits - PAGE_SHIFT)) *
+		 page_struct_size);
+}
+
+static void sparc64_init_cpu_info(void)
+{
+	unsigned long trap_block, per_cpu_base_offset, per_cpu_base;
+	unsigned long trap_per_cpu;
+	int cpu;
+
+	if (!symbol_exists("trap_block"))
+		error(FATAL, "sparc64 requires trap_block symbol.\n");
+
+	trap_block = symbol_value("trap_block");
+	if (!MEMBER_EXISTS("trap_per_cpu", "__per_cpu_base"))
+		error(FATAL, "sparc64 requires __per_cpu_base.\n");
+	trap_per_cpu = STRUCT_SIZE("trap_per_cpu");
+	per_cpu_base_offset = MEMBER_OFFSET("trap_per_cpu", "__per_cpu_base");
+	for (cpu = 0; cpu < NR_CPUS; cpu++,
+		trap_block = trap_block + trap_per_cpu) {
+
+		if (!in_cpu_map(POSSIBLE, cpu))
+			continue;
+		readmem(trap_block + per_cpu_base_offset, KVADDR,
+			&per_cpu_base, sizeof(per_cpu_base),
+			"sparc64: per_cpu_base", FAULT_ON_ERROR);
+		kt->__per_cpu_offset[cpu] = per_cpu_base;
+	}
+}
+
+void sparc64_init(int when)
+{
+	struct machine_specific *ms = &sparc64_machine_specific;
+
+	switch (when) {
+	case SETUP_ENV:
+		machdep->process_elf_notes = process_elf64_notes;
+		break;
+	case PRE_SYMTAB:
+		machdep->machspec = ms;
+		machdep->verify_paddr = sparc64_verify_paddr;
+		machdep->verify_symbol = sparc64_verify_symbol;
+		machdep->verify_line_number = sparc64_verify_line_number;
+
+		if (pc->flags & KERNEL_DEBUG_QUERY)
+			return;
+		machdep->flags |= MACHDEP_BT_TEXT;
+		if (machdep->cmdline_args[0])
+			sparc64_parse_cmdline_args();
+		break;
+
+	case PRE_GDB:
+		sparc64_init_level4();
+
+		machdep->pagesize = memory_page_size();
+		machdep->pageshift = ffs(machdep->pagesize) - 1;
+		machdep->pageoffset = machdep->pagesize - 1;
+		machdep->pagemask = ~((ulonglong) machdep->pageoffset);
+		machdep->stacksize = machdep->pagesize * 2;
+
+		machdep->eframe_search = sparc64_eframe_search;
+		machdep->back_trace = sparc64_back_trace;
+		machdep->processor_speed = sparc64_processor_speed;
+
+		machdep->uvtop = sparc64_uvtop;
+		machdep->kvtop = sparc64_kvtop;
+		machdep->get_task_pgd = sparc64_get_task_pgd;
+
+		machdep->dump_irq = generic_dump_irq;
+
+		machdep->get_stack_frame = sparc64_get_stack_frame;
+		machdep->get_stackbase = generic_get_stackbase;
+		machdep->get_stacktop = generic_get_stacktop;
+		machdep->translate_pte = sparc64_translate_pte;
+		machdep->memory_size = generic_memory_size;
+
+		machdep->vmalloc_start = sparc64_vmalloc_start;
+		machdep->is_task_addr = sparc64_is_task_addr;
+		machdep->is_kvaddr = sparc64_is_kvaddr;
+		machdep->is_uvaddr = sparc64_is_uvaddr;
+		machdep->dis_filter = sparc64_dis_filter;
+		machdep->get_smp_cpus = sparc64_get_smp_cpus;
+		machdep->clear_machdep_cache = sparc64_clear_machdep_cache;
+		machdep->get_kvaddr_ranges = sparc64_get_kvaddr_ranges;
+		machdep->cmd_mach = sparc64_cmd_mach;
+		machdep->init_kernel_pgd = sparc64_init_kernel_pgd;
+		machdep->value_to_symbol = generic_machdep_value_to_symbol;
+		machdep->show_interrupts = generic_show_interrupts;
+
+		pt_level_alloc(&machdep->pgd, "Can't malloc pgd space.");
+		pt_level_alloc(&machdep->pud, "Can't malloc pud space.");
+		pt_level_alloc(&machdep->pmd, "Can't malloc pmd space.");
+		pt_level_alloc(&machdep->ptbl, "Can't malloc ptbl space.");
+		pt_clear_cache();
+		sparc64_phys_base();
+		sparc64_kimage_limits();
+		break;
+
+	case POST_GDB:
+		get_symbol_data("PAGE_OFFSET", sizeof(unsigned long),
+				&machdep->machspec->page_offset);
+		machdep->kvbase = symbol_value("_stext");
+		machdep->identity_map_base = (ulong) PAGE_OFFSET;
+		machdep->ptrs_per_pgd = PTRS_PER_PGD;
+		ms->modules_vaddr = SPARC64_MODULES_VADDR;
+		ms->modules_end = SPARC64_MODULES_END;
+		ms->vmalloc_start = SPARC64_VMALLOC_START;
+		get_symbol_data("VMALLOC_END", sizeof(unsigned long),
+				&ms->vmalloc_end);
+		machdep->section_size_bits = _SECTION_SIZE_BITS;
+		if (kernel_symbol_exists("nr_irqs"))
+			get_symbol_data("nr_irqs", sizeof(unsigned int),
+			&machdep->nr_irqs);
+		sparc64_init_vmemmap_info();
+		sparc64_init_cpu_info();
+		sparc64_init_kstack_info();
+		sparc64_init_irq_stacks();
+		break;
+	case POST_VM:
+		if (!ACTIVE())
+			sparc64_get_crash_notes();
+		break;
+	case POST_INIT:
+		break;
+
+	case LOG_ONLY:
+		machdep->machspec = &sparc64_machine_specific;
+		machdep->kvbase = kt->vmcoreinfo._stext_SYMBOL;
+		break;
+	}
+}
+
+void sparc64_dump_machdep_table(ulong unused)
+{
+}
+
+#endif /* SPARC64 */
diff --git a/symbols.c b/symbols.c
index 51d41d8..75a2194 100644
--- a/symbols.c
+++ b/symbols.c
@@ -3331,6 +3331,11 @@ is_kernel(char *file)
 				goto bailout;
 			break;
 
+		case EM_SPARCV9:
+			if (machine_type_mismatch(file, "SPARC64", NULL, 0))
+				goto bailout;
+			break;
+
 		default:
 			if (machine_type_mismatch(file, "(unknown)", NULL, 0))
 				goto bailout;
@@ -3558,6 +3563,11 @@ is_shared_object(char *file)
 			if (machine_type("ARM64"))
 				return TRUE;
 			break;
+
+		case EM_SPARCV9:
+			if (machine_type("SPARC64"))
+				return TRUE;
+			break;
 		}
 
 		if (CRASHDEBUG(1))
diff --git a/task.c b/task.c
index 7b01951..f21d0f8 100644
--- a/task.c
+++ b/task.c
@@ -249,6 +249,7 @@ task_init(void)
 	MEMBER_OFFSET_INIT(task_struct_active_mm, "task_struct", "active_mm");
 	MEMBER_OFFSET_INIT(task_struct_next_run, "task_struct", "next_run");
 	MEMBER_OFFSET_INIT(task_struct_flags, "task_struct", "flags");
+	MEMBER_SIZE_INIT(task_struct_flags, "task_struct", "flags");
         MEMBER_OFFSET_INIT(task_struct_pidhash_next,
                 "task_struct", "pidhash_next");
 	MEMBER_OFFSET_INIT(task_struct_pgrp, "task_struct", "pgrp");
@@ -2368,7 +2369,11 @@ store_context(struct task_context *tc, ulong task, char *tp)
 
         tc->pid = (ulong)(*pid_addr);
 	strlcpy(tc->comm, comm_addr, TASK_COMM_LEN); 
-        tc->processor = *processor_addr;
+#ifdef SPARC64
+	tc->processor = *(unsigned short *)processor_addr;
+#else
+	tc->processor = *processor_addr;
+#endif
         tc->ptask = *parent_addr;
         tc->mm_struct = *mm_addr;
         tc->task = task;
@@ -5266,8 +5271,15 @@ task_flags(ulong task)
 
 	fill_task_struct(task);
 
-	flags = tt->last_task_read ?
-		 ULONG(tt->task_struct + OFFSET(task_struct_flags)) : 0;
+	if (tt->last_task_read) {
+		if (SIZE(task_struct_flags) = sizeof(unsigned int))
+			flags = UINT(tt->task_struct +
+				     OFFSET(task_struct_flags));
+		else
+			flags = ULONG(tt->task_struct +
+				      OFFSET(task_struct_flags));
+	} else
+		flags = 0;
 
 	return flags;
 }
@@ -7279,6 +7291,11 @@ get_idle_threads(ulong *tasklist, int nr_cpus)
 	    VALID_MEMBER(runqueue_idle)) {
 		runqbuf = GETBUF(SIZE(runqueue));
 		for (i = 0; i < nr_cpus; i++) {
+#ifdef SPARC64
+			if (cpu_map_addr("possible") &&
+			    !(in_cpu_map(POSSIBLE, i)))
+				continue;
+#endif
 			if ((kt->flags & SMP) && (kt->flags & PER_CPU_OFF))
 				runq = rq_sp->value + kt->__per_cpu_offset[i];
 			else
-- 
1.7.1

