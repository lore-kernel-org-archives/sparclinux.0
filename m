From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Sun, 15 Jan 2017 21:12:15 +0000
Subject: [PATCH v4 6/6] tools: add userspace linker table sandbox
Message-Id: <20170115211215.17216-7-mcgrof@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170109150249.11667-1-mcgrof@kernel.org>
 <20170115211215.17216-1-mcgrof@kernel.org>
In-Reply-To: <20170115211215.17216-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bp@alien8.de, bp@suse.de, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel

Add a userspace sandbox to allow easy experimentation and
test extensions with linker tables, section ranges and the
new section core definitions.

The userspace sandbox tries to mimic the Linux kernel development
flow as much as possible, it however relies on and uses libc. Support
is currently only provided to x86_64.

Demo run:

cd tools/linker-tables
make clean; make;
./demo
Initializing x86 bare metal world
x86-init: Number of init entries: 8
Initializing memory ...
Completed initializing memory !
Initializing pci ...
PCI fixup size: 1
Demo: Using LINKTABLE_FOR_EACH
foo_fixup
Demo: Using LINKTABLE_RUN_ALL
foo_fixup
Completed initializing pci !
Number of init entries: 1
Initializing kprobes ...
= OK: test_kprobe_0001 within range!
= OK: test_kprobe_0002 not in range as expected!
Completed initializing kprobes !
Initializing kasan ...
Early init for Kasan...
Completed initializing kasan !
Initializing beta ...
Completed initializing beta !
Initializing alpha ...
Completed initializing alpha !
Booting bare metal
Calling start_kernel()...
ACME: Initializing ...
ACME: Finished init ... !
Synthetics: synth_init_or(2) returns: 0xDEADBEEF
Synthetics: ps_shr(0xDEADBEEF, get_demo_shr) returns: 0x0000DEAD

v7: address ./scripts/checkpatch.pl --codespell complaints

v6: rename table macros as suggested by Andy Shevchenko

v5:

o Use ..rng.* instead of .rng.* as suggested by Nicholas Piggin.
  This is the typical way to avoid clashes with compiler generated
  sections.

o moves tools/include/linux/printk.h to tools
  linker-table/include/linux/printk.h -- we cannot generalize this
  just yet, more work is needed in terms of providing a namespace for
  headers for types of ports of kernel functionality to userspace.

o Adjust code according to the latest discussions for the linker
  tables API (section name macros are now gone).

o Give CONFIG_HAVE_ARCH_PS_CONST for x86 another good 'ol college try,
  still fails, but this is just a demo anyway. We can amend and fix
  make this more optimized for x86 later. Thanks Boris!

v4: this patch is new in this series -- added to the kenrel as
    suggested by Boris, as otherwise it'd be really hard to keep
    an external userspace repository in sync.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/sections/linker-tables.rst           |   4 +-
 MAINTAINERS                                        |   1 +
 include/linux/tables.h                             |   5 +-
 tools/Makefile                                     |   3 +-
 .../arch/x86/include/generated/asm/section-core.h  |   1 +
 tools/arch/x86/include/generated/ranges.h          |   1 +
 tools/arch/x86/include/generated/tables.h          |   1 +
 tools/include/asm-generic/ranges.h                 |  93 +++
 tools/include/asm-generic/section-core.h           | 348 +++++++++++
 tools/include/asm-generic/tables.h                 |  48 ++
 tools/include/linux/ranges.h                       | 183 ++++++
 tools/include/linux/sections.h                     |  87 +++
 tools/include/linux/string.h                       |   1 +
 tools/include/linux/tables.h                       | 684 +++++++++++++++++++++
 tools/linker-tables/.gitignore                     |   2 +
 tools/linker-tables/Makefile                       | 184 ++++++
 tools/linker-tables/README                         | 114 ++++
 tools/linker-tables/arch/x86/include/asm/asm.h     |  17 +
 tools/linker-tables/arch/x86/include/asm/boot.h    |   1 +
 .../linker-tables/arch/x86/include/asm/bootparam.h |  32 +
 tools/linker-tables/arch/x86/include/asm/kprobes.h |   7 +
 .../linker-tables/arch/x86/include/asm/ps_const.h  |  23 +
 tools/linker-tables/arch/x86/include/asm/ranges.h  |   6 +
 .../arch/x86/include/asm/section-core.h            |   1 +
 tools/linker-tables/arch/x86/include/asm/setup.h   |   6 +
 tools/linker-tables/arch/x86/include/asm/tables.h  |   6 +
 tools/linker-tables/arch/x86/include/asm/x86.h     |   4 +
 .../arch/x86/include/asm/x86_init_fn.h             | 169 +++++
 tools/linker-tables/arch/x86/kernel/alpha.c        |  10 +
 tools/linker-tables/arch/x86/kernel/alternative.c  |  31 +
 tools/linker-tables/arch/x86/kernel/beta.c         |  10 +
 tools/linker-tables/arch/x86/kernel/head64.c       |  58 ++
 tools/linker-tables/arch/x86/kernel/init.c         |  42 ++
 tools/linker-tables/arch/x86/kernel/kasan.c        |  11 +
 tools/linker-tables/arch/x86/kernel/kprobes.c      |  51 ++
 tools/linker-tables/arch/x86/kernel/vmlinux.lds.S  | 277 +++++++++
 tools/linker-tables/arch/x86/mm/init.c             |  11 +
 tools/linker-tables/arch/x86/xen/init.c            |  13 +
 tools/linker-tables/drivers/acme.c                 |  33 +
 tools/linker-tables/drivers/synth/common.c         |  16 +
 tools/linker-tables/drivers/synth/common.h         |   2 +
 tools/linker-tables/drivers/synth/main.c           |  36 ++
 tools/linker-tables/drivers/synth/or.S             |  39 ++
 tools/linker-tables/drivers/synth/synth.h          |   2 +
 tools/linker-tables/drivers/xen-driver.c           |  12 +
 .../include/asm-generic/arch_init_fn.h             |  50 ++
 tools/linker-tables/include/asm-generic/kprobes.h  |  26 +
 tools/linker-tables/include/linux/bitops.h         |   6 +
 tools/linker-tables/include/linux/init.h           |  40 ++
 tools/linker-tables/include/linux/kasan.h          |   5 +
 tools/linker-tables/include/linux/kernel.h         |   2 +
 tools/linker-tables/include/linux/kprobes.h        |  11 +
 tools/linker-tables/include/linux/module.h         |  14 +
 tools/linker-tables/include/linux/mutex.h          |  17 +
 tools/linker-tables/include/linux/pci.h            |   7 +
 tools/linker-tables/include/linux/printk.h         |  26 +
 tools/linker-tables/include/linux/ps_const.h       |  46 ++
 tools/linker-tables/include/linux/sched.h          |   9 +
 tools/linker-tables/include/linux/spinlock.h       |  13 +
 tools/linker-tables/include/linux/start_kernel.h   |   1 +
 tools/linker-tables/include/linux/types.h          |  13 +
 tools/linker-tables/include/linux/workqueue.h      |  51 ++
 tools/linker-tables/include/xen/xen.h              |   4 +
 tools/linker-tables/kernel/locking/mutex.c         |  28 +
 tools/linker-tables/kernel/locking/spinlock.c      |  26 +
 tools/linker-tables/kernel/main.c                  |  32 +
 tools/linker-tables/kernel/workqueue.c             |  43 ++
 tools/linker-tables/lib/string.c                   |  26 +
 tools/linker-tables/main.c                         |  20 +
 tools/linker-tables/pci-quirks.c                   |  14 +
 tools/linker-tables/pci.c                          |  30 +
 71 files changed, 3241 insertions(+), 5 deletions(-)
 create mode 100644 tools/arch/x86/include/generated/asm/section-core.h
 create mode 100644 tools/arch/x86/include/generated/ranges.h
 create mode 100644 tools/arch/x86/include/generated/tables.h
 create mode 100644 tools/include/asm-generic/ranges.h
 create mode 100644 tools/include/asm-generic/section-core.h
 create mode 100644 tools/include/asm-generic/tables.h
 create mode 100644 tools/include/linux/ranges.h
 create mode 100644 tools/include/linux/sections.h
 create mode 100644 tools/include/linux/tables.h
 create mode 100644 tools/linker-tables/.gitignore
 create mode 100644 tools/linker-tables/Makefile
 create mode 100644 tools/linker-tables/README
 create mode 100644 tools/linker-tables/arch/x86/include/asm/asm.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/boot.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/bootparam.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/kprobes.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/ps_const.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/ranges.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/section-core.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/setup.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/tables.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/x86.h
 create mode 100644 tools/linker-tables/arch/x86/include/asm/x86_init_fn.h
 create mode 100644 tools/linker-tables/arch/x86/kernel/alpha.c
 create mode 100644 tools/linker-tables/arch/x86/kernel/alternative.c
 create mode 100644 tools/linker-tables/arch/x86/kernel/beta.c
 create mode 100644 tools/linker-tables/arch/x86/kernel/head64.c
 create mode 100644 tools/linker-tables/arch/x86/kernel/init.c
 create mode 100644 tools/linker-tables/arch/x86/kernel/kasan.c
 create mode 100644 tools/linker-tables/arch/x86/kernel/kprobes.c
 create mode 100644 tools/linker-tables/arch/x86/kernel/vmlinux.lds.S
 create mode 100644 tools/linker-tables/arch/x86/mm/init.c
 create mode 100644 tools/linker-tables/arch/x86/xen/init.c
 create mode 100644 tools/linker-tables/drivers/acme.c
 create mode 100644 tools/linker-tables/drivers/synth/common.c
 create mode 100644 tools/linker-tables/drivers/synth/common.h
 create mode 100644 tools/linker-tables/drivers/synth/main.c
 create mode 100644 tools/linker-tables/drivers/synth/or.S
 create mode 100644 tools/linker-tables/drivers/synth/synth.h
 create mode 100644 tools/linker-tables/drivers/xen-driver.c
 create mode 100644 tools/linker-tables/include/asm-generic/arch_init_fn.h
 create mode 100644 tools/linker-tables/include/asm-generic/kprobes.h
 create mode 100644 tools/linker-tables/include/linux/bitops.h
 create mode 100644 tools/linker-tables/include/linux/init.h
 create mode 100644 tools/linker-tables/include/linux/kasan.h
 create mode 100644 tools/linker-tables/include/linux/kernel.h
 create mode 100644 tools/linker-tables/include/linux/kprobes.h
 create mode 100644 tools/linker-tables/include/linux/module.h
 create mode 100644 tools/linker-tables/include/linux/mutex.h
 create mode 100644 tools/linker-tables/include/linux/pci.h
 create mode 100644 tools/linker-tables/include/linux/printk.h
 create mode 100644 tools/linker-tables/include/linux/ps_const.h
 create mode 100644 tools/linker-tables/include/linux/sched.h
 create mode 100644 tools/linker-tables/include/linux/spinlock.h
 create mode 100644 tools/linker-tables/include/linux/start_kernel.h
 create mode 100644 tools/linker-tables/include/linux/types.h
 create mode 100644 tools/linker-tables/include/linux/workqueue.h
 create mode 100644 tools/linker-tables/include/xen/xen.h
 create mode 100644 tools/linker-tables/kernel/locking/mutex.c
 create mode 100644 tools/linker-tables/kernel/locking/spinlock.c
 create mode 100644 tools/linker-tables/kernel/main.c
 create mode 100644 tools/linker-tables/kernel/workqueue.c
 create mode 100644 tools/linker-tables/lib/string.c
 create mode 100644 tools/linker-tables/main.c
 create mode 100644 tools/linker-tables/pci-quirks.c
 create mode 100644 tools/linker-tables/pci.c

diff --git a/Documentation/sections/linker-tables.rst b/Documentation/sections/linker-tables.rst
index bc2d9f46cde6..2f2bb1fc0798 100644
--- a/Documentation/sections/linker-tables.rst
+++ b/Documentation/sections/linker-tables.rst
@@ -11,11 +11,11 @@ About Linker tables
 .. kernel-doc:: include/linux/tables.h
    :doc: Introduction
 
-Linker table provenance
+Linker table provenance and userspace testing
 ---------------------------------------------
 
 .. kernel-doc:: include/linux/tables.h
-   :doc: Linker table provenance
+   :doc: Linker table provenance and userspace testing
 
 Benefits of using Linker tables
 ===============diff --git a/MAINTAINERS b/MAINTAINERS
index cee1efd50e04..b83bd957011e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5429,6 +5429,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	include/asm-generic/tables.h
 F:	include/linux/tables.h
+F:	tools/linker-tables/
 F:	Documentation/sections/linker-tables.rst
 
 GENERIC PHY FRAMEWORK
diff --git a/include/linux/tables.h b/include/linux/tables.h
index f295fbe74734..9dd8f947b60b 100644
--- a/include/linux/tables.h
+++ b/include/linux/tables.h
@@ -35,12 +35,13 @@
  */
 
 /**
- * DOC: Linker table provenance
+ * DOC: Linker table provenance and userspace testing
  *
  * The Linux implementation of linker tables was inspired by the iPXE linker
  * table's solution (iPXE commit 67a10ef000cb7 "[contrib] Add rom-o-matic to
  * contrib "[0]).  To see how this code evolved refer to the out of tree
- * userspace linker-table tree [1].
+ * userspace linker-table tree [1]. Linux has a similar userspace application
+ * in tools/linker-tables/ to help more easily test adding new extensions.
  *
  * Contrary to iPXE's solution which strives to force compilation of
  * everything using linker tables, Linux's solution allows for developers to be
diff --git a/tools/Makefile b/tools/Makefile
index 00caacd3ed92..ecb2e651c930 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -19,6 +19,7 @@ help:
 	@echo '  kvm_stat               - top-like utility for displaying kvm statistics'
 	@echo '  leds                   - LEDs  tools'
 	@echo '  lguest                 - a minimal 32-bit x86 hypervisor'
+	@echo '  linker-tables		- userspace liker table sandbox and related tools'
 	@echo '  net                    - misc networking tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
@@ -86,7 +87,7 @@ tmon: FORCE
 freefall: FORCE
 	$(call descend,laptop/$@)
 
-all: acpi cgroup cpupower gpio hv firewire lguest \
+all: acpi cgroup cpupower gpio hv firewire lguest linker-tables \
 		perf selftests turbostat usb \
 		virtio vm net x86_energy_perf_policy \
 		tmon freefall objtool
diff --git a/tools/arch/x86/include/generated/asm/section-core.h b/tools/arch/x86/include/generated/asm/section-core.h
new file mode 100644
index 000000000000..06be2b1c424f
--- /dev/null
+++ b/tools/arch/x86/include/generated/asm/section-core.h
@@ -0,0 +1 @@
+#include <asm-generic/section-core.h>
diff --git a/tools/arch/x86/include/generated/ranges.h b/tools/arch/x86/include/generated/ranges.h
new file mode 100644
index 000000000000..dac1a9a11367
--- /dev/null
+++ b/tools/arch/x86/include/generated/ranges.h
@@ -0,0 +1 @@
+#include <asm-generic/ranges.h>
diff --git a/tools/arch/x86/include/generated/tables.h b/tools/arch/x86/include/generated/tables.h
new file mode 100644
index 000000000000..d437818275c5
--- /dev/null
+++ b/tools/arch/x86/include/generated/tables.h
@@ -0,0 +1 @@
+#include <asm-generic/tables.h>
diff --git a/tools/include/asm-generic/ranges.h b/tools/include/asm-generic/ranges.h
new file mode 100644
index 000000000000..10e67bcf6dbe
--- /dev/null
+++ b/tools/include/asm-generic/ranges.h
@@ -0,0 +1,93 @@
+#ifndef _ASM_GENERIC_RANGES_H_
+#define _ASM_GENERIC_RANGES_H_
+/*
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+#include <asm/section-core.h>
+
+#ifndef set_section_rng
+# define set_section_rng(section, name, flags)				\
+	 set_section_core(section, rng, name,				\
+			  any, flags)
+#endif
+
+#ifndef set_section_rng_type
+# define set_section_rng_type(section, name, flags, type)		\
+	 set_section_core_type(section, rng, name,			\
+			       any, flags, type)
+#endif
+
+#ifndef set_section_rng_level
+# define set_section_rng_level(section, name, level, flags)		\
+	 set_section_core(section, rng, name, level, flags)
+#endif
+
+#ifndef push_section_rng
+# define push_section_rng(section, name, flags)				\
+	 push_section_core(section, rng, name,				\
+			   any, flags)
+#endif
+
+#ifndef push_section_rng_level
+# define push_section_rng_level(section, name, level, flags)		\
+	 push_section_core(section, rng, name,				\
+			   level, flags)
+#endif
+
+#ifndef __ASSEMBLY__
+/**
+ * __LINUX_RANGE - short hand association into a section range
+ *
+ * @section: ELF section name to place section range into
+ * @name: section range name
+ *
+ * This helper can be used by subsystems to define their own subsystem
+ * specific helpers to easily associate a piece of code being defined to a
+ * section range.
+ */
+#define __LINUX_RANGE(section, name)					\
+	__attribute__((__section__(#section "..rng.name.any")))
+
+/**
+ * __LINUX_RANGE_ORDER - short hand association into a section range of order
+ *
+ * @section: ELF section name to place section range into
+ * @name: section range name
+ * @level: order level, a number. The order level gets tucked into the
+ *	section as a postfix string. Order levels are sorted using binutils
+ *	SORT(), the number is sorted as a string, as such be sure to fill with
+ *	zeroes any empty digits. For instance if you are using 3 levels of
+ *	digits for order levels, use 001 for the first entry, 0002 for the
+ *	second, 999 for the last entry. You can use however many digits you
+ *	need.
+ *
+ * This helper can be used by subsystems to define their own subsystem specific
+ * helpers to easily associate a piece of code being defined to a section range
+ * with an associated specific order level. The order level provides the
+ * ability for explicit user ordering of code. Sorting takes place at link
+ * time, after compilation.
+ */
+#define __LINUX_RANGE_ORDER(section, name, level)			\
+	__attribute__((__section__(#section "..rng.name." #level)))
+
+#endif /* __ASSEMBLY__ */
+
+#ifdef __ASSEMBLER__
+
+#ifndef DEFINE_SECTION_RANGE
+#define DEFINE_SECTION_RANGE(section, name)				\
+  push_section_rng_level(section, name,,) ;				\
+  .globl name ;								\
+name: ;									\
+  .popsection								\
+									\
+  push_section_rng_level(section, name, ~,) ;				\
+  .popsection
+#endif
+#endif /* __ASSEMBLER__ */
+
+#endif /* _ASM_GENERIC_RANGES_H_ */
diff --git a/tools/include/asm-generic/section-core.h b/tools/include/asm-generic/section-core.h
new file mode 100644
index 000000000000..e2db4da87222
--- /dev/null
+++ b/tools/include/asm-generic/section-core.h
@@ -0,0 +1,348 @@
+#ifndef _ASM_GENERIC_SECTION_CORE_H_
+#define _ASM_GENERIC_SECTION_CORE_H_
+/*
+ * Linux section core definitions
+ *
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+
+/**
+ * DOC: Linux ELF program specific sections
+ *
+ * Linux makes extensive use of ``SHT_PROGBITS`` to both extend use and
+ * definition of *Special ELF Sections* (`gabi4 ch4`_) and to define its own
+ * sections. This chapter is dedicated to documenting Linux program specific
+ * sections and helpers available to make use of these easier to implement and
+ * use.
+ *
+ * .. _gabi4 ch4: https://refspecs.linuxbase.org/elf/gabi4+/ch4.sheader.html#special_sections
+ */
+
+/**
+ * DOC: Linux linker script
+ *
+ * Linux uses a custom linker script to build the vmlinux binary, it uses it to
+ * strategically place and define Linux ELF sections.  Each architecture needs
+ * to implement its own linker script, it is expected to reside in
+ * ``arch/$(ARCH)/kernel/vmlinux.lds.S``.  Architecture Linux linker scripts in
+ * turn include and use definitions from ``include/asm-generic/vmlinux.lds.h``,
+ * as well as some helpers documented in this chapter.
+ *
+ * In assembly it is common practice to use dots (``.``) in labels to avoid
+ * clashes with C symbols. Similarly, a dot (``.``) can be part of a section
+ * name but not a C symbol. Historically then, two dots are used (``..``)
+ * have been used in linker scripts when adding program specific sections
+ * when there are concerns to avoid clashes with compiler generated sections.
+ */
+
+/**
+ * DOC: Memory protection
+ *
+ * Linux allows architectures which support memory protection features to
+ * take advantage of them by letting architectures define and enable
+ * ``CONFIG_DEBUG_RODATA`` and implement a mark_rodata_ro() call.
+ * mark_rodata_ro() can be used for instance to mark specific sections as
+ * read-only or non-executable.
+ *
+ * Linux typically follows a convention to have the .rodata ELF section follow
+ * after the .text ELF section, it does this to help architectures which
+ * support memory protection to mark both .text and .rodata as read-only in
+ * one shot.
+ *
+ * For more details refer to mark_rodata_ro().
+ */
+
+/**
+ * DOC: .rodata
+ *
+ * ELF section used for data which must be protected from write access.
+ */
+
+/**
+ * DOC: .text
+ *
+ * ELF section name used for code (functions) used during regular
+ * kernel run time.
+ */
+
+/**
+ * DOC: .data
+ *
+ * ELF section used for read-write data.
+ */
+
+/**
+ * DOC: Linux init sections
+ *
+ * These sections are used for code and data structures used during boot or
+ * module initialization. On architectures that support it (x86, x86_64), all
+ * this code is freed up by the kernel right before the fist userspace init
+ * process is called when built-in to the kernel, and if modular it is freed
+ * after module initialization. Since the code is freed so early, in theory
+ * there should be no races against freeing this code with other CPUs. Init
+ * section code and data structures should never be exported with
+ * EXPORT_SYMBOL*() as the code will quickly become unavailable to the kernel
+ * after bootup.
+ */
+
+/**
+ * DOC: .init.text
+ *
+ * ELF section for code (functions) used only during boot or driver
+ * initialization.
+ *
+ */
+
+/**
+ * DOC: .init.data
+ *
+ * ELF section used for data structures used only during boot or driver
+ * initialization.
+ */
+
+/**
+ * DOC: .init.rodata
+ *
+ * ELF section used for read-only code (functions) used only during boot
+ * or driver initialization.
+ */
+
+/**
+ * DOC: .initcall
+ *
+ * ELF section used for subsystem init calls. There are init levels
+ * representing different functionality in the kernel. For more details
+ * refer to __define_initcall().
+ */
+
+/**
+ * DOC: Linux exit sections
+ *
+ * These sections are used to declare a functions and data structures which
+ * are only required on exit, the function or data structure will be dropped
+ * if the code declaring this section is not compiled as a module on
+ * architectures that support this (x86, x86_64). There is no special case
+ * handling for this code when built-in to the kernel.
+ */
+
+/**
+ * DOC: .exit.text
+ *
+ * ELF section used to for code (functions) used only during module unload.
+ */
+
+/**
+ * DOC: .exit.data
+ *
+ * ELF section used to for data structures used only during module
+ * unload.
+ */
+
+/**
+ * DOC: .exitcall.exit
+ *
+ * ELF section used for exit routines, order is important and maintained by
+ * link order.
+ */
+
+/**
+ * DOC: Linux references to init sections
+ *
+ * These sections are used to teach modpost to not warn about possible
+ * misuses of init section code from other sections. If you use this
+ * your use case should document why you are certain such use of init
+ * sectioned code is valid. For more details refer to ``include/linux/init.h``
+ * ``__ref``, ``__refdata``, and ``__refconst`` documentation.
+ */
+
+/**
+ * DOC: .ref.text
+ *
+ * ELF section used to annotate code (functions) which has been vetted as
+ * valid for its reference or use of other code (functions) or data structures
+ * which are part of the init sections.
+ */
+
+/**
+ * DOC: .ref.data
+ *
+ * ELF section used for data structures which have been vetted for its
+ * reference or use of other code (functions) or data structures part of the
+ * init sections.
+ */
+
+/**
+ * DOC: .ref.rodata
+ *
+ * ELF section used to annotate const code (functions) const data structures
+ * which has been vetted for its reference or use of other code (functions)
+ * or data structures part of the init sections.
+ */
+
+/**
+ * DOC: Linux section ordering
+ *
+ * Linux may use binutils linker-script 'SORT()' on sections to sort Linux
+ * sections alpha numerically. Linux has historically used 'SORT()' in
+ * ``include/asm-generic/vmlinux.lds.h``, its a well established practice. If
+ * 'SORT()' is used on a section one can provide ordering using a postfix on
+ * each section entry added. For instance if a linker script uses::
+ *
+ *    SORT(.foo.*)
+ *
+ * one can then add entries with explicit ordering using numeric postfixes for
+ * each entry, we refer to these as 'order levels'. Since 'SORT()' sorts alpha
+ * numerically a specific series set of digits must be agreed a-priori which
+ * would give also an idea of the max expected number of entries added to a
+ * section. For instance, if you expect a maximum of 999 entries you can use
+ * 3 digits for a section order level. If you wanted an entry to be ordered
+ * first you could use the postfix '000', if you wanted an entry to follow this
+ * you could use '001', and so on. We could for instance have::
+ *
+ *    .foo.000
+ *    .foo.001
+ *    .foo.002
+ *
+ * Often times one may want the option to specify no order is required for
+ * certain elements added to a section which does use 'SORT()' on the linker
+ * script. You can use any arbitrary string value to to specify no order is
+ * used, so long as its used consistantly. For instance, one possibility is to
+ * use the 'any' postfix.  All entries on the section would then have no
+ * specific ordering::
+ *
+ *    .foo.any
+ *    .foo.any
+ *    .foo.any
+ *
+ * To help establish a convention we reserve the special name 'any' for this
+ * purpose. Developers can use and expect the 'any' postfix string on sections
+ * as a helper to annotate section ordering at link time is not relevant
+ * for entries on a section.
+ */
+
+/* Can be used on foo.S for instance */
+#ifndef __set_section_core_type
+# define __set_section_core_type(___section, ___core, ___name,		\
+				 ___level, ___flags, ___type)		\
+	.section ___section..___core.___name.___level, ___flags, ___type
+#endif
+
+#ifndef __set_section_core
+# define __set_section_core(___section, ___core, ___name, ___level, ___flags) \
+	.section ___section..___core.___name.___level, ___flags
+#endif
+
+#ifndef __push_section_core
+# define __push_section_core(__section, __core, __name, __level, __flags) \
+	.pushsection __section..__core.__name.__level, __flags
+#endif
+
+#ifdef __KERNEL__
+#include <linux/stringify.h>
+#endif
+
+#if defined(__ASSEMBLER__) || defined(__ASSEMBLY__)
+
+# ifndef LINKER_SCRIPT
+
+#  ifndef push_section_core
+#   define push_section_core(__section, __core, __name, __level, __flags) \
+	 __push_section_core(__section, __core, __name,			  \
+			     __level, __stringify(__flags))
+#  endif
+
+#  ifndef set_section_core
+#   define set_section_core(__section, __core, __name,			\
+			    __level, __flags)				\
+	__set_section_core(__section, __core, __name,			\
+			   __level, __stringify(__flags))
+#  endif
+
+#  ifndef set_section_core_type
+#   define set_section_core_type(__section, __core, __name,		\
+				 __level, __flags, __type)		\
+	__set_section_core_type(__section, __core, __name, __level,	\
+				__stringify(__flags), __type)
+#  endif
+
+# endif /* LINKER_SCRIPT */
+#else /* defined(__ASSEMBLER__) || defined(__ASSEMBLY__) */
+
+/*
+ * As per gcc's documentation a common asm separator is a new line followed
+ * by tab [0], it however seems possible to also just use a newline as its
+ * the most commonly empirically observed semantic and folks seem to agree
+ * this even works on S390. In case your architecture disagrees you may
+ * override this and define your own and keep the rest of the macros.
+ *
+ * [0] https://gcc.gnu.org/onlinedocs/gcc/Basic-Asm.html#Basic-Asm
+ */
+# ifndef ASM_CMD_SEP
+#  define ASM_CMD_SEP	"\n"
+# endif
+
+# ifndef set_section_core
+#  define set_section_core(__section, __core, __name, __level, __flags)	\
+	__stringify(__set_section_core_type(__section, __core, __name,	\
+					    __level, __stringify(__flags))) \
+	ASM_CMD_SEP
+# endif
+
+/*
+ * Some architectures (arm, and avr32 are two examples on kprobes) seem
+ * currently explicitly specify the type [0] -- this can be any of the
+ * optional constants on ELF:
+ *
+ * @progbits - section contains data
+ * @nobits - section does not contain data (i.e., section only occupies space)
+ * @note - section contains data which is used by things other than the program
+ * @init_array - section contains an array of pointers to init functions
+ * @fini_array - section contains an array of pointers to finish functions
+ * @preinit_array - section contains an array of pointers to pre-init functions
+ *
+ * ARM requires % instead of @.
+ *
+ * At least as per nasm (x86/x86_64 only), in the absence of qualifiers the
+ * defaults are as follows:
+ *
+ * section .text    progbits  alloc   exec    nowrite  align
+ * section .rodata  progbits  alloc   noexec  nowrite  align=4
+ * section .lrodata progbits  alloc   noexec  nowrite  align=4
+ * section .data    progbits  alloc   noexec  write    align=4
+ * section .ldata   progbits  alloc   noexec  write    align=4
+ * section .bss     nobits    alloc   noexec  write    align=4
+ * section .lbss    nobits    alloc   noexec  write    align=4
+ * section .tdata   progbits  alloc   noexec  write    align=4    tls
+ * section .tbss    nobits    alloc   noexec  write    align=4    tls
+ * section .comment progbits  noalloc noexec  nowrite  align=1
+ * section other    progbits  alloc   noexec  nowrite  align=1
+ *
+ * gas should have sensible defaults for architectures...
+ *
+ * [0] http://www.nasm.us/doc/nasmdoc7.html
+ */
+# ifndef set_section_core_type
+#  define set_section_core_type(__section, __core, __name, __level,	\
+				__flags, __type)			\
+	__stringify(__set_section_core_type(__section, __core,		\
+					    __name, __level,		\
+					    __stringify(__flags),	\
+					    __type))			\
+	ASM_CMD_SEP
+# endif
+
+# ifndef push_section_core
+#  define push_section_core(__section, __core, __name,			\
+			    __level, __flags)				\
+	__stringify(__push_section_core(__section, __core,		\
+					__name,	__level,		\
+					__stringify(__flags)))		\
+	ASM_CMD_SEP
+# endif
+
+#endif /* defined(__ASSEMBLER__) || defined(__ASSEMBLY__) */
+#endif /* _ASM_GENERIC_SECTION_CORE_H_ */
diff --git a/tools/include/asm-generic/tables.h b/tools/include/asm-generic/tables.h
new file mode 100644
index 000000000000..567775b292c2
--- /dev/null
+++ b/tools/include/asm-generic/tables.h
@@ -0,0 +1,48 @@
+#ifndef _ASM_GENERIC_TABLES_H_
+#define _ASM_GENERIC_TABLES_H_
+/*
+ * Linux linker tables
+ *
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+#include <asm/section-core.h>
+
+#define SECTION_TBL(section, name, level)	section..tbl.name.level
+
+/* Some toolchains are buggy, let them override */
+#ifndef SECTION_TBL_RO
+# define SECTION_TBL_RO	.rodata
+#endif
+
+#define SECTION_TBL_RO_STR __stringify(SECTION_TBL_RO)
+
+#ifndef set_section_tbl
+# define set_section_tbl(section, name, level, flags)			\
+	 set_section_core(section, tbl, name, level, flags)
+#endif
+
+#ifndef set_section_tbl_any
+# define set_section_tbl_any(section, name, flags)			\
+	 set_section_core(section, tbl, name, any, flags)
+#endif
+
+#ifndef set_section_tbl_type
+# define set_section_tbl_type(section, name, level, flags, type)	\
+	 set_section_core_type(section, tbl, name, level, flags, type)
+#endif
+
+#ifndef push_section_tbl
+# define push_section_tbl(section, name, level, flags)			\
+	 push_section_core(section, tbl, name, level, flags)
+#endif
+
+#ifndef push_section_tbl_any
+# define push_section_tbl_any(section, name, flags)			\
+	 push_section_core(section, tbl, name, any, flags)
+#endif
+
+#endif /* _ASM_GENERIC_TABLES_H_ */
diff --git a/tools/include/linux/ranges.h b/tools/include/linux/ranges.h
new file mode 100644
index 000000000000..3368fc475cd8
--- /dev/null
+++ b/tools/include/linux/ranges.h
@@ -0,0 +1,183 @@
+#ifndef _LINUX_RANGES_H
+#define _LINUX_RANGES_H
+/*
+ * Linux section ranges
+ *
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+#include <linux/sections.h>
+#include <asm/ranges.h>
+
+#ifndef __ASSEMBLY__
+
+/**
+ * DOC: Introduction
+ *
+ * A section ranges consists of explicitly annotated series executable code
+ * stitched together for the purpose of selective placement into standard or
+ * architecture specific ELF sections. What ELF section is used is utility
+ * specific. Linux has historically implicitly used section ranges, however
+ * they were all built in an adhoc manner and typically required linker script
+ * modifications per architecture. The section range API allows adding new
+ * bundles of stiched executable code into custom ELF sections by only
+ * modifying C or asm code in an architecture agnostic form.
+ *
+ * This documents the set of helpers available to declare, and define section
+ * ranges and associate each section range to a specific Linux ELF section.
+ */
+
+/**
+ * DOC: Section range module support
+ *
+ * Modules can use section ranges, however the section range definition must be
+ * built-in to the kernel. That is, the code that implements
+ * DEFINE_SECTION_RANGE() must be built-in, and modular code cannot add more
+ * items in to the section range (with __LINUX_RANGE() or
+ * __LINUX_RANGE_ORDER()), unless kernel/module.c find_module_sections() and
+ * module-common.lds.S are updated accordingly with a respective module
+ * notifier to account for updates. This restriction may be enhanced in the
+ * future.
+ */
+
+/**
+ * DOC: Section range helpers
+ *
+ * These are helpers for section ranges.
+ */
+
+/**
+ * SECTION_RANGE_START - get address of start of section range
+ *
+ * @name: name of the section range
+ *
+ * This gives you the start address of the section range.
+ * This should give you the address of the first entry.
+ *
+ */
+#define SECTION_RANGE_START(name)	LINUX_SECTION_START(name)
+
+/**
+ * SECTION_RANGE_END - get address of end of the section range
+ *
+ * @name: name of the section range
+ *
+ * This gives you the end address of the linker table.
+ * This will match the start address if the linker table
+ * is empty.
+ */
+#define SECTION_RANGE_END(name)		LINUX_SECTION_END(name)
+
+/**
+ * SECTION_RANGE_SIZE - get number of entries in the section range
+ *
+ * @name: name of the section range
+ *
+ * This gives you the number of entries in the section range.
+ * Example usage:
+ *
+ *   unsigned int num_ents = LINKTABLE_SIZE(some_fns);
+ */
+#define SECTION_RANGE_SIZE(name)					\
+	((SECTION_RANGE_END(name)) - (SECTION_RANGE_START(name)))
+
+/**
+ * SECTION_RANGE_EMPTY - check if section range has no entries
+ *
+ * @name: name of the section range
+ *
+ * Returns true if the section range is emtpy.
+ *
+ *   bool is_empty = LINKTABLE_EMPTY(some_fns);
+ */
+#define SECTION_RANGE_EMPTY(name)	(SECTION_RANGE_SIZE(name) = 0)
+
+/**
+ * SECTION_RANGE_ADDR_WITHIN - returns true if address is in the section range
+ *
+ * @name: name of the section range
+ * @addr: address to query for
+ *
+ * Returns true if the address is in the section range.
+ */
+#define SECTION_RANGE_ADDR_WITHIN(name, addr)				\
+	 (addr >= (unsigned long) SECTION_RANGE_START(name) &&		\
+	  addr < (unsigned long) SECTION_RANGE_END(name))
+
+/**
+ * SECTION_RANGE_ALIGNMENT - get the alignment of the section range
+ *
+ * @name: name of linker table
+ *
+ * Gives you the alignment for the section range.
+ */
+#define SECTION_RANGE_ALIGNMENT(name)	LINUX_SECTION_ALIGNMENT(name)
+
+/**
+ * DECLARE_SECTION_RANGE - Declares a section range
+ *
+ * @name: section range name
+ *
+ * Declares a section range to help code access the range. Typically if
+ * a subsystems needs code to have direct access to the section range the
+ * subsystem's header file would declare the section range. Care should be
+ * taken to only declare the section range in a header file if access to it
+ * is truly needed outside of the code defining it. You typically would
+ * rather instead provide helpers which access the section range with special
+ * code on behalf of the caller.
+ */
+#define DECLARE_SECTION_RANGE(name)					\
+	DECLARE_LINUX_SECTION_RO(char, name)
+
+/**
+ * __SECTION_RANGE_BEGIN - Constructs the beginning of a section range
+ *
+ * @name: section range name
+ * @__section: ELF section to place section range into
+ *
+ * Constructs the beginning of a section range. You will typically not need
+ * to use this directly.
+ */
+#define __SECTION_RANGE_BEGIN(name, __section)				\
+	const __typeof__(SECTION_RANGE_START(name)[0])			\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(SECTION_RANGE_ALIGNMENT(name)),\
+			     section(#__section "..rng.name.")))
+
+/**
+ * __SECTION_RANGE_END - Constructs the end of a section range
+ *
+ * @name: section range name
+ * @__section: ELF section to place section range into
+ *
+ * Constructs the end of a section range. You will typically not need
+ * to use this directly.
+ */
+#define __SECTION_RANGE_END(name, __section)				\
+	const __typeof__(SECTION_RANGE_START(name)[0])			\
+	      __attribute__((used,					\
+			     __aligned__(SECTION_RANGE_ALIGNMENT(name)),\
+			     section(#__section "..rng.name.~")))
+
+/**
+ * DEFINE_SECTION_RANGE - Defines a section range
+ *
+ * @name: section range name
+ * @section: ELF section name to place section range into
+ *
+ * Defines a section range, used for executable code. Section ranges are
+ * defined in the code that takes ownership and makes use of the section
+ * range.
+ */
+#define DEFINE_SECTION_RANGE(name, section)				\
+	DECLARE_LINUX_SECTION_RO(char, name);				\
+	__SECTION_RANGE_BEGIN(name, section) SECTION_RANGE_START(name)[0] = {};\
+	__SECTION_RANGE_END(name, section) SECTION_RANGE_END(name)[0] = {}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_RANGES_H */
diff --git a/tools/include/linux/sections.h b/tools/include/linux/sections.h
new file mode 100644
index 000000000000..6771c727bcd1
--- /dev/null
+++ b/tools/include/linux/sections.h
@@ -0,0 +1,87 @@
+#ifndef _LINUX_SECTIONS_H
+#define _LINUX_SECTIONS_H
+/*
+ * Linux de-facto sections
+ *
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+
+#include <asm/section-core.h>
+#include <linux/export.h>
+
+#ifndef __ASSEMBLY__
+
+/**
+ * DOC: Introduction
+ *
+ * Linux defines a set of common helpers which can be used to against its use
+ * of standard or custom Linux sections, this section is dedicated to these
+ * helpers.
+ */
+
+/**
+ * LINUX_SECTION_ALIGNMENT - get section alignment
+ *
+ * @name: section name
+ *
+ * Gives you the alignment for the section.
+ */
+#define LINUX_SECTION_ALIGNMENT(name)	__alignof__(*VMLINUX_SYMBOL(name))
+
+/**
+ * LINUX_SECTION_START - get address of start of section
+ *
+ * @name: section name
+ *
+ * This gives you the start address of the section.
+ * This should give you the address of the first entry.
+ *
+ */
+#define LINUX_SECTION_START(name)	VMLINUX_SYMBOL(name)
+
+/**
+ * LINUX_SECTION_END - get address of end of the section
+ *
+ * @name: section name
+ *
+ * This gives you the end address of the section.
+ * This should give you the address of the end of the
+ * section. This will match the start address if the
+ * section is empty.
+ */
+#define LINUX_SECTION_END(name)	VMLINUX_SYMBOL(name##__end)
+
+/**
+ * DECLARE_LINUX_SECTION - Declares a custom Linux section
+ *
+ * @type: type of custom Linux section
+ * @name: custom section name
+ *
+ * Declares a read-write custom Linux section
+ */
+#define DECLARE_LINUX_SECTION(type, name)				\
+	 extern type VMLINUX_SYMBOL(name)[], \
+		     VMLINUX_SYMBOL(name##__end)[]
+
+/**
+ * DECLARE_LINUX_SECTION_RO - Declares a read-only custom Linux section
+ *
+ * @type: type of custom Linux section
+ * @name: custom section name
+ *
+ * Declares a read-only custom Linux section
+ */
+#define DECLARE_LINUX_SECTION_RO(type, name)				\
+	 extern const type VMLINUX_SYMBOL(name)[],			\
+			   VMLINUX_SYMBOL(name##__end)[]
+
+#define __SECTION_CORE(section, core, name, level)			\
+	#section ".." #core "." #name "." #level
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_SECTIONS_H */
diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index f436d2420a18..a6b12564bbd9 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -3,6 +3,7 @@
 
 
 #include <linux/types.h>	/* for size_t */
+#include <string.h>
 
 void *memdup(const void *src, size_t len);
 
diff --git a/tools/include/linux/tables.h b/tools/include/linux/tables.h
new file mode 100644
index 000000000000..9dd8f947b60b
--- /dev/null
+++ b/tools/include/linux/tables.h
@@ -0,0 +1,684 @@
+#ifndef _LINUX_LINKER_TABLES_H
+#define _LINUX_LINKER_TABLES_H
+/*
+ * Linux linker tables
+ *
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+#include <linux/export.h>
+#include <linux/sections.h>
+#include <asm/tables.h>
+
+#ifndef __ASSEMBLY__
+
+/**
+ * DOC: Introduction
+ *
+ * A linker table is a data structure that is stitched together from items in
+ * multiple object files for the purpose of selective placement into standard
+ * or architecture specific ELF sections. What section is used is utility
+ * specific. Linux has historically implicitly used linker tables, however they
+ * were all built in an adhoc manner which requires linker script modifications
+ * per architecture. The linker table API provides a general facility so that
+ * data structures can be stitched together and placed into Linux ELF sections
+ * by only changing C or asm code in an architecture agnostic form.
+ *
+ * Linker tables help you group together related data and code in an efficient
+ * way. Linker tables can be used to help simplify init sequences, they
+ * enable linker build time selective sorting (disabled options get ignored),
+ * and can optionally also be used to help you avoid code bit-rot due to
+ * overuse of #ifdef.
+ */
+
+/**
+ * DOC: Linker table provenance and userspace testing
+ *
+ * The Linux implementation of linker tables was inspired by the iPXE linker
+ * table's solution (iPXE commit 67a10ef000cb7 "[contrib] Add rom-o-matic to
+ * contrib "[0]).  To see how this code evolved refer to the out of tree
+ * userspace linker-table tree [1]. Linux has a similar userspace application
+ * in tools/linker-tables/ to help more easily test adding new extensions.
+ *
+ * Contrary to iPXE's solution which strives to force compilation of
+ * everything using linker tables, Linux's solution allows for developers to be
+ * selective over where one wishes to force compilation, this then is just an
+ * optional feature for the Linux linker table solution. The main advantages
+ * of using linker-tables then are:
+ *
+ *  - Avoiding modifying architecture linker scripts
+ *  - Simplifying initialization code
+ *  - Avoiding the code bit-rot problem
+ *
+ * [0] git://git.ipxe.org/ipxe.git
+ *
+ * [1] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linker-tables.git/
+ */
+
+/**
+ * DOC: Avoids modifying architecture linker scripts
+ *
+ * Linker tables enable you to avoid modifying architecture linker scripts
+ * since it has its has extended each core Linux section with a respective
+ * linker table entry in `include/asm-generic/vmlinux.lds.h`. When you add new
+ * linker table entry you aggregate them `into` the existing linker table core
+ * section.
+ */
+
+/**
+ * DOC: How linker tables simplify initialization code
+ *
+ * Traditionally, we would implement features in C code as follows:
+ *
+ *  foo_init();
+ *
+ * You'd then have a foo.h which would have::
+ *
+ *  #ifndef CONFIG_FOO
+ *  static inline void foo_init(void) { }
+ *  #endif
+ *
+ * With linker tables this is no longer necessary as your init routines would
+ * be implicit, you'd instead call:
+ *
+ *  call_init_fns();
+ *
+ * call_init_fns() would call all functions present in your init table and if
+ * and only if foo.o gets linked in, then its initialisation function will be
+ * called.
+ *
+ * The linker script takes care of assembling the tables for us. All of our
+ * table sections have names of the format `SECTION_NAME..tbl.NAME.N`. Here
+ * `SECTION_NAME` is one of the standard sections in::
+ *
+ *   include/asm-generic/section-core.h
+ *
+ * and `NAME` designates the specific use case for the linker table, the table.
+ * `N` is a digit used to help sort entries in the section. `N=` (empty string)
+ * is reserved for the symbol indicating `table start`, and `N=~` is reserved
+ * for the symbol indicating `table end`. In order for the call_init_fns() to
+ * work behind the scenes the custom linker script would need to define the
+ * beginning of the table, the end of the table, and in between it should use
+ * ``SORT()`` to give order to the section. Typically this would require custom
+ * linker script modifications however since linker table are already defined
+ * in ``include/asm-generic/vmlinux.lds.h`` as documented above each new linker
+ * table definition added in C code folds into the respective core Linux
+ * section linker table.
+ *
+ * This is also done to support all architectures.  All that is needed then is
+ * to ensure a respective common linker table entry is added to the shared
+ * ``include/asm-generic/vmlinux.lds.h``.  There should be a respective::
+ *
+ *  *(SORT(.foo..tbl.*))
+ *
+ * entry for each type of supported section there. If your `SECTION_NAME`
+ * is not yet supported, consider adding support for it.
+ *
+ * Linker tables support ordering entries, it does this using a digit which
+ * is eventually added as a postfix to a section entry name, we refer to this
+ * as the linker table ``order-level``. If order is not important to your
+ * linker table entry you can use the special ``SECTION_ORDER_ANY``. After
+ * ``order-level``, the next contributing factor to order is the order of the
+ * code in the C file, and the order of the objects in the Makefile. Using an
+ * ``order-level`` then should not really be needed in most cases, its use
+ * however enables to compartamentalize code into tables where ordering through
+ * C file or through the Makefile would otherwise be very difficult or if one
+ * wanted to enable very specific initialization semantics.
+ *
+ * As an example, suppose that we want to create a "frobnicator"
+ * feature framework, and allow for several independent modules to
+ * provide frobnicating services. Then we would create a frob.h
+ * header file containing e.g.::
+ *
+ *	struct frobnicator {
+ *		const char *name;
+ *		void (*frob) (void);
+ *	};
+ *
+ *	DECLARE_LINKTABLE(struct frobnicator, frobnicator_fns);
+ *
+ * Any module providing frobnicating services would look something
+ * like::
+ *
+ *	#include "frob.h"
+ *
+ *	static void my_frob(void) {
+ *		... Do my frobnicating
+ *	}
+ *
+ *	LINKTABLE_INIT_DATA(frobnicator_fns, all) my_frobnicator = {
+ *		.name = "my_frob",
+ *		.frob = my_frob,
+ *	};
+ *
+ * The central frobnicator code, say in frob.c, would use the frobnicating
+ * modules as follows::
+ *
+ *	#include "frob.h"
+ *
+ *	void frob_all(void) {
+ *		struct frobnicator *f;
+ *
+ *		linktable_for_each(f, frobnicator_fns) {
+ *			pr_info("Calling frobnicator %s\n", frob->name);
+ *			f->frob();
+ *		}
+ *	}
+ */
+
+/**
+ * DOC: The code bit-rot problem
+ *
+ * Linux provides a rich array of features, enabling each feature
+ * however increases the size of the kernel and there are many
+ * features which users often want disabled. The traditional
+ * solution to this problem is for each feature to have its own
+ * Kconfig symbol, followed by a series of #ifdef statements
+ * in C code and header files, allowing the feature to be compiled
+ * only when desirable. As the variability of Linux increases build
+ * tests can and are often done with random kernel configurations,
+ * allyesconfig, and allmodconfig to help find code issues. This
+ * however doesn't catch all errors and as a consequence code that
+ * is typically not enabled often can suffer from bit-rot over time.
+ */
+
+/**
+ * DOC: The build-all selective-link philosophy
+ *
+ * A code architecture philosophy to help avoid code bit-rot consists
+ * of using Kconfig symbols for each subsystem feature, replace all #ifdefs
+ * by instead having each feature implemented it its own C file, and force
+ * compilation for all features. Only features that are enabled get linked in,
+ * the forced compilation therefore has no size impact on the final result of
+ * the kernel. The practice of having each feature implemented in its own C
+ * file is already prevalent in many subsystems, however #ifdefs are still
+ * typically required during feature initialization. For instance in::
+ *
+ *	#ifdef CONFIG_FOO
+ *	foo_init();
+ *	#endif
+ *
+ * We cannot remove the #ifdef and leave foo_init() as we'd either
+ * need to always enable the feature or add a respective #ifdef in a
+ * foo.h which makes foo_init() do nothing when ``CONFIG_FOO`` is disabled.
+ */
+
+/**
+ * DOC: Avoiding the code bit-rot problem with linker tables
+ *
+ * Linker tables can be used to further help avoid the code bit-rot problem
+ * when embracing the 'build-all selective-link philosophy' by lifting the
+ * requirement to use of #ifdefs during initialization. With linker tables
+ * initialization sequences can be aggregated into a custom ELF section at
+ * link time, during run time the table can be iterated over and each init
+ * sequence enabled can be called. A feature's init routine is only added to a
+ * table when its respective Kconfig symbols has been enabled and therefore
+ * linked in. Linker tables enable subsystems to completely do away with
+ * #ifdefs if one is comfortable in accepting all subsystem's feature's
+ * structural size implications.
+ *
+ * To further help with this the Linux build system supports two special
+ * targets, ``force-obj-y`` and ``force-lib-y``. A subsystem which wants to
+ * follow the 'build-all selective-link philosophy' can use these targets for a
+ * feature's kconfig symbol. Using these targets will always require
+ * compilation of the kconfig's objects if the kconfig symbol's dependencies
+ * are met but only link the objects into the kernel, and therefore enable the
+ * feature, if and only if the kconfig symbol has been enabled.
+ *
+ * Not all users or build systems may want to opt-in to compile all objects
+ * following the 'build-all selective-link philosophy', as such the targets
+ * ``force-obj-y`` and ``force-lib-y`` only force compilation when the kconfig
+ * symbol ``CONFIG_BUILD_AVOID_BITROT`` has been enabled. Disabling this feature
+ * makes ``force-obj-y`` and ``force-lib-y`` functionally equivalent to
+ * ``obj-y`` and ``lib-y`` respectively.
+ *
+ * Example use::
+ *
+ *	force-obj-$(CONFIG_FEATURE_FOO) += foo.o
+ */
+
+/**
+ * DOC: Linker table module support
+ *
+ * Modules can use linker tables, however the linker table definition
+ * must be built-in to the kernel. That is, the code that implements
+ * ``DEFINE_LINKTABLE*()`` must be built-in, and modular code cannot add
+ * more items in to the table, unless ``kernel/module.c`` find_module_sections()
+ * and module-common.lds.S are updated accordingly with a respective
+ * module notifier to account for updates. This restriction may be enhanced
+ * in the future.
+ */
+
+/**
+ * DOC: Linker table helpers
+ *
+ * These are helpers for linker tables.
+ */
+
+/**
+ * LINKTABLE_START - get address of start of linker table
+ *
+ * @name: name of the linker table
+ *
+ * This gives you the start address of the linker table.
+ * This should give you the address of the first entry.
+ *
+ */
+#define LINKTABLE_START(name)	LINUX_SECTION_START(name)
+
+/**
+ * LINKTABLE_END - get address of end of the linker table
+ *
+ * @name: name of the linker table
+ *
+ * This gives you the end address of the linker table.
+ * This will match the start address if the linker table
+ * is empty.
+ */
+#define LINKTABLE_END(name)	LINUX_SECTION_END(name)
+
+/**
+ * LINKTABLE_SIZE - get number of entries in the linker table
+ *
+ * @name: name of the linker table
+ *
+ * This gives you the number of entries in the linker table.
+ * Example usage:
+ *
+ *   unsigned int num_frobs = LINKTABLE_SIZE(frobnicator_fns);
+ */
+#define LINKTABLE_SIZE(name)					\
+	((LINKTABLE_END(name)) - (LINKTABLE_START(name)))
+
+/**
+ * LINKTABLE_EMPTY - check if linker table has no entries
+ *
+ * @name: name of linker table
+ *
+ * Returns true if the linker table is emtpy.
+ *
+ *   bool is_empty = LINKTABLE_EMPTY(frobnicator_fns);
+ */
+#define LINKTABLE_EMPTY(name)	(LINKTABLE_SIZE(name) = 0)
+
+/**
+ * LINKTABLE_ADDR_WITHIN - returns true if address is in the linker table
+ *
+ * @name: name of the linker table
+ * @addr: address to query for
+ *
+ * Returns true if the address is part of the linker table.
+ */
+#define LINKTABLE_ADDR_WITHIN(name, addr)				\
+	 (addr >= (unsigned long) LINKTABLE_START(name) &&		\
+	  addr < (unsigned long) LINKTABLE_END(name))
+
+/**
+ * LINKTABLE_ALIGNMENT - get the alignment of the linker table
+ *
+ * @name: name of linker table
+ *
+ * Gives you the alignment for the linker table.
+ */
+#define LINKTABLE_ALIGNMENT(name)	LINUX_SECTION_ALIGNMENT(name)
+
+/**
+ * DOC: Constructing linker tables
+ *
+ * Linker tables constructors are used to build an entry into a linker table.
+ * Linker table constructors exist for each type of supported section.
+ *
+ * You have weak and regular type of link table entry constructors.
+ */
+
+/**
+ * DOC: Weak linker tables constructors
+ *
+ * The weak attribute is desirable if you want an entry you can replace at
+ * link time. A very special use case for linker tables is the first entry.
+ * A weak attribute is used for the first entry to ensure that this entry's
+ * address matches the end address of the table when the linker table is
+ * emtpy, but will also point to the first real entry of the table once not
+ * empty. When the first entry is linked in, it takes place of the first entry.
+ */
+
+/**
+ * LINKTABLE_WEAK - Constructs a weak linker table entry for data
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table for data.
+ */
+#define LINKTABLE_WEAK(name, level)					\
+	      __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(".data..tbl." #name "." #level)))
+
+/**
+ * LINKTABLE_TEXT_WEAK - Constructs a weak linker table entry for execution
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table for code execution. These will be
+ * read-only.
+ */
+#define LINKTABLE_TEXT_WEAK(name, level)				\
+	const __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(".text..tbl." #name "." #level)))
+
+/**
+ * LINKTABLE_RO_WEAK - Constructs a weak read-only linker table entry
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table which only requires read-only access.
+ */
+#define LINKTABLE_RO_WEAK(name, level)					\
+	const __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL_RO_STR "..tbl." #name "." #level)))
+
+/**
+ * LINKTABLE_INIT_WEAK - Constructs a weak linker table entry for init code
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table for execution. use at init.
+ */
+#define LINKTABLE_INIT_WEAK(name, level)				\
+	const __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(".init.text..tbl." #name "." #level)))
+
+/**
+ * LINKTABLE_INIT_DATA_WEAK - Constructs a weak linker table entry for initdata
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table for data during init.
+ */
+#define LINKTABLE_INIT_DATA_WEAK(name, level)				\
+	      __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(".init.data..tbl." #name "." #level)))
+
+/**
+ * DOC: Regular linker linker table constructors
+ *
+ * Regular constructors are expected to be used for valid linker table entries.
+ * Valid uses of weak entries other than the beginning and is currently
+ * untested but should in theory work.
+ */
+
+/**
+ * LINKTABLE - Declares a data linker table entry
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a data linker table entry. These are read-write.
+ */
+#define LINKTABLE(name, level)						\
+	      __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(".data..tbl." #name "." #level)))
+
+/**
+ * LINKTABLE_TEXT - Declares a linker table entry for execution
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a linker table to be used for execution.
+ */
+#define LINKTABLE_TEXT(name, level)					\
+	const __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(".text..tbl." #name "." #level)))
+
+/**
+ * LINKTABLE_RO - Declares a read-only linker table entry.
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a linker table which only requires read-only access. Contrary
+ * to LINKTABLE_RO_WEAK() which uses SECTION_RODATA this helper uses the
+ * section SECTION_TBL_RO here due to possible toolchains bug on some
+ * architectures, for instance the c6x architicture stuffs non-weak data
+ * into different sections other than the one intended.
+ */
+#define LINKTABLE_RO(name, level)					\
+	const __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL_RO_STR "..tbl." #name "." #level)))
+
+/**
+ * LINKTABLE_INIT - Declares a linker table entry to be used on init.
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a linker table entry for execution use during init.
+ */
+#define LINKTABLE_INIT(name, level)					\
+	const __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(".init.text..tbl." #name "." #level)))
+
+/**
+ * LINKTABLE_INIT_DATA - Declares a linker table entry to be used on init data.
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a linker table entry for data during init.
+ */
+#define LINKTABLE_INIT_DATA(name, level)				\
+	      __typeof__(LINKTABLE_START(name)[0])			\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(".init.data..tbl." #name "." #level)))
+
+/**
+ * DOC: Declaring Linker tables
+ *
+ * Declarers are used to help code access the linker tables. Typically
+ * header files for subsystems would declare the linker tables to enable
+ * easy access to add new entries, and to iterate over the list of table.
+ * There are only two declarers needed given that the section association
+ * is done by the definition of the linker table using ``DEFINE_LINKTABLE*()``
+ * helpers.
+ */
+
+
+/**
+ * DECLARE_LINKTABLE - Declares a data linker table entry
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Declares a data linker table entry.
+ */
+#define DECLARE_LINKTABLE(type, name)					\
+	DECLARE_LINUX_SECTION(type, name)
+
+/**
+ * DECLARE_LINKTABLE_RO - Declares a read-only linker table entry
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Declares a read-only linker table entry.
+ */
+#define DECLARE_LINKTABLE_RO(type, name)				\
+	DECLARE_LINUX_SECTION_RO(type, name)
+
+/**
+ * DOC: Defining Linker tables
+ *
+ * Linker tables are defined in the code that takes ownership over
+ * the linker table. This is typically done in the same code that is in
+ * charge of iterating over the linker table as well.
+ */
+
+/**
+ * DEFINE_LINKTABLE - Defines a linker table for data
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table which used for data.
+ */
+#define DEFINE_LINKTABLE(type, name)					\
+	DECLARE_LINKTABLE(type, name);					\
+	LINKTABLE_WEAK(name,) LINKTABLE_START(name)[0] = {};		\
+	LINKTABLE(name, ~) LINKTABLE_END(name)[0] = {}
+
+/**
+ * DEFINE_LINKTABLE_TEXT - Declares linker table entry for exectuion
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Declares a linker table entry for execution.
+ */
+#define DEFINE_LINKTABLE_TEXT(type, name)				\
+	DECLARE_LINKTABLE_RO(type, name);				\
+	LINKTABLE_TEXT_WEAK(name,) LINKTABLE_START(name)[0] = {};	\
+	LINKTABLE_TEXT(name, ~) LINKTABLE_END(name)[0] = {}
+
+/**
+ * DEFINE_LINKTABLE_RO - Defines a read-only linker table
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table which we know only requires read-only access.
+ */
+#define DEFINE_LINKTABLE_RO(type, name)					\
+	DECLARE_LINKTABLE_RO(type, name);				\
+	LINKTABLE_RO_WEAK(name,) LINKTABLE_START(name)[0] = {};		\
+	LINKTABLE_RO(name, ~) LINKTABLE_END(name)[0] = {}
+
+/**
+ * DEFINE_LINKTABLE_INIT - Defines an init time linker table for execution
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table. If you are adding a new type you should
+ * enable ``CONFIG_DEBUG_SECTION_MISMATCH`` and ensure routines that make
+ * use of the linker tables get a respective __ref tag.
+ */
+#define DEFINE_LINKTABLE_INIT(type, name)				\
+	DECLARE_LINKTABLE_RO(type, name);				\
+	LINKTABLE_INIT_WEAK(name,) LINKTABLE_START(name)[0] = {};	\
+	LINKTABLE_INIT(name, ~) LINKTABLE_END(name)[0] = {}
+
+/**
+ * DEFINE_LINKTABLE_INIT_DATA - Defines an init time linker table for data
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table for init data. If you are adding a new type you
+ * should enable ``CONFIG_DEBUG_SECTION_MISMATCH`` and ensure routines that
+ * make use of the linker tables get a respective __ref tag.
+ */
+#define DEFINE_LINKTABLE_INIT_DATA(type, name)				\
+	DECLARE_LINKTABLE(type, name);					\
+	LINKTABLE_INIT_DATA_WEAK(name,) LINKTABLE_START(name)[0] = {};	\
+	LINKTABLE_INIT_DATA(name, ~) LINKTABLE_END(name)[0] = {}
+
+/**
+ * DOC: Iterating over Linker tables
+ *
+ * To make use of the linker tables you want to be able to iterate over
+ * them. This section documents the different iterators available.
+ */
+
+/**
+ * linktable_for_each - iterate through all entries within a linker table
+ *
+ * @pointer: entry pointer
+ * @tbl: linker table
+ *
+ * Example usage::
+ *
+ *   struct frobnicator *frob;
+ *
+ *   linktable_for_each(frob, frobnicator_fns) {
+ *     ...
+ *   }
+ */
+
+#define linktable_for_each(pointer, tbl)				\
+	for (pointer = LINKTABLE_START(tbl);				\
+	     pointer < LINKTABLE_END(tbl);				\
+	     pointer++)
+
+/**
+ * linktable_run_all - iterate and run through all entries on a linker table
+ *
+ * @tbl: linker table
+ * @func: structure name for the function name we want to call.
+ * @args...: arguments to pass to func
+ *
+ * Example usage::
+ *
+ *   linktable_run_all(frobnicator_fns, some_run,);
+ */
+#define linktable_run_all(tbl, func, args...)				\
+do {									\
+	size_t i;							\
+	for (i = 0; i < LINKTABLE_SIZE(tbl); i++)			\
+		(LINKTABLE_START(tbl)[i]).func(args);			\
+} while (0)
+
+/**
+ * linktable_run_err - run each linker table entry func and return error if any
+ *
+ * @tbl: linker table
+ * @func: structure name for the function name we want to call.
+ * @args...: arguments to pass to func
+ *
+ * Example usage::
+ *
+ *   unsigned int err = linktable_run_err(frobnicator_fns, some_run,);
+ */
+#define linktable_run_err(tbl, func, args...)				\
+({									\
+	size_t i;							\
+	int err = 0;							\
+	for (i = 0; !err && i < LINKTABLE_SIZE(tbl); i++)		\
+		err = (LINKTABLE_START(tbl)[i]).func(args);		\
+	err;								\
+})
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_LINKER_TABLES_H */
diff --git a/tools/linker-tables/.gitignore b/tools/linker-tables/.gitignore
new file mode 100644
index 000000000000..8275b0c55385
--- /dev/null
+++ b/tools/linker-tables/.gitignore
@@ -0,0 +1,2 @@
+arch/x86/kernel/vmlinux.lds
+demo
diff --git a/tools/linker-tables/Makefile b/tools/linker-tables/Makefile
new file mode 100644
index 000000000000..9d4e6fb0d176
--- /dev/null
+++ b/tools/linker-tables/Makefile
@@ -0,0 +1,184 @@
+include ../scripts/Makefile.include
+
+all:
+
+include ../scripts/utilities.mak
+
+MAKEFLAGS += --no-print-directory
+
+unexport LC_ALL
+LC_COLLATE=C
+LC_NUMERIC=C
+export LC_COLLATE LC_NUMERIC
+
+ifeq ($(srctree),)
+	srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
+
+ifneq ($(objtree),)
+#$(info Determined 'objtree' to be $(objtree))
+endif
+
+ifneq ($(OUTPUT),)
+#$(info Determined 'OUTPUT' to be $(OUTPUT))
+# Adding $(OUTPUT) as a directory to look for source files,
+# because use generated output files as sources dependency
+# for flex/bison parsers.
+VPATH += $(OUTPUT)
+export VPATH
+endif
+
+export srctree OUTPUT RM CC LD AR CFLAGS V BISON FLEX AWK
+include $(srctree)/tools/build/Makefile.include
+
+ifeq ($(V),1)
+	Q+	NQ=@true
+else
+	Q=@
+	NQ=@echo
+endif
+
+MAKEFLAGS += -r
+
+define allow-override
+  $(if $(or $(findstring environment,$(origin $(1))),\
+            $(findstring command line,$(origin $(1)))),,\
+    $(eval $(1) = $(2)))
+endef
+
+# Allow setting CC and AR and LD, or setting CROSS_COMPILE as a prefix.
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+$(call allow-override,AR,$(CROSS_COMPILE)ar)
+$(call allow-override,LD,$(CROSS_COMPILE)ld)
+
+LD += $(EXTRA_LDFLAGS)
+
+include $(srctree)/tools/scripts/Makefile.arch
+
+# Refer to README to learn how to support your architecture
+SUPPORTED_ARCHS = x86
+
+ifeq ($(filter $(ARCH),$(SUPPORTED_ARCHS)),)
+$(error Unsupported arch: $(ARCH))
+endif
+
+CFLAGS += -O2 -g
+CFLAGS += -std=gnu99 -Wall -Werror
+CFLAGS += -lpthread
+CFLAGS += -DCONFIG_KPROBES
+
+# We confine the includes used below to those we know are safe
+# for this type of hack.
+CFLAGS += -D__KERNEL__
+
+# CFLAGS += -DCONFIG_HAVE_ARCH_PS_CONST
+INCLUDES = \
+	   -I include/ \
+	   -I arch/$(ARCH)/include/ \
+	   -I ../include/ \
+	   -I ../arch/$(ARCH)/include/ \
+	   -I ../arch/$(ARCH)/include/generated/
+
+CFLAGS += $(INCLUDES)
+CFLAGS +=-Wl,-Tarch/$(ARCH)/kernel/vmlinux.lds
+
+HEADERS = \
+	  ../../include/asm-generic/section-core.h \
+	  ../../include/asm-generic/ranges.h \
+	  ../../include/asm-generic/tables.h \
+	  ../../include/linux/sections.h \
+	  ../../include/linux/ranges.h \
+	  ../../include/linux/tables.h
+
+__check_headers: $(HEADERS)
+	@$(foreach h, $(HEADERS), \
+		(test -f $(h) && ( \
+			(diff -B $(subst ../,../,$(h)) $(h) >/dev/null) \
+			|| echo "Warning: $(subst ../../,tools/,$(h)) differs from kernel" >&2 ) || true);)
+
+$(OUTPUT)arch/$(ARCH)/kernel/vmlinux.lds: arch/$(ARCH)/kernel/vmlinux.lds.S
+	$(NQ) '  LD  ' $@
+	$(Q)$(CC) $(CFLAGS) $(INCLUDES) -E -P \
+		-D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+
+# Note, we use obj-y as a convenience factor, the cmd build
+# stuff doesn't allow this magic, it resolves our depds but
+# we still need to provide a series of targets for our objects.
+# We stick to the convenient shorthand we're used to in the
+# kernel. The final object resolution build stuff is handled
+# by tool_target_obj and its caller below. This also enables
+# OUTPUT=foo-path support so you can build externally.
+obj-y += \
+	arch/$(ARCH)/kernel/head64.o \
+	arch/$(ARCH)/mm/init.o \
+	kernel/locking/mutex.o \
+	kernel/locking/spinlock.o \
+	kernel/workqueue.o \
+	kernel/main.o \
+	pci.o \
+	lib/string.o \
+	pci-quirks.o \
+	drivers/acme.o \
+	drivers/synth/main.o \
+	drivers/synth/common.o \
+	drivers/synth/or.s \
+	main.o
+
+ifeq ($(ARCH),x86)
+obj-y += \
+	arch/$(ARCH)/kernel/alternative.o \
+	arch/$(ARCH)/kernel/init.o \
+	arch/$(ARCH)/kernel/kprobes.o \
+	arch/$(ARCH)/kernel/kasan.o \
+	arch/$(ARCH)/kernel/beta.o \
+	arch/$(ARCH)/kernel/alpha.o \
+	arch/$(ARCH)/xen/init.o	\
+	drivers/xen-driver.o
+endif
+
+obj-y-out = $(patsubst %,$(OUTPUT)%,$(obj-y))
+
+__build-dir = $(subst $(OUTPUT),,$(dir $1))
+build-dir   = $(if $(__build-dir),$(__build-dir),.)
+
+build := -f $(srctree)/tools/build/Makefile.build dir=$(build-dir)
+
+define tool_target_obj
+$(1): $(subst .s,.S,$(subst .o,.c,$(patsubst $(OUTPUT)%,%,$(1))))
+	$(Q)$(MAKE) $(build) obj=$(1)
+endef
+
+$(foreach tool_obj, $(obj-y-out), \
+	$(eval $(call tool_target_obj, $(tool_obj))))
+
+$(OUTPUT)demo: $(obj-y-out)
+	$(NQ) '  CC  ' $@
+	$(Q)$(CC) $(obj-y-out) -o $@ $(CPPFLAGS) $(CFLAGS)
+
+CHECK_HEADERS := __check_headers
+PHONY += $(CHECK_HEADERS)
+
+CMD_TARGETS = $(OUTPUT)arch/$(ARCH)/kernel/vmlinux.lds $(OUTPUT)demo
+TARGETS = $(CMD_TARGETS)
+
+all: $(CHECK_HEADERS) all_cmd
+
+all_cmd: $(CMD_TARGETS)
+
+ifeq ($(OUTPUT),)
+clean_dir = ./
+else
+clean_dir = $(OUTPUT)
+endif
+
+clean::
+	$(NQ)  '  CLEAN deps'
+	$(Q)find $(clean_dir) -name \*.o \
+		-o -name \*.s \
+		-o -name \*.o.d \
+		-o -name \*.o.cmd | xargs rm -f
+	$(NQ)  '  CLEAN targets'
+	$(Q)$(foreach f, $(CMD_TARGETS), rm -f $(f);)
diff --git a/tools/linker-tables/README b/tools/linker-tables/README
new file mode 100644
index 000000000000..729241f9e4c4
--- /dev/null
+++ b/tools/linker-tables/README
@@ -0,0 +1,114 @@
+Linux linker table userspace sandbox
+==================
+
+This is a userspace sandbox to allow easy experimentation and
+test extensions with linker tables. It tries to mimic the Linux
+kernel development flow as much as possible, it however relies
+on and uses libc and is nothing but a simple stupid userspace
+application demo.
+
+You can use the sandbox to modify the kernel's linker table
+solution or add use it in creative ways without having to run
+qemu with a real kernel or user mode linux. You can simply try
+to extend this sandbox as you would for a regular userspace
+application.
+
+History
+===+
+This was hacked on first in an external repository, that tree has
+the full set of history of how this work came about. Refer to that
+tree for more details if you are interested in the logic used for
+a lot of decisions made for linker tables:
+
+https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linker-tables.git/
+
+This tree is discontinued now in favor of an upstream solution which
+is kept in sync with the kernel.
+
+Compile
+===+
+Run:
+	make
+
+Clean:
+	make clean
+
+If you need to get object files outside of the source tree:
+
+	make OUTPUT=/tmp/path/
+	make OUTPUT=/tmp/path/ clean
+
+Supported architectures
+===========+
+x86_64
+
+Currently only x86_64 is supported for the demo. It should be
+relatively easy to add more. To add a new architecture you need
+a toolchain available with libc. You then need to generate a
+respective base template custom linker script for userspace
+as is provided on x86 in arch/x86/kernel/vmlinux.lds.S.
+
+A respective architecture tools/arch/$(ARCH)/include/* file for
+each section-core.h, ranges.h, tables.h will need to be provided
+as well. If your architecture's file is generated copy the generated
+file over.
+
+x86 Simulated boots
+=========+
+This programs simulates boot on both bare metal and with the
+Xen PV entry on x86.
+
+Emulate bare metal boot:
+
+./demo
+
+Emulate Xen boot (x86):
+
+./demo -x
+
+Testing new features
+==========
+
+A copy of each kernel header file is maintained in tools/include/,
+as well as a respective generated asm file for each sandbox supported
+architecture. This sandbox has a built in checker for when these files
+get out of sync.
+
+If testing new extensions on the files:
+
+  o section-core
+  o ranges.h
+  o tables.h
+
+You'll want to copy them into tools as well. If you are working on
+using these files you can work within the current directory's namespace,
+including its own set of header files, so tools/linker-tables/include/ and
+each respective tools/linker-tables/arch/$(ARCH)/include/asm/.
+
+Features evaluation
+=========+
+This lists features currently being evaluated in the sandbox, not yet
+present upstream. These make use of the existing set of header files
+without modification.
+
+ o Demo use of initialization on for x86, refer to arch/x86/kernel/init.c
+
+ o Demo use of porting the kernel's init call levels to linker tables, refer
+   to the init_calls linker table use on kernel/main.c
+
+ o Demo use of an asm-generic architecture init family, which could potentially
+   be used to help share initialization sequences on simple architectures.
+   Refer to include/asm-generic/arch_init_fn.h
+
+ o Building synthetic routines with the option to provide enhancements
+   per architecture in asm, refer to drivers/synth/or.S and its use on
+   synth_init_or().
+
+ o User of linker tables for alternatives with consts - refer to
+   use of the ps_set_const_table linker table and its use in
+   arch/x86/kernel/alternative.c
diff --git a/tools/linker-tables/arch/x86/include/asm/asm.h b/tools/linker-tables/arch/x86/include/asm/asm.h
new file mode 100644
index 000000000000..155a52920dfb
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/asm.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_X86_ASM_H
+
+#ifdef __ASSEMBLY__
+# define __ASM_FORM(x)	x
+# define __ASM_FORM_RAW(x)     x
+# define __ASM_FORM_COMMA(x) x,
+#else
+# define __ASM_FORM(x)	" " #x " "
+# define __ASM_FORM_RAW(x)     #x
+# define __ASM_FORM_COMMA(x) " " #x ","
+#endif
+
+# define __ASM_SEL(a,b) __ASM_FORM(b)
+# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
+#define _ASM_PTR	__ASM_SEL(.long, .quad)
+
+#endif /* _ASM_X86_ASM_H */
diff --git a/tools/linker-tables/arch/x86/include/asm/boot.h b/tools/linker-tables/arch/x86/include/asm/boot.h
new file mode 100644
index 000000000000..af91b94ad5a6
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/boot.h
@@ -0,0 +1 @@
+extern struct boot_params boot_params;
diff --git a/tools/linker-tables/arch/x86/include/asm/bootparam.h b/tools/linker-tables/arch/x86/include/asm/bootparam.h
new file mode 100644
index 000000000000..a7ef34216f7f
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/bootparam.h
@@ -0,0 +1,32 @@
+#ifndef __BOOTPARAM_H
+#define __BOOTPARAM_H
+
+#include <linux/types.h>
+
+struct setup_header {
+	__u32 hardware_subarch;
+} __attribute__((packed));
+
+struct boot_params {
+	struct setup_header hdr;
+} __attribute__((packed));
+
+enum {
+	X86_SUBARCH_PC = 0,
+	X86_SUBARCH_LGUEST,
+	X86_SUBARCH_XEN,
+	X86_SUBARCH_INTEL_MID,
+	X86_SUBARCH_CE4100,
+	X86_NR_SUBARCHS,
+};
+
+#define X86_SUBARCH_ALL_SUBARCHS 	\
+	(				\
+	BIT(X86_SUBARCH_PC) |		\
+	BIT(X86_SUBARCH_LGUEST) |	\
+	BIT(X86_SUBARCH_XEN) |		\
+	BIT(X86_SUBARCH_INTEL_MID) |	\
+	BIT(X86_SUBARCH_CE4100)		\
+	)
+
+#endif /* __BOOTPARAM_H */
diff --git a/tools/linker-tables/arch/x86/include/asm/kprobes.h b/tools/linker-tables/arch/x86/include/asm/kprobes.h
new file mode 100644
index 000000000000..f702fc359efe
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/kprobes.h
@@ -0,0 +1,7 @@
+#ifndef _SANDBOX_ASM_X86_KPROBES_H
+#define _SANDBOX_ASM_X86_KPROBES_H
+
+/* This is all we need for the demo */
+#include <asm-generic/kprobes.h>
+
+#endif /* _SANDBOX_ASM_X86_KPROBES_H */
diff --git a/tools/linker-tables/arch/x86/include/asm/ps_const.h b/tools/linker-tables/arch/x86/include/asm/ps_const.h
new file mode 100644
index 000000000000..3847f03fca92
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/ps_const.h
@@ -0,0 +1,23 @@
+#ifndef __X86_PS_CONST
+#define __X86_PS_CONST
+
+#include <linux/stringify.h>
+#include <linux/tables.h>
+#include <asm/asm.h>
+
+#define ps_shr(in, _func)						\
+({									\
+	 __typeof__(in) _count;						\
+									\
+	asm volatile(							\
+		"shr %P[_in],%[_count]\n"				\
+		"1:\n"							\
+		push_section_tbl(.init.data, ps_set_const_table, 01,)	\
+		_ASM_PTR "1b-1, %P2, %P3\n"				\
+		".popsection\n"						\
+		: [_count] "=g" (_count)				\
+		: [_in] "i" (in), "i" (SET_CONST_U8), "i" (_func));	\
+	(_count);							\
+})
+
+#endif /* __X86_PS_CONST */
diff --git a/tools/linker-tables/arch/x86/include/asm/ranges.h b/tools/linker-tables/arch/x86/include/asm/ranges.h
new file mode 100644
index 000000000000..823789d2b010
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/ranges.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_X86_RANGES_H
+#define _ASM_X86_RANGES_H
+
+#include <asm-generic/ranges.h>
+
+#endif  /* _ASM_X86_RANGES_H */
diff --git a/tools/linker-tables/arch/x86/include/asm/section-core.h b/tools/linker-tables/arch/x86/include/asm/section-core.h
new file mode 100644
index 000000000000..06be2b1c424f
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/section-core.h
@@ -0,0 +1 @@
+#include <asm-generic/section-core.h>
diff --git a/tools/linker-tables/arch/x86/include/asm/setup.h b/tools/linker-tables/arch/x86/include/asm/setup.h
new file mode 100644
index 000000000000..366c36bd2910
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/setup.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_X86_USER_SETUP_H
+#define __LINUX_X86_USER_SETUP_H
+
+/* I'm lazy */
+
+#endif /* __LINUX_X86_USER_SETUP_H */
diff --git a/tools/linker-tables/arch/x86/include/asm/tables.h b/tools/linker-tables/arch/x86/include/asm/tables.h
new file mode 100644
index 000000000000..797df3407ee1
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/tables.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_X86_TABLES_H
+#define _ASM_X86_TABLES_H
+
+#include <asm-generic/tables.h>
+
+#endif  /* _ASM_X86_RANGES_H */
diff --git a/tools/linker-tables/arch/x86/include/asm/x86.h b/tools/linker-tables/arch/x86/include/asm/x86.h
new file mode 100644
index 000000000000..680c1141e0de
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/x86.h
@@ -0,0 +1,4 @@
+int startup_64(void);
+int x86_64_start_reservations(void);
+void setup_arch(void);
+void late_init(void);
diff --git a/tools/linker-tables/arch/x86/include/asm/x86_init_fn.h b/tools/linker-tables/arch/x86/include/asm/x86_init_fn.h
new file mode 100644
index 000000000000..afece8ce6dd4
--- /dev/null
+++ b/tools/linker-tables/arch/x86/include/asm/x86_init_fn.h
@@ -0,0 +1,169 @@
+#ifndef __X86_INIT_TABLES_H
+#define __X86_INIT_TABLES_H
+
+#include <linux/types.h>
+#include <linux/tables.h>
+
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <asm/bootparam.h>
+
+/**
+ * struct x86_init_fn - x86 generic kernel init call
+ *
+ * Linux x86 features vary in complexity, features may require work done at
+ * different levels of the full x86 init sequence. Today there are also two
+ * different possible entry points for Linux on x86, one for bare metal, KVM
+ * and Xen HVM, and another for Xen PV guests / dom0.  Assuming a bootloader
+ * has set up 64-bit mode, roughly the x86 init sequence follows this path:
+ *
+ * Bare metal, KVM, Xen HVM                      Xen PV / dom0
+ *       startup_64()                             startup_xen()
+ *              \                                     /
+ *      x86_64_start_kernel()                 xen_start_kernel()
+ *                           \               /
+ *                      x86_64_start_reservations()
+ *                                   |
+ *                              start_kernel()
+ *                              [   ...        ]
+ *                              [ setup_arch() ]
+ *                              [   ...        ]
+ *                                  init
+ *
+ * x86_64_start_kernel() and xen_start_kernel() are the respective first C code
+ * entry starting points. The different entry points exist to enable Xen to
+ * skip a lot of hardware setup already done and managed on behalf of the
+ * hypervisor, we refer to this as "paravirtualization yielding". The different
+ * levels of init calls on the x86 init sequence exist to account for these
+ * slight differences and requirements. These different entry points also share
+ * a common entry x86 specific path, x86_64_start_reservations().
+ *
+ * A generic x86 feature can have different initialization calls, one on each
+ * of the different main x86 init sequences, but must also address both entry
+ * points in order to work properly across the board on all supported x86
+ * subarchitectures. Since x86 features can also have dependencies on other
+ * setup code or features, x86 features can at times be subordinate to other
+ * x86 features, or conditions. struct x86_init_fn enables feature developers
+ * to annotate dependency relationships to ensure subsequent init calls only
+ * run once a subordinate's dependencies have run. When needed custom
+ * dependency requirements can also be spelled out through a custom dependency
+ * checker. In order to account for the dual entry point nature of x86-64 Linux
+ * for "paravirtualization yielding" and to make annotations for support for
+ * these explicit each struct x86_init_fn must specify supported
+ * subarchitectures. The earliest x86-64 code can read the subarchitecture
+ * though is after load_idt(), as such the earliest we can currently rely on
+ * subarchitecture for semantics and a common init sequences is on the shared
+ * common x86_64_start_reservations().  Each struct x86_init_fn is associated
+ * with a specific special link order number which has been careflly thought
+ * out by x86 maintainers. You should pick a link order level associated with
+ * the specific directory your code lies in, a respective macro is used to
+ * build association to a link oder with a routine, you should use one of the
+ * provided x86_init_*() macros. You should not use __x86_init() directly.
+ *
+ * x86_init_fn enables strong semantics and dependencies to be defined and
+ * implemented on the full x86 initialization sequence.
+ *
+ * @supp_hardware_subarch: must be set, it represents the bitmask of supported
+ *	subarchitectures.  We require each struct x86_init_fn to have this set
+ *	to require developer considerations for each supported x86
+ *	subarchitecture and to build strong annotations of different possible
+ *	run time states particularly in consideration for the two main
+ *	different entry points for x86 Linux, to account for paravirtualization
+ *	yielding.
+ *
+ *	The subarchitecture is read by the kernel at early boot from the
+ *	struct boot_params hardware_subarch. Support for the subarchitecture
+ *	exists as of x86 boot protocol 2.07. The bootloader would have set up
+ *	the respective hardware_subarch on the boot sector as per
+ *	Documentation/x86/boot.txt.
+ *
+ *	What x86 entry point is used is determined at run time by the
+ *	bootloader. Linux pv_ops was designed to help enable to build one Linux
+ *	binary to support bare metal and different hypervisors.  pv_ops setup
+ *	code however is limited in that all pv_ops setup code is run late in
+ *	the x86 init sequence, during setup_arch(). In fact cpu_has_hypervisor
+ *	only works after early_cpu_init() during setup_arch(). If an x86
+ *	feature requires an earlier determination of what hypervisor was used,
+ *	or if it needs to annotate only support for certain hypervisors, the
+ *	x86 hardware_subarch should be set by the bootloader and
+ *	@supp_hardware_subarch set by the x86 feature. Using hardware_subarch
+ *	enables x86 features to fill the semantic gap between the Linux x86
+ *	entry point used and what pv_ops has to offer through a hypervisor
+ *	agnostic mechanism.
+ *
+ *	Each supported subarchitecture is set using the respective
+ *	X86_SUBARCH_* as a bit in the bitmask. For instance if a feature
+ *	is supported on PC and Xen subarchitectures only you would set this
+ *	bitmask to:
+ *
+ *		BIT(X86_SUBARCH_PC) |
+ *		BIT(X86_SUBARCH_XEN);
+ *
+ * @early_init: required, routine which will run in x86_64_start_reservations()
+ *	after we ensure boot_params.hdr.hardware_subarch is accessible and
+ *	properly set. Memory is not yet available. This the earliest we can
+ *	currently define a common shared callback since all callbacks need to
+ *	check for boot_params.hdr.hardware_subarch and this becomes accessible
+ *	on x86-64 until after load_idt().
+ */
+struct x86_init_fn {
+	__u32 supp_hardware_subarch;
+	void (*early_init)(void);
+};
+
+DECLARE_LINKTABLE(struct x86_init_fn, x86_init_fns);
+
+/* Init order levels, we can start at 0000 but reserve 0000-0999 for now */
+
+/*
+ * X86_INIT_ORDER_EARLY - early kernel init code
+ *
+ * This consists of the first parts of the Linux kernel executed.
+ */
+#define X86_INIT_ORDER_EARLY	1000
+
+/* X86_INIT_ORDER_PLATFORM - platform kernel code
+ *
+ * Code the kernel needs to initialize under arch/x86/platform/
+ * early in boot.
+ */
+#define X86_INIT_ORDER_PLATFORM	3000
+
+#define __x86_init(__level,						\
+		   __supp_hardware_subarch,				\
+		   __early_init)					\
+	static LINKTABLE_INIT_DATA(x86_init_fns, __level)		\
+	__x86_init_fn_##__early_init = {				\
+		.supp_hardware_subarch = __supp_hardware_subarch,	\
+		.early_init = __early_init,				\
+	};
+
+#define x86_init_early(__supp_hardware_subarch,				\
+		       __early_init)					\
+	__x86_init(X86_INIT_ORDER_EARLY, __supp_hardware_subarch,	\
+		   __early_init);
+
+#define x86_init_platform(__supp_hardware_subarch,			\
+		       __early_init)					\
+	__x86_init(__name, X86_INIT_ORDER_PLATFORM, __supp_hardware_subarch,\
+		   __early_init);
+
+#define x86_init_early_all(__early_init)				\
+	x86_init_early(X86_SUBARCH_ALL_SUBARCHS,			\
+		       __early_init);
+
+#define x86_init_early_pc(__early_init)					\
+	x86_init_early(BIT(X86_SUBARCH_PC),				\
+		       __early_init);
+
+#define x86_init_early_xen(__early_init)				\
+	x86_init_early(BIT(X86_SUBARCH_XEN),				\
+		       __early_init);
+/**
+ * x86_init_fn_early_init: call all early_init() callbacks
+ *
+ * This calls all early_init() callbacks on the x86_init_fns linker table.
+ */
+void x86_init_fn_early_init(void);
+
+#endif /* __X86_INIT_TABLES_H */
diff --git a/tools/linker-tables/arch/x86/kernel/alpha.c b/tools/linker-tables/arch/x86/kernel/alpha.c
new file mode 100644
index 000000000000..477227d817a3
--- /dev/null
+++ b/tools/linker-tables/arch/x86/kernel/alpha.c
@@ -0,0 +1,10 @@
+#include <linux/kernel.h>
+#include <asm/x86_init_fn.h>
+
+static void early_init_alpha(void)
+{
+	pr_info("Initializing alpha ...\n");
+	pr_info("Completed initializing alpha !\n");
+}
+
+x86_init_early_pc(early_init_alpha);
diff --git a/tools/linker-tables/arch/x86/kernel/alternative.c b/tools/linker-tables/arch/x86/kernel/alternative.c
new file mode 100644
index 000000000000..380c184172b3
--- /dev/null
+++ b/tools/linker-tables/arch/x86/kernel/alternative.c
@@ -0,0 +1,31 @@
+#include <asm/x86_init_fn.h>
+
+#include <linux/kernel.h>
+#include <linux/ps_const.h>
+
+void apply_alternatives_linker_tables(void)
+{
+	unsigned int num_consts = LINKTABLE_SIZE(ps_set_const_table);
+	struct ps_set_const *ps_const;
+
+	if (!num_consts)
+		return;
+
+	pr_debug("Number of init entries: %d\n", num_consts);
+
+	linktable_for_each(ps_const, ps_set_const_table) {
+		switch (ps_const->type) {
+		case SET_CONST_U8:
+			*ps_const->count = (__u8) ps_const->func();
+			break;
+		case SET_CONST_U16:
+			*ps_const->count = (__u16) ps_const->func();
+			break;
+		case SET_CONST_U32:
+			*ps_const->count = (__u16) ps_const->func();
+			break;
+		}
+	}
+}
+
+x86_init_early_pc(apply_alternatives_linker_tables);
diff --git a/tools/linker-tables/arch/x86/kernel/beta.c b/tools/linker-tables/arch/x86/kernel/beta.c
new file mode 100644
index 000000000000..6cbbb3144928
--- /dev/null
+++ b/tools/linker-tables/arch/x86/kernel/beta.c
@@ -0,0 +1,10 @@
+#include <linux/kernel.h>
+#include <asm/x86_init_fn.h>
+
+static void early_init_beta(void)
+{
+	pr_info("Initializing beta ...\n");
+	pr_info("Completed initializing beta !\n");
+}
+
+x86_init_early_pc(early_init_beta);
diff --git a/tools/linker-tables/arch/x86/kernel/head64.c b/tools/linker-tables/arch/x86/kernel/head64.c
new file mode 100644
index 000000000000..d14dcdfd0ea9
--- /dev/null
+++ b/tools/linker-tables/arch/x86/kernel/head64.c
@@ -0,0 +1,58 @@
+#include <linux/kernel.h>
+#include <linux/tables.h>
+
+#include <asm/x86_init_fn.h>
+#include <asm/boot.h>
+#include <asm/bootparam.h>
+
+#include <linux/start_kernel.h>
+#include <linux/kasan.h>
+
+void x86_64_start_reservations(void)
+{
+	switch (boot_params.hdr.hardware_subarch) {
+	case X86_SUBARCH_PC:
+		pr_info("Booting bare metal\n");
+		break;
+	case X86_SUBARCH_LGUEST:
+		pr_info("Booting lguest not supported\n");
+		BUG();
+	case X86_SUBARCH_XEN:
+		pr_info("Booting a Xen guest\n");
+		break;
+	case X86_SUBARCH_INTEL_MID:
+		pr_info("Booting Intel MID not supported\n");
+		BUG();
+	case X86_SUBARCH_CE4100:
+		pr_info("Booting Intel CE4100 not supported\n");
+		BUG();
+	default:
+		pr_info("Booting sunsupported x86 hardware subarch\n");
+		BUG();
+	}
+
+	start_kernel();
+}
+
+static void x86_64_start_kernel(void)
+{
+	x86_init_fn_early_init();
+
+	x86_64_start_reservations();
+}
+
+void startup_64(void)
+{
+	pr_info("Initializing x86 bare metal world\n");
+	x86_64_start_kernel();
+}
+
+void setup_arch(void)
+{
+	/* TODO: x86_init_fn_setup_arch(); */
+}
+
+void late_init(void)
+{
+	/* TODO: x86_init_fn_late_init(); */
+}
diff --git a/tools/linker-tables/arch/x86/kernel/init.c b/tools/linker-tables/arch/x86/kernel/init.c
new file mode 100644
index 000000000000..1eed92d1acb2
--- /dev/null
+++ b/tools/linker-tables/arch/x86/kernel/init.c
@@ -0,0 +1,42 @@
+#define pr_fmt(fmt) "x86-init: " fmt
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+#include <asm/x86_init_fn.h>
+#include <asm/bootparam.h>
+#include <asm/boot.h>
+#include <asm/setup.h>
+
+DEFINE_LINKTABLE_INIT_DATA(struct x86_init_fn, x86_init_fns);
+
+static bool x86_init_fn_supports_subarch(struct x86_init_fn *fn)
+{
+	if (!fn->supp_hardware_subarch) {
+		//pr_err("Init sequence fails to declares any supported subarchs: %pF\n", fn->early_init);
+		WARN_ON(1);
+	}
+	if (BIT(boot_params.hdr.hardware_subarch) & fn->supp_hardware_subarch)
+		return true;
+	return false;
+}
+
+void __ref x86_init_fn_early_init(void)
+{
+	struct x86_init_fn *init_fn;
+	unsigned int num_inits = LINKTABLE_SIZE(x86_init_fns);
+
+	if (!num_inits)
+		return;
+
+	pr_debug("Number of init entries: %d\n", num_inits);
+
+	linktable_for_each(init_fn, x86_init_fns) {
+		if (!x86_init_fn_supports_subarch(init_fn))
+			continue;
+
+		//pr_debug("Running early init %pF ...\n", init_fn->early_init);
+		init_fn->early_init();
+		//pr_debug("Completed early init %pF\n", init_fn->early_init);
+	}
+}
diff --git a/tools/linker-tables/arch/x86/kernel/kasan.c b/tools/linker-tables/arch/x86/kernel/kasan.c
new file mode 100644
index 000000000000..a1e6a5b72c23
--- /dev/null
+++ b/tools/linker-tables/arch/x86/kernel/kasan.c
@@ -0,0 +1,11 @@
+#include <linux/kernel.h>
+#include <asm/x86_init_fn.h>
+
+void kasan_early_init(void)
+{
+	pr_info("Initializing kasan ...\n");
+	pr_info("Early init for Kasan...\n");
+	pr_info("Completed initializing kasan !\n");
+}
+
+x86_init_early_pc(kasan_early_init);
diff --git a/tools/linker-tables/arch/x86/kernel/kprobes.c b/tools/linker-tables/arch/x86/kernel/kprobes.c
new file mode 100644
index 000000000000..c4e42beae55b
--- /dev/null
+++ b/tools/linker-tables/arch/x86/kernel/kprobes.c
@@ -0,0 +1,51 @@
+#include <linux/kernel.h>
+#include <linux/tables.h>
+#include <asm/x86_init_fn.h>
+#include <linux/ranges.h>
+#include <linux/kprobes.h>
+
+DEFINE_SECTION_RANGE(kprobes, .text);
+
+void __kprobes test_kprobe_0001(void)
+{
+	pr_info("test_kprobe\n");
+}
+
+void test_kprobe_0002(void)
+{
+	pr_info("test_kprobe\n");
+}
+
+void test_kprobe_addr(const char *test, unsigned long addr, bool should_match)
+{
+	if (SECTION_RANGE_ADDR_WITHIN(kprobes, addr))
+		if (should_match)
+			pr_info("= OK: %s within range!\n", test);
+		else
+			pr_info("= FAIL: %s should not be in range...\n",
+				test);
+	else
+		if (should_match)
+			pr_info("= FAIL: %s should be in range...\n", test);
+		else
+			pr_info("= OK: %s not in range as expected!\n", test);
+}
+
+void early_init_kprobes(void)
+{
+	unsigned long addr;
+
+	pr_info("Initializing kprobes ...\n");
+
+	addr = (unsigned long) &test_kprobe_0001;
+
+	test_kprobe_addr("test_kprobe_0001", addr, true);
+
+	addr = (unsigned long) &test_kprobe_0002;
+
+	test_kprobe_addr("test_kprobe_0002", addr, false);
+
+	pr_info("Completed initializing kprobes !\n");
+}
+
+x86_init_early_all(early_init_kprobes);
diff --git a/tools/linker-tables/arch/x86/kernel/vmlinux.lds.S b/tools/linker-tables/arch/x86/kernel/vmlinux.lds.S
new file mode 100644
index 000000000000..783735fb897a
--- /dev/null
+++ b/tools/linker-tables/arch/x86/kernel/vmlinux.lds.S
@@ -0,0 +1,277 @@
+/* Script for -z combreloc: combine and sort reloc sections */
+/* Copyright (C) 2014 Free Software Foundation, Inc.
+   Copying and distribution of this script, with or without modification,
+   are permitted in any medium without royalty provided the copyright
+   notice and this notice are preserved.  */
+
+#include <asm/section-core.h>
+#include <asm/ranges.h>
+#include <asm/tables.h>
+
+OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64",
+	      "elf64-x86-64")
+OUTPUT_ARCH(i386:x86-64)
+ENTRY(_start)
+SECTIONS
+{
+  /* Read-only sections, merged into text segment: */
+  PROVIDE (__executable_start = SEGMENT_START("text-segment", 0x400000)); . = SEGMENT_START("text-segment", 0x400000) + SIZEOF_HEADERS;
+  .interp         : { *(.interp) }
+  .note.gnu.build-id : { *(.note.gnu.build-id) }
+  .hash           : { *(.hash) }
+  .gnu.hash       : { *(.gnu.hash) }
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+  .rela.dyn       :
+    {
+      *(.rela.init)
+      *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*)
+      *(.rela.fini)
+      *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*)
+      *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*)
+      *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*)
+      *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*)
+      *(.rela.ctors)
+      *(.rela.dtors)
+      *(.rela.got)
+      *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*)
+      *(.rela.ldata .rela.ldata.* .rela.gnu.linkonce.l.*)
+      *(.rela.lbss .rela.lbss.* .rela.gnu.linkonce.lb.*)
+      *(.rela.lrodata .rela.lrodata.* .rela.gnu.linkonce.lr.*)
+      *(.rela.ifunc)
+    }
+  .rela.plt       :
+    {
+      *(.rela.plt)
+      PROVIDE_HIDDEN (__rela_iplt_start = .);
+      *(.rela.iplt)
+      PROVIDE_HIDDEN (__rela_iplt_end = .);
+    }
+  .init           :
+  {
+    KEEP (*(SORT_NONE(.init)))
+  }
+  .plt            : { *(.plt) *(.iplt) }
+  .plt.bnd        : { *(.plt.bnd) }
+  .text           :
+  {
+    *(.text.unlikely .text.*_unlikely .text.unlikely.*)
+    *(.text.exit .text.exit.*)
+    *(.text.startup .text.startup.*)
+    *(.text.hot .text.hot.*)
+
+    *(SORT(.text..rng.*))
+    *(SORT(.text..tbl.*))
+
+    *(SORT(.init.text..rng.*))
+    *(SORT(.init.text..tbl.*))
+
+    *(SORT(.initcall..rng.*))
+    *(SORT(.initcall..tbl.*))
+
+    *(SORT(.exit.text..rng.*))
+    *(SORT(.exit.text..tbl.*))
+
+    *(SORT(.exitcall.exit..rng.*))
+    *(SORT(.exitcall.exit..tbl.*))
+
+    *(.text .stub .text.* .gnu.linkonce.t.*)
+    /* .gnu.warning sections are handled specially by elf32.em.  */
+    *(.gnu.warning)
+  }
+  .fini           :
+  {
+    KEEP (*(SORT_NONE(.fini)))
+  }
+  PROVIDE (__etext = .);
+  PROVIDE (_etext = .);
+  PROVIDE (etext = .);
+  .rodata         :
+  {
+	*(.rodata)
+
+	*(SORT(.rodata.*))
+
+	*(SORT(.rodata..rng.*))
+	*(SORT(.rodata..tbl.*))
+
+	*(SORT(.init.rodata..rng.*))
+	*(SORT(.init.rodata..tbl.*))
+
+	*(SORT(.ref.rodata..rng.*))
+	*(SORT(.ref.rodata..tbl.*))
+
+	*(.gnu.linkonce.r.*)
+  }
+  .rodata1        : { *(.rodata1) }
+  .eh_frame_hdr : { *(.eh_frame_hdr) }
+  .eh_frame       : ONLY_IF_RO { KEEP (*(.eh_frame)) }
+  .gcc_except_table   : ONLY_IF_RO { *(.gcc_except_table
+  .gcc_except_table.*) }
+  /* These sections are generated by the Sun/Oracle C++ compiler.  */
+  .exception_ranges   : ONLY_IF_RO { *(.exception_ranges
+  .exception_ranges*) }
+  /* Adjust the address for the data segment.  We want to adjust up to
+     the same address within the page on the next page up.  */
+  . = ALIGN (CONSTANT (MAXPAGESIZE)) - ((CONSTANT (MAXPAGESIZE) - .) & (CONSTANT (MAXPAGESIZE) - 1)); . = DATA_SEGMENT_ALIGN (CONSTANT (MAXPAGESIZE), CONSTANT (COMMONPAGESIZE));
+  /* Exception handling  */
+  .eh_frame       : ONLY_IF_RW { KEEP (*(.eh_frame)) }
+  .gcc_except_table   : ONLY_IF_RW { *(.gcc_except_table .gcc_except_table.*) }
+  .exception_ranges   : ONLY_IF_RW { *(.exception_ranges .exception_ranges*) }
+  /* Thread Local Storage sections  */
+  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
+  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
+  .preinit_array     :
+  {
+    PROVIDE_HIDDEN (__preinit_array_start = .);
+    KEEP (*(.preinit_array))
+    PROVIDE_HIDDEN (__preinit_array_end = .);
+  }
+  .init_array     :
+  {
+    PROVIDE_HIDDEN (__init_array_start = .);
+    KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
+    KEEP (*(.init_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .ctors))
+    PROVIDE_HIDDEN (__init_array_end = .);
+  }
+  .fini_array     :
+  {
+    PROVIDE_HIDDEN (__fini_array_start = .);
+    KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.*) SORT_BY_INIT_PRIORITY(.dtors.*)))
+    KEEP (*(.fini_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .dtors))
+    PROVIDE_HIDDEN (__fini_array_end = .);
+  }
+  .ctors          :
+  {
+    /* gcc uses crtbegin.o to find the start of
+       the constructors, so we make sure it is
+       first.  Because this is a wildcard, it
+       doesn't matter if the user does not
+       actually link against crtbegin.o; the
+       linker won't look for a file to match a
+       wildcard.  The wildcard also means that it
+       doesn't matter which directory crtbegin.o
+       is in.  */
+    KEEP (*crtbegin.o(.ctors))
+    KEEP (*crtbegin?.o(.ctors))
+    /* We don't want to include the .ctor section from
+       the crtend.o file until after the sorted ctors.
+       The .ctor section from the crtend file contains the
+       end of ctors marker and it must be last */
+    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .ctors))
+    KEEP (*(SORT(.ctors.*)))
+    KEEP (*(.ctors))
+  }
+  .dtors          :
+  {
+    KEEP (*crtbegin.o(.dtors))
+    KEEP (*crtbegin?.o(.dtors))
+    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors))
+    KEEP (*(SORT(.dtors.*)))
+    KEEP (*(.dtors))
+  }
+  .jcr            : { KEEP (*(.jcr)) }
+  .data.rel.ro : { *(.data.rel.ro.local* .gnu.linkonce.d.rel.ro.local.*) *(.data.rel.ro .data.rel.ro.* .gnu.linkonce.d.rel.ro.*) }
+  .dynamic        : { *(.dynamic) }
+  .got            : { *(.got) *(.igot) }
+  . = DATA_SEGMENT_RELRO_END (SIZEOF (.got.plt) >= 24 ? 24 : 0, .);
+  .got.plt        : { *(.got.plt)  *(.igot.plt) }
+  .data           :
+  {
+    *(.data .data.* .gnu.linkonce.d.*)
+
+    *(SORT(.data..rng.*))
+    *(SORT(.data..tbl.*))
+
+    *(SORT(.init.data..rng.*))
+    *(SORT(.init.data..tbl.*))
+
+    *(SORT(.ref.rodata..rng.*))
+    *(SORT(.ref.rodata..tbl.*))
+
+    *(SORT(.exit.data..rng.*))
+    *(SORT(.exit.data..tbl.*))
+
+    SORT(CONSTRUCTORS)
+  }
+  .data1          : { *(.data1) }
+  _edata = .; PROVIDE (edata = .);
+  . = .;
+
+  __bss_start = .;
+  .bss            :
+  {
+   *(.dynbss)
+   *(.bss .bss.* .gnu.linkonce.b.*)
+   *(COMMON)
+   /* Align here to ensure that the .bss section occupies space up to
+      _end.  Align after .bss to ensure correct alignment even if the
+      .bss section disappears because there are no input sections.
+      FIXME: Why do we need it? When there is no .bss section, we don't
+      pad the .data section.  */
+   . = ALIGN(. != 0 ? 64 / 8 : 1);
+  }
+  .lbss   :
+  {
+    *(.dynlbss)
+    *(.lbss .lbss.* .gnu.linkonce.lb.*)
+    *(LARGE_COMMON)
+  }
+  . = ALIGN(64 / 8);
+  . = SEGMENT_START("ldata-segment", .);
+  .lrodata   ALIGN(CONSTANT (MAXPAGESIZE)) + (. & (CONSTANT (MAXPAGESIZE) - 1)) :
+  {
+    *(.lrodata .lrodata.* .gnu.linkonce.lr.*)
+  }
+  .ldata   ALIGN(CONSTANT (MAXPAGESIZE)) + (. & (CONSTANT (MAXPAGESIZE) - 1)) :
+  {
+    *(.ldata .ldata.* .gnu.linkonce.l.*)
+    . = ALIGN(. != 0 ? 64 / 8 : 1);
+  }
+  . = ALIGN(64 / 8);
+  _end = .; PROVIDE (end = .);
+  . = DATA_SEGMENT_END (.);
+  /* Stabs debugging sections.  */
+  .stab          0 : { *(.stab) }
+  .stabstr       0 : { *(.stabstr) }
+  .stab.excl     0 : { *(.stab.excl) }
+  .stab.exclstr  0 : { *(.stab.exclstr) }
+  .stab.index    0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment       0 : { *(.comment) }
+  /* DWARF debug sections.
+     Symbols in the DWARF debugging sections are relative to the beginning
+     of the section so we begin them at 0.  */
+  /* DWARF 1 */
+  .debug          0 : { *(.debug) }
+  .line           0 : { *(.line) }
+  /* GNU DWARF 1 extensions */
+  .debug_srcinfo  0 : { *(.debug_srcinfo) }
+  .debug_sfnames  0 : { *(.debug_sfnames) }
+  /* DWARF 1.1 and DWARF 2 */
+  .debug_aranges  0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+  /* DWARF 2 */
+  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
+  .debug_abbrev   0 : { *(.debug_abbrev) }
+  .debug_line     0 : { *(.debug_line .debug_line.* .debug_line_end ) }
+  .debug_frame    0 : { *(.debug_frame) }
+  .debug_str      0 : { *(.debug_str) }
+  .debug_loc      0 : { *(.debug_loc) }
+  .debug_macinfo  0 : { *(.debug_macinfo) }
+  /* SGI/MIPS DWARF 2 extensions */
+  .debug_weaknames 0 : { *(.debug_weaknames) }
+  .debug_funcnames 0 : { *(.debug_funcnames) }
+  .debug_typenames 0 : { *(.debug_typenames) }
+  .debug_varnames  0 : { *(.debug_varnames) }
+  /* DWARF 3 */
+  .debug_pubtypes 0 : { *(.debug_pubtypes) }
+  .debug_ranges   0 : { *(.debug_ranges) }
+  /* DWARF Extension.  */
+  .debug_macro    0 : { *(.debug_macro) }
+  .gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
+  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }
+}
diff --git a/tools/linker-tables/arch/x86/mm/init.c b/tools/linker-tables/arch/x86/mm/init.c
new file mode 100644
index 000000000000..33e5700e2864
--- /dev/null
+++ b/tools/linker-tables/arch/x86/mm/init.c
@@ -0,0 +1,11 @@
+#include <linux/kernel.h>
+#include <asm/x86_init_fn.h>
+
+static void early_init_memory(void)
+{
+	pr_info("Initializing memory ...\n");
+	sleep(1);
+	pr_info("Completed initializing memory !\n");
+}
+
+x86_init_early_all(early_init_memory);
diff --git a/tools/linker-tables/arch/x86/xen/init.c b/tools/linker-tables/arch/x86/xen/init.c
new file mode 100644
index 000000000000..40ad493daee8
--- /dev/null
+++ b/tools/linker-tables/arch/x86/xen/init.c
@@ -0,0 +1,13 @@
+#include <linux/kernel.h>
+#include <linux/tables.h>
+#include <asm/x86_init_fn.h>
+#include <asm/x86.h>
+
+void startup_xen(void)
+{
+	pr_info("Initializing Xen guest\n");
+
+	x86_init_fn_early_init();
+
+	x86_64_start_reservations();
+}
diff --git a/tools/linker-tables/drivers/acme.c b/tools/linker-tables/drivers/acme.c
new file mode 100644
index 000000000000..975e4b8bf48d
--- /dev/null
+++ b/tools/linker-tables/drivers/acme.c
@@ -0,0 +1,33 @@
+#define pr_fmt(fmt) "ACME: " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/workqueue.h>
+
+void *acme_todo(void *arg);
+static DECLARE_WORK(acme_work, acme_todo);
+
+void *acme_todo(void *arg)
+{
+	pr_info("Running scheduled work\n");
+	pthread_exit(NULL);
+}
+
+static int acme_init_driver(void)
+{
+	pr_info("Initializing ...\n");
+	sleep(2);
+	pr_info("Finished init ... !\n");
+
+	init_work(&acme_work);
+	schedule_work(&acme_work);
+
+	return 0;
+}
+module_init(acme_init_driver);
+
+static void acme_exit(void)
+{
+	cancel_work_sync(&acme_work);
+};
+module_exit(acme_exit);
diff --git a/tools/linker-tables/drivers/synth/common.c b/tools/linker-tables/drivers/synth/common.c
new file mode 100644
index 000000000000..b44d9fcc7a9b
--- /dev/null
+++ b/tools/linker-tables/drivers/synth/common.c
@@ -0,0 +1,16 @@
+int demo_or_1(int arg)
+{
+	switch (arg) {
+	case 1:
+		return 0xDEA00000;
+	case 2:
+		return 0X000D0000;
+	default:
+		return arg * 2;
+	}
+}
+
+int demo_or_2(void)
+{
+	return 0x0000BEEF;
+}
diff --git a/tools/linker-tables/drivers/synth/common.h b/tools/linker-tables/drivers/synth/common.h
new file mode 100644
index 000000000000..92827004f532
--- /dev/null
+++ b/tools/linker-tables/drivers/synth/common.h
@@ -0,0 +1,2 @@
+int demo_or_1(int arg);
+int demo_or_2(void);
diff --git a/tools/linker-tables/drivers/synth/main.c b/tools/linker-tables/drivers/synth/main.c
new file mode 100644
index 000000000000..b9c2f876afa0
--- /dev/null
+++ b/tools/linker-tables/drivers/synth/main.c
@@ -0,0 +1,36 @@
+#define pr_fmt(fmt) "Synthetics: " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ps_const.h>
+
+#include "common.h"
+#include "synth.h"
+
+DEFINE_LINKTABLE_INIT_DATA(struct ps_set_const, ps_set_const_table);
+
+unsigned int get_demo_shr(void)
+{
+	return 16;
+}
+
+static int synth_init(void)
+{
+	int synth_or;
+	int val = 2;
+	const unsigned int reg =  ps_shr(0xDEADBEEF, get_demo_shr);
+
+	synth_or = synth_init_or(val);
+	pr_info("synth_init_or(%d) returns: 0x%08X\n", val, synth_or);
+
+	pr_info("ps_shr(0x%08X, get_demo_shr) returns: 0x%08X\n",
+		0xDEADBEEF, reg);
+
+	return 0;
+}
+module_init(synth_init);
+
+static void synth_exit(void)
+{
+}
+module_exit(synth_exit);
diff --git a/tools/linker-tables/drivers/synth/or.S b/tools/linker-tables/drivers/synth/or.S
new file mode 100644
index 000000000000..deb963fdae33
--- /dev/null
+++ b/tools/linker-tables/drivers/synth/or.S
@@ -0,0 +1,39 @@
+#include <asm/ranges.h>
+
+	DEFINE_SECTION_RANGE(.text, synth_init_or)
+
+	push_section_rng_level(.text, synth_init_or, "01", )
+	/* err = 0; */
+	pushq %rbp
+	movq %rsp,%rbp
+	pushq %rbx
+	xorq %rbx,%rbx
+	.popsection
+
+	push_section_rng_level(.text, synth_init_or, "99", )
+	/* return err; */
+	movq %rbx,%rax
+	popq %rbx
+	popq %rbp
+	retq
+	.popsection
+
+	push_section_rng_level(.text, synth_init_or, "50", )
+	/* err |= demo_or_1(1); */
+	movl $1,%edi
+	call demo_or_1
+	orq %rax,%rbx
+	.popsection
+
+	push_section_rng_level(.text, synth_init_or, "50", )
+	/* err |= demo_or_1(2); */
+	movl $2,%edi
+	call demo_or_1
+	orq %rax,%rbx
+	.popsection
+
+	push_section_rng_level(.text, synth_init_or, "50", )
+	/* err |= demo_or_2(); */
+	call demo_or_2
+	orq %rax,%rbx
+	.popsection
diff --git a/tools/linker-tables/drivers/synth/synth.h b/tools/linker-tables/drivers/synth/synth.h
new file mode 100644
index 000000000000..abbb9afac374
--- /dev/null
+++ b/tools/linker-tables/drivers/synth/synth.h
@@ -0,0 +1,2 @@
+/* Synthetic demos go here */
+int synth_init_or(int arg);
diff --git a/tools/linker-tables/drivers/xen-driver.c b/tools/linker-tables/drivers/xen-driver.c
new file mode 100644
index 000000000000..268166efd06c
--- /dev/null
+++ b/tools/linker-tables/drivers/xen-driver.c
@@ -0,0 +1,12 @@
+#include <asm/x86_init_fn.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <xen/xen.h>
+
+static void early_xen_init_driver(void)
+{
+	pr_info("Initializing xen driver\n");
+	sleep(2);
+}
+
+x86_init_early_xen(early_xen_init_driver);
diff --git a/tools/linker-tables/include/asm-generic/arch_init_fn.h b/tools/linker-tables/include/asm-generic/arch_init_fn.h
new file mode 100644
index 000000000000..2318cc22cbe8
--- /dev/null
+++ b/tools/linker-tables/include/asm-generic/arch_init_fn.h
@@ -0,0 +1,50 @@
+#ifndef __ARCH_INIT_TABLES_H
+#define __ARCH_INIT_TABLES_H
+
+#include <linux/types.h>
+#include <linux/tables.h>
+#include <linux/init.h>
+
+/**
+ * struct arch_init_fn - architecture-generic kernel init call
+ *
+ * Architectures must initialize a series of things prior to handing off
+ * control to the kernel. This structure can be used if the architecture is
+ * simple and it just needs a basic set of calls on its way up.
+ *
+ * @early_init: required, routine which will run in startup_64(). Memory is
+ *	not yet available.
+ */
+struct arch_init_fn {
+	void (*early_init)(void);
+};
+
+DECLARE_LINKTABLE(struct arch_init_fn, arch_init_fns);
+
+/* Init order levels, we can start at 0000 but reserve 0000-0999 for now */
+
+/*
+ * ARCH_INIT_ORDER_EARLY - early kernel init code
+ *
+ * This consists of the first parts of the Linux kernel executed.
+ */
+#define ARCH_INIT_ORDER_EARLY	1000
+
+#define __arch_init(__level,						\
+		    __early_init)					\
+	static LINKTABLE_INIT_DATA(arch_init_fns, __level)		\
+	__arch_init_fn_##__early_init = {				\
+		.early_init = __early_init,				\
+	}
+
+#define arch_init_early(__early_init)					\
+	__arch_init(ARCH_INIT_ORDER_EARLY, __early_init)
+
+/**
+ * arch_init_fn_early_init: call all early_init() callbacks
+ *
+ * This calls all early_init() callbacks on the arch_init_fns linker table.
+ */
+void arch_init_fn_early_init(void);
+
+#endif /* __ARCH_INIT_TABLES_H */
diff --git a/tools/linker-tables/include/asm-generic/kprobes.h b/tools/linker-tables/include/asm-generic/kprobes.h
new file mode 100644
index 000000000000..839d2eb464d3
--- /dev/null
+++ b/tools/linker-tables/include/asm-generic/kprobes.h
@@ -0,0 +1,26 @@
+#ifndef _SANDBOX_ASM_GENERIC_KPROBES_H
+#define _SANDBOX_ASM_GENERIC_KPROBES_H
+
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#ifdef CONFIG_KPROBES
+#include <linux/tables.h>
+#include <asm/ranges.h>
+/*
+ * Blacklist ganerating macro. Specify functions which is not probed
+ * by using this macro.
+ */
+# define __NOKPROBE_SYMBOL(fname)				\
+static LINKTABLE_INIT_DATA(_kprobe_blacklist, all)		\
+	_kbl_addr_##fname = (unsigned long)fname;
+# define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)
+/* Use this to forbid a kprobes attach on very low level functions */
+# define __kprobes	__LINUX_RANGE(.text, kprobes)
+# define nokprobe_inline	__always_inline
+#else
+# define NOKPROBE_SYMBOL(fname)
+# define __kprobes
+# define nokprobe_inline	inline
+#endif
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+
+#endif /* _SANDBOX_ASM_GENERIC_KPROBES_H */
diff --git a/tools/linker-tables/include/linux/bitops.h b/tools/linker-tables/include/linux/bitops.h
new file mode 100644
index 000000000000..2960e8089ebc
--- /dev/null
+++ b/tools/linker-tables/include/linux/bitops.h
@@ -0,0 +1,6 @@
+#ifndef _LINUX_BITOPS_H
+#define _LINUX_BITOPS_H
+
+#define BIT(nr)		(1UL << (nr))
+
+#endif /* _LINUX_BITOPS_H */
diff --git a/tools/linker-tables/include/linux/init.h b/tools/linker-tables/include/linux/init.h
new file mode 100644
index 000000000000..2691c3697f48
--- /dev/null
+++ b/tools/linker-tables/include/linux/init.h
@@ -0,0 +1,40 @@
+#ifndef _SANDBOX_LINUX_INIT_H
+#define _SANDBOX_LINUX_INIT_H
+
+#include_next <linux/init.h>
+#include <linux/types.h>
+#include <linux/sections.h>
+
+#define __init	__section(.init.text)
+#define __exit	__section(.exit.text)
+
+#ifndef __ASSEMBLY__
+#include <linux/tables.h>
+typedef int (*initcall_t)(void);
+typedef void (*exitcall_t)(void);
+
+DECLARE_LINKTABLE(initcall_t, init_calls);
+DECLARE_LINKTABLE(exitcall_t, exit_calls);
+
+#define __define_initcall(fn, id)					\
+	static LINKTABLE_INIT_DATA(init_calls, id)			\
+	__initcall_##fn##id = fn
+
+#define pure_initcall(fn)			__define_initcall(fn, 0)
+#define core_initcall(fn)			__define_initcall(fn, 1)
+#define postcore_initcall(fn)			__define_initcall(fn, 2)
+#define arch_initcall(fn)			__define_initcall(fn, 3)
+#define subsys_initcall(fn)			__define_initcall(fn, 4)
+#define fs_initcall(fn)				__define_initcall(fn, 5)
+#define device_initcall(fn)			__define_initcall(fn, 6)
+#define late_initcall(fn)			__define_initcall(fn, 7)
+
+#define __initcall(fn)				device_initcall(fn)
+
+#define __exitcall(fn)							\
+	static LINKTABLE_INIT_DATA(exit_calls, any)			\
+	__exitcall_##fn = fn;
+
+#endif
+
+#endif /* _SANDBOX_LINUX_INIT_H */
diff --git a/tools/linker-tables/include/linux/kasan.h b/tools/linker-tables/include/linux/kasan.h
new file mode 100644
index 000000000000..41791187854e
--- /dev/null
+++ b/tools/linker-tables/include/linux/kasan.h
@@ -0,0 +1,5 @@
+#include <linux/types.h>
+
+void kasan_early_init(void);
+int kasan_init(void);
+bool is_kasan_setup(void);
diff --git a/tools/linker-tables/include/linux/kernel.h b/tools/linker-tables/include/linux/kernel.h
new file mode 100644
index 000000000000..e2857c0b5b11
--- /dev/null
+++ b/tools/linker-tables/include/linux/kernel.h
@@ -0,0 +1,2 @@
+#include_next <linux/kernel.h>
+#include <linux/printk.h>
diff --git a/tools/linker-tables/include/linux/kprobes.h b/tools/linker-tables/include/linux/kprobes.h
new file mode 100644
index 000000000000..ecd5a0a69ae6
--- /dev/null
+++ b/tools/linker-tables/include/linux/kprobes.h
@@ -0,0 +1,11 @@
+#ifndef _SANDBOX_LINUX_KPROBES_H
+#define _SANDBOX_LINUX_KPROBES_H
+
+#include <asm/kprobes.h>
+#include <linux/ranges.h>
+
+#ifdef CONFIG_KPROBES
+DECLARE_SECTION_RANGE(kprobes);
+#endif
+
+#endif /* _SANDBOX_LINUX_KPROBES_H */
diff --git a/tools/linker-tables/include/linux/module.h b/tools/linker-tables/include/linux/module.h
new file mode 100644
index 000000000000..b59e55f3f04e
--- /dev/null
+++ b/tools/linker-tables/include/linux/module.h
@@ -0,0 +1,14 @@
+#ifndef _LINUX_MODULE_H
+#define _LINUX_MODULE_H
+
+#include <linux/init.h>
+
+#define module_init(x)  __initcall(x);
+#define module_exit(x)  __exitcall(x);
+
+struct module {
+	int (*init)(void);
+	void (*exit)(void);
+};
+
+#endif /* _LINUX_MODULE_H */
diff --git a/tools/linker-tables/include/linux/mutex.h b/tools/linker-tables/include/linux/mutex.h
new file mode 100644
index 000000000000..a74f951ceb42
--- /dev/null
+++ b/tools/linker-tables/include/linux/mutex.h
@@ -0,0 +1,17 @@
+#ifndef __LINUX_MUTEX_H
+#define __LINUX_MUTEX_H
+
+#include <sys/types.h>
+#include <linux/sched.h>
+#include <pthread.h>
+
+struct mutex {
+	pthread_mutex_t lock;
+};
+
+void mutex_init(struct mutex *lock);
+void mutex_destroy(struct mutex *lock);
+void mutex_lock(struct mutex *lock);
+void mutex_unlock(struct mutex *lock);
+
+#endif /* __LINUX_MUTEX_H */
diff --git a/tools/linker-tables/include/linux/pci.h b/tools/linker-tables/include/linux/pci.h
new file mode 100644
index 000000000000..8518c46631f7
--- /dev/null
+++ b/tools/linker-tables/include/linux/pci.h
@@ -0,0 +1,7 @@
+#include <linux/types.h>
+
+struct pci_fixup {
+	void (*hook)(void);
+};
+
+bool detect_pci(void);
diff --git a/tools/linker-tables/include/linux/printk.h b/tools/linker-tables/include/linux/printk.h
new file mode 100644
index 000000000000..dc137d3421e8
--- /dev/null
+++ b/tools/linker-tables/include/linux/printk.h
@@ -0,0 +1,26 @@
+#ifndef _SANDBOX_KERNEL_PRINTK
+#define _SANDBOX_KERNEL_PRINTK
+
+#ifdef __KERNEL__
+
+#include <stdio.h>
+
+#ifndef pr_fmt
+#define pr_fmt(fmt)	fmt
+#endif
+
+#ifndef pr_info
+#define pr_info(fmt, ...)	printf(pr_fmt(fmt), ##__VA_ARGS__)
+#endif
+
+#ifndef pr_err
+#define pr_err(fmt, ...)	printf(pr_fmt(fmt), ##__VA_ARGS__)
+#endif
+
+#ifndef pr_debug
+#define pr_debug(fmt, ...)	printf(pr_fmt(fmt), ##__VA_ARGS__)
+#endif
+
+#endif /* __KERNEL__ */
+
+#endif /* _SANDBOX_KERNEL_PRINTK */
diff --git a/tools/linker-tables/include/linux/ps_const.h b/tools/linker-tables/include/linux/ps_const.h
new file mode 100644
index 000000000000..5eab3a124e00
--- /dev/null
+++ b/tools/linker-tables/include/linux/ps_const.h
@@ -0,0 +1,46 @@
+#ifndef __PS_CONST
+#define __PS_CONST
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/tables.h>
+
+/* Helpers for partially static settings */
+
+enum ps_static_type {
+	SET_CONST_U8 = 0,
+	SET_CONST_U16,
+	SET_CONST_U32,
+};
+
+struct ps_set_const {
+	unsigned int *count;
+	enum ps_static_type type;
+	unsigned int (*func)(void);
+};
+
+DECLARE_LINKTABLE(struct ps_set_const, ps_set_const_table);
+
+#ifdef CONFIG_HAVE_ARCH_PS_CONST
+#include <asm/ps_const.h>
+#endif
+
+/*
+ * ps_ stands for "partially static", so we "partialloy static shift right"
+ * You can optimize this for your architecture.
+ *
+ * ps_shr(unsigned int in, unsigned char (*func)(void))
+ */
+#ifndef ps_shr
+#define ps_shr(_in, _func)						\
+({									\
+	static unsigned int _count;					\
+	static LINKTABLE_INIT_DATA(ps_set_const_table, 01)		\
+		__ps_shr##__func =					\
+		{ &_count, SET_CONST_U8, (_func) };			\
+									\
+	(_in) >> _count;						\
+})
+#endif /* ps_shr */
+
+#endif /* __PS_CONST */
diff --git a/tools/linker-tables/include/linux/sched.h b/tools/linker-tables/include/linux/sched.h
new file mode 100644
index 000000000000..0fe3526e88bf
--- /dev/null
+++ b/tools/linker-tables/include/linux/sched.h
@@ -0,0 +1,9 @@
+#ifndef _LINUX_SCHED_H
+#define _LINUX_SCHED_H
+
+#include <linux/ranges.h>
+
+DECLARE_SECTION_RANGE(sched_text);
+#define __sched		__LINUX_RANGE(.text, sched_text)
+
+#endif /* _LINUX_SCHED_H */
diff --git a/tools/linker-tables/include/linux/spinlock.h b/tools/linker-tables/include/linux/spinlock.h
new file mode 100644
index 000000000000..e62bc3bc5e6a
--- /dev/null
+++ b/tools/linker-tables/include/linux/spinlock.h
@@ -0,0 +1,13 @@
+#ifndef __LINUX_SPINLOCK_H
+#define __LINUX_SPINLOCK_H
+
+#include <pthread.h>
+
+#define spinlock_t pthread_spinlock_t
+
+void spin_lock_init(spinlock_t *lock);
+void spin_lock_destroy(spinlock_t *lock);
+void spin_lock(spinlock_t *lock);
+void spin_unlock(spinlock_t *lock);
+
+#endif /* __LINUX_SPINLOCK_H */
diff --git a/tools/linker-tables/include/linux/start_kernel.h b/tools/linker-tables/include/linux/start_kernel.h
new file mode 100644
index 000000000000..5c2cb9a5cb0c
--- /dev/null
+++ b/tools/linker-tables/include/linux/start_kernel.h
@@ -0,0 +1 @@
+int start_kernel(void);
diff --git a/tools/linker-tables/include/linux/types.h b/tools/linker-tables/include/linux/types.h
new file mode 100644
index 000000000000..3fc87b2c84e2
--- /dev/null
+++ b/tools/linker-tables/include/linux/types.h
@@ -0,0 +1,13 @@
+#ifndef __LINUX_USER_TYPES_H
+#define __LINUX_USER_TYPES_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+typedef unsigned char __u8;
+typedef unsigned short __u16;
+typedef unsigned int __u32;
+
+#endif /* __LINUX_USER_TYPES_H */
diff --git a/tools/linker-tables/include/linux/workqueue.h b/tools/linker-tables/include/linux/workqueue.h
new file mode 100644
index 000000000000..69e1c6de5051
--- /dev/null
+++ b/tools/linker-tables/include/linux/workqueue.h
@@ -0,0 +1,51 @@
+#ifndef _LINUX_WORKQUEUE_H
+#define _LINUX_WORKQUEUE_H
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <pthread.h>
+
+struct work {
+	bool ready;
+
+	pthread_t thread;
+	struct mutex mutex;
+	pthread_cond_t cond;
+
+	void *arg;
+	void *(*work_cb)(void *arg);
+};
+
+#define DECLARE_WORK(_w, _w_cb) \
+struct work _w = { \
+	.work_cb = _w_cb, \
+	.arg = NULL, \
+};
+
+extern void *run_work(void *arg);
+
+static inline void init_work(struct work *w)
+{
+	w->ready = false;
+
+	mutex_init(&w->mutex);
+	pthread_cond_init(&w->cond, NULL);
+
+	pthread_create(&w->thread, NULL, run_work, (void *) w);
+
+	while (1) {
+		mutex_lock(&w->mutex);
+		if (w->ready) {
+			pthread_mutex_unlock(&w->mutex.lock);
+			break;
+		}
+		mutex_unlock(&w->mutex);
+	}
+}
+
+void schedule_work(struct work *w);
+void cancel_work_sync(struct work *w);
+void init_work(struct work *w);
+
+#endif /* _LINUX_WORKQUEUE_H */
diff --git a/tools/linker-tables/include/xen/xen.h b/tools/linker-tables/include/xen/xen.h
new file mode 100644
index 000000000000..782c799a0064
--- /dev/null
+++ b/tools/linker-tables/include/xen/xen.h
@@ -0,0 +1,4 @@
+#include <linux/types.h>
+
+bool booting_xen(void);
+int startup_xen(void);
diff --git a/tools/linker-tables/kernel/locking/mutex.c b/tools/linker-tables/kernel/locking/mutex.c
new file mode 100644
index 000000000000..950e4a18461e
--- /dev/null
+++ b/tools/linker-tables/kernel/locking/mutex.c
@@ -0,0 +1,28 @@
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+
+DEFINE_SECTION_RANGE(sched_text, .text);
+
+void __sched mutex_init(struct mutex *lock)
+{
+	int r;
+
+	r = pthread_mutex_init(&lock->lock, NULL);
+	if (r)
+		BUG_ON(r);
+}
+
+void __sched mutex_destroy(struct mutex *lock)
+{
+	pthread_mutex_destroy(&lock->lock);
+}
+
+void __sched mutex_lock(struct mutex *lock)
+{
+	pthread_mutex_lock(&lock->lock);
+}
+
+void __sched mutex_unlock(struct mutex *lock)
+{
+	pthread_mutex_unlock(&lock->lock);
+}
diff --git a/tools/linker-tables/kernel/locking/spinlock.c b/tools/linker-tables/kernel/locking/spinlock.c
new file mode 100644
index 000000000000..5be2bc7cdece
--- /dev/null
+++ b/tools/linker-tables/kernel/locking/spinlock.c
@@ -0,0 +1,26 @@
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+
+void spin_lock_init(spinlock_t *lock)
+{
+	int r;
+
+	r = pthread_spin_init(lock, PTHREAD_PROCESS_SHARED);
+	if (r)
+		BUG_ON(r);
+}
+
+void spin_lock_destroy(spinlock_t *lock)
+{
+	pthread_spin_destroy(lock);
+}
+
+void spin_lock(spinlock_t *lock)
+{
+	pthread_spin_lock(lock);
+}
+
+void spin_unlock(spinlock_t *lock)
+{
+	pthread_spin_unlock(lock);
+}
diff --git a/tools/linker-tables/kernel/main.c b/tools/linker-tables/kernel/main.c
new file mode 100644
index 000000000000..ad7a19c038bf
--- /dev/null
+++ b/tools/linker-tables/kernel/main.c
@@ -0,0 +1,32 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/x86_init_fn.h>
+#include <asm/x86.h>
+
+DEFINE_LINKTABLE_INIT_DATA(initcall_t, init_calls);
+
+int do_one_initcall(initcall_t fn)
+{
+	int ret;
+
+	ret = fn();
+
+	return ret;
+}
+
+static void do_initcalls(void)
+{
+	initcall_t *fn;
+
+	 linktable_for_each(fn, init_calls)
+		 do_one_initcall(*fn);
+}
+
+void start_kernel(void)
+{
+	pr_info("Calling start_kernel()...\n");
+
+	setup_arch();
+	late_init();
+	do_initcalls();
+}
diff --git a/tools/linker-tables/kernel/workqueue.c b/tools/linker-tables/kernel/workqueue.c
new file mode 100644
index 000000000000..5ba73c7e7c8b
--- /dev/null
+++ b/tools/linker-tables/kernel/workqueue.c
@@ -0,0 +1,43 @@
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+
+#include <linux/workqueue.h>
+#include <linux/kernel.h>
+
+void schedule_work(struct work *w)
+{
+	mutex_lock(&w->mutex);
+	pthread_cond_signal(&w->cond);
+	mutex_unlock(&w->mutex);
+}
+
+void cancel_work_sync(struct work *w)
+{
+	pthread_exit(NULL);
+}
+
+void *run_work(void *arg)
+{
+	struct work *w;
+	int r;
+
+	w = (struct work *) arg;
+
+	mutex_lock(&w->mutex);
+
+	while (true) {
+		if (!w->ready)
+			w->ready = true;
+		r = pthread_cond_wait(&w->cond, &w->mutex.lock);
+		if (r != 0) {
+			printf("(%s)\n", strerror(r));
+			BUG_ON(r);
+		}
+		w->work_cb(w->arg);
+	}
+
+	mutex_unlock(&w->mutex);
+
+	pthread_exit(NULL);
+}
diff --git a/tools/linker-tables/lib/string.c b/tools/linker-tables/lib/string.c
new file mode 100644
index 000000000000..95631c742f1d
--- /dev/null
+++ b/tools/linker-tables/lib/string.c
@@ -0,0 +1,26 @@
+/*
+ *  linux/lib/string.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ *  Licensed under GPLv2 - taken from linux-next next-20160803
+ */
+
+#include <linux/kernel.h>
+
+/**
+ * memset - Fill a region of memory with the given value
+ * @s: Pointer to the start of the area.
+ * @c: The byte to fill the area with
+ * @count: The size of the area.
+ *
+ * Do not use memset() to access IO space, use memset_io() instead.
+ */
+void *memset(void *s, int c, size_t count)
+{
+	char *xs = s;
+
+	while (count--)
+		*xs++ = c;
+	return s;
+}
diff --git a/tools/linker-tables/main.c b/tools/linker-tables/main.c
new file mode 100644
index 000000000000..c0b1f4c95112
--- /dev/null
+++ b/tools/linker-tables/main.c
@@ -0,0 +1,20 @@
+#include <linux/string.h>
+#include <xen/xen.h>
+#include <asm/x86.h>
+#include <asm/bootparam.h>
+
+struct boot_params boot_params __attribute__((aligned(16)));
+
+int main(int arg, char *argc[])
+{
+	memset(&boot_params, 0, sizeof(struct boot_params));
+
+	if (arg <= 1)
+		startup_64();
+	else {
+		boot_params.hdr.hardware_subarch = X86_SUBARCH_XEN;
+		startup_xen();
+	}
+
+	return 0;
+}
diff --git a/tools/linker-tables/pci-quirks.c b/tools/linker-tables/pci-quirks.c
new file mode 100644
index 000000000000..8aac79477eab
--- /dev/null
+++ b/tools/linker-tables/pci-quirks.c
@@ -0,0 +1,14 @@
+#include <linux/kernel.h>
+#include <linux/tables.h>
+#include <linux/pci.h>
+
+DEFINE_LINKTABLE_RO(struct pci_fixup, pci_fixup_early);
+
+static void foo_fixup(void)
+{
+	pr_info("foo_fixup\n");
+};
+
+LINKTABLE_RO(pci_fixup_early, 50) quirk_foo = {
+	.hook = foo_fixup,
+};
diff --git a/tools/linker-tables/pci.c b/tools/linker-tables/pci.c
new file mode 100644
index 000000000000..a452c0766800
--- /dev/null
+++ b/tools/linker-tables/pci.c
@@ -0,0 +1,30 @@
+#include <linux/kernel.h>
+#include <linux/tables.h>
+#include <asm/x86_init_fn.h>
+#include <asm/bootparam.h>
+#include <linux/pci.h>
+
+DECLARE_LINKTABLE(struct pci_fixup, pci_fixup_early);
+
+void early_init_pci(void)
+{
+
+	const struct pci_fixup *fixup;
+	unsigned int tbl_size = LINKTABLE_SIZE(pci_fixup_early);
+
+	pr_info("Initializing pci ...\n");
+
+	pr_info("PCI fixup size: %d\n", tbl_size);
+
+	sleep(1);
+	pr_info("Demo: Using linktable_for_each\n");
+	linktable_for_each(fixup, pci_fixup_early)
+		fixup->hook();
+
+	pr_info("Demo: Using linktable_run_all\n");
+	linktable_run_all(pci_fixup_early, hook,);
+
+	pr_info("Completed initializing pci !\n");
+}
+
+x86_init_early_all(early_init_pci);
-- 
2.11.0

