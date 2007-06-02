From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 02 Jun 2007 20:32:06 +0000
Subject: section mismatches from sun4v*_patch in trampoline.S
Message-Id: <20070602203206.GA13700@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

As per discussion in other mail I have looked into the section
mismatch warnings coming from trampoline.S


If the section is changed to .init.text it gives the following warnings:
WARNING: arch/sparc64/kernel/built-in.o(.sun4v_1insn_patch+0x8): Section mismatch: reference to .init.text:
WARNING: arch/sparc64/kernel/built-in.o(.sun4v_1insn_patch+0x10): Section mismatch: reference to .init.text:
WARNING: arch/sparc64/kernel/built-in.o(.sun4v_1insn_patch+0x18): Section mismatch: reference to .init.text:
WARNING: arch/sparc64/kernel/built-in.o(.cpuid_patch+0x0): Section mismatch: reference to .init.text:

The good news is that there is a nice pattern here. All sections that
have the references end in _patch.
So a simple solution is to teach modpost to not warn about references
from a section named *_patch to .init.text

I have such a change queued to modpost but would like to know if
you have any better ideas before pushing the change.

	Sam

Relevant patches (for info only).
I do not know if it is OK to use .init.text??
I would assume that CONFIG_HOTPLUG_CPU had impact here.

diff --git a/arch/sparc64/kernel/trampoline.S b/arch/sparc64/kernel/trampoline.S
index a4dc01a..2588cf0 100644
--- a/arch/sparc64/kernel/trampoline.S
+++ b/arch/sparc64/kernel/trampoline.S
@@ -37,6 +37,7 @@ tramp_stack:
 	.skip	TRAMP_STACK_SIZE
 
 	.text
+	.section	.init.text, "ax"
 	.align		8
 	.globl		sparc64_cpu_startup, sparc64_cpu_startup_end
 sparc64_cpu_startup:

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0f9130f..8464938 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1173,6 +1173,11 @@ static int init_section_ref_ok(const char *name)
 		".rodata",
 		NULL
 	};
+	/* End of section names */
+	const char *end_of_sec[] = {
+		"_patch",
+		NULL
+	};
 
 	if (initexit_section_ref_ok(name))
 		return 1;
@@ -1183,6 +1188,11 @@ static int init_section_ref_ok(const char *name)
 	for (s = namelist2; *s; s++)
 		if (strncmp(*s, name, strlen(*s)) = 0)
 			return 1;
+
+	for (s = end_of_sec; *s; s++)
+		if (strrcmp(name, *s) = 0)
+			return 1;
+
 	if (strrcmp(name, ".init") = 0)
 		return 1;
 	return 0;
