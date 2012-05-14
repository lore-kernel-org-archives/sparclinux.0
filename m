From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 17:42:08 +0000
Subject: [PATCH] sparc32: drop build time btfixup patching
Message-Id: <20120514174024.GA21246@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 8593606416d24fea271f70877fe581c4e2fab620 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 19:35:50 +0200
Subject: [PATCH] sparc32: drop build time btfixup patching

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Goodbye btfixup - we will not miss you!

I was stopped hacking for today - but this was too tempting...
This patch will conflict badly with a patch in kbuild-next.

The fix is simple - drop all changes from kbuild-next.

	Sam

 arch/sparc/Makefile           |   12 --
 arch/sparc/boot/Makefile      |   61 +------
 arch/sparc/boot/btfixupprep.c |  386 -----------------------------------------
 3 files changed, 10 insertions(+), 449 deletions(-)
 delete mode 100644 arch/sparc/boot/btfixupprep.c

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index cd2afcc..7e8040b 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -33,11 +33,6 @@ UTS_MACHINE    := sparc
 KBUILD_CFLAGS += -m32 -mcpu=v7 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
 KBUILD_AFLAGS += -m32 -Wa,-Av8
 
-#LDFLAGS_vmlinux = -N -Ttext 0xf0004000
-#  Since 2.5.40, the first stage is left not btfix-ed.
-#  Actual linking is done with "make image".
-LDFLAGS_vmlinux = -r
-
 else
 #####
 # sparc64
@@ -72,13 +67,6 @@ libs-y                 += arch/sparc/lib/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
-# Export what is needed by arch/sparc/boot/Makefile
-export VMLINUX_INIT VMLINUX_MAIN
-VMLINUX_INIT := $(head-y) $(init-y)
-VMLINUX_MAIN := $(core-y) kernel/ mm/ fs/ ipc/ security/ crypto/ block/
-VMLINUX_MAIN += $(patsubst %/, %/lib.a, $(libs-y)) $(libs-y)
-VMLINUX_MAIN += $(drivers-y) $(net-y)
-
 ifdef CONFIG_KALLSYMS
 export kallsyms.o := .tmp_kallsyms2.o
 endif
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index d56d199..6e63afb 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -6,8 +6,8 @@
 ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
 
-hostprogs-y	:= piggyback btfixupprep
-targets		:= tftpboot.img btfix.o btfix.S image zImage vmlinux.aout
+hostprogs-y	:= piggyback
+targets		:= tftpboot.img image zImage vmlinux.aout
 clean-files	:= System.map
 
 quiet_cmd_elftoaout	= ELFTOAOUT $@
@@ -17,58 +17,9 @@ quiet_cmd_piggy		= PIGGY   $@
 quiet_cmd_strip		= STRIP   $@
       cmd_strip		= $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start $< -o $@
 
-ifeq ($(CONFIG_SPARC32),y)
-quiet_cmd_btfix		= BTFIX   $@
-      cmd_btfix		= $(OBJDUMP) -x vmlinux | $(obj)/btfixupprep > $@
-quiet_cmd_sysmap        = SYSMAP  $(obj)/System.map
-      cmd_sysmap        = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
-quiet_cmd_image = LD      $@
-      cmd_image = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_$(@F)) -o $@
-
-define rule_image
-	$(if $($(quiet)cmd_image),               \
-	  echo '  $($(quiet)cmd_image)' &&)      \
-	  $(cmd_image);                          \
-	$(if $($(quiet)cmd_sysmap),              \
-	  echo '  $($(quiet)cmd_sysmap)' &&)  \
-	$(cmd_sysmap) $@ $(obj)/System.map;      \
-	if [ $$? -ne 0 ]; then                   \
-		rm -f $@;                        \
-		/bin/false;                      \
-	fi;                                      \
-	echo 'cmd_$@ := $(cmd_image)' > $(@D)/.$(@F).cmd
-endef
-
-BTOBJS := $(patsubst %/, %/built-in.o, $(VMLINUX_INIT))
-BTLIBS := $(patsubst %/, %/built-in.o, $(VMLINUX_MAIN))
-LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds $(BTOBJS) \
-                  --start-group $(BTLIBS) --end-group \
-                  $(kallsyms.o) $(obj)/btfix.o
-
-# Link the final image including btfixup'ed symbols.
-# This is a replacement for the link done in the top-level Makefile.
-# Note: No dependency on the prerequisite files since that would require
-# make to try check if they are updated - and due to changes
-# in gcc options (path for example) this would result in
-# these files being recompiled for each build.
-$(obj)/image: $(obj)/btfix.o FORCE
-	$(call if_changed_rule,image)
-
-$(obj)/zImage: $(obj)/image
-	$(call if_changed,strip)
-	@echo '  kernel: $@ is ready'
-
-$(obj)/btfix.S: $(obj)/btfixupprep vmlinux FORCE
-	$(call if_changed,btfix)
-
-endif
-
 ifeq ($(CONFIG_SPARC64),y)
 
 # Actual linking
-$(obj)/image: vmlinux FORCE
-	$(call if_changed,strip)
-	@echo '  kernel: $@ is ready'
 
 $(obj)/zImage: $(obj)/image
 	$(call if_changed,gzip)
@@ -79,6 +30,10 @@ $(obj)/vmlinux.aout: vmlinux FORCE
 	@echo '  kernel: $@ is ready'
 else
 
+$(obj)/zImage: $(obj)/image
+	$(call if_changed,strip)
+	@echo '  kernel: $@ is ready'
+
 # The following lines make a readable image for U-Boot.
 #  uImage   - Binary file read by U-boot
 #  uImage.o - object file of uImage for loading with a
@@ -107,6 +62,10 @@ $(obj)/uImage: $(obj)/image.gz
 
 endif
 
+$(obj)/image: vmlinux FORCE
+	$(call if_changed,strip)
+	@echo '  kernel: $@ is ready'
+
 $(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback System.map $(ROOT_IMG) FORCE
 	$(call if_changed,elftoaout)
 	$(call if_changed,piggy)
diff --git a/arch/sparc/boot/btfixupprep.c b/arch/sparc/boot/btfixupprep.c
deleted file mode 100644
index da03115..0000000
--- a/arch/sparc/boot/btfixupprep.c
+++ /dev/null
@@ -1,386 +0,0 @@
-/*
-   Simple utility to prepare vmlinux image for sparc.
-   Resolves all BTFIXUP uses and settings and creates
-   a special .s object to link to the image.
-   
-   Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
-   
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-   
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
-   
-#include <stdio.h>
-#include <string.h>
-#include <ctype.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <malloc.h>
-
-#define MAXSYMS 1024
-
-static char *symtab = "SYMBOL TABLE:";
-static char *relrec = "RELOCATION RECORDS FOR [";
-static int rellen;
-static int symlen;
-int mode;
-
-struct _btfixup;
-
-typedef struct _btfixuprel {
-	char *sect;
-	unsigned long offset;
-	struct _btfixup *f;
-	int frel;
-	struct _btfixuprel *next;
-} btfixuprel;
-
-typedef struct _btfixup {
-	int type;
-	int setinitval;
-	unsigned int initval;
-	char *initvalstr;
-	char *name;
-	btfixuprel *rel;
-} btfixup;
-
-btfixup array[MAXSYMS];
-int last = 0;
-char buffer[1024];
-unsigned long lastfoffset = -1;
-unsigned long lastfrelno;
-btfixup *lastf;
-
-static void fatal(void) __attribute__((noreturn));
-static void fatal(void)
-{
-	fprintf(stderr, "Malformed output from objdump\n%s\n", buffer);
-	exit(1);
-}
-
-static btfixup *find(int type, char *name)
-{
-	int i;
-	for (i = 0; i < last; i++) {
-		if (array[i].type = type && !strcmp(array[i].name, name))
-			return array + i;
-	}
-	array[last].type = type;
-	array[last].name = strdup(name);
-	array[last].setinitval = 0;
-	if (!array[last].name) fatal();
-	array[last].rel = NULL;
-	last++;
-	if (last >= MAXSYMS) {
-		fprintf(stderr, "Ugh. Something strange. More than %d different BTFIXUP symbols\n", MAXSYMS);
-		exit(1);
-	}
-	return array + last - 1;
-}
-
-static void set_mode (char *buffer)
-{
-  	for (mode = 0;; mode++)
-		if (buffer[mode] < '0' || buffer[mode] > '9')
-			break;
-	if (mode != 8 && mode != 16)
-		fatal();
-}
-
-
-int main(int argc,char **argv)
-{
-	char *p, *q;
-	char *sect;
-	int i, j, k;
-	unsigned int initval;
-	int shift;
-	btfixup *f;
-	btfixuprel *r, **rr;
-	unsigned long offset;
-	char *initvalstr;
-
-	symlen = strlen(symtab);
-	while (fgets (buffer, 1024, stdin) != NULL)
-		if (!strncmp (buffer, symtab, symlen))
-			goto main0;
-	fatal();
-main0:
-	rellen = strlen(relrec);
-	while (fgets (buffer, 1024, stdin) != NULL)
-		if (!strncmp (buffer, relrec, rellen))
-			goto main1;
-	fatal();
-main1:
-	sect = malloc(strlen (buffer + rellen) + 1);
-	if (!sect) fatal();
-	strcpy (sect, buffer + rellen);
-	p = strchr (sect, ']');
-	if (!p) fatal();
-	*p = 0;
-	if (fgets (buffer, 1024, stdin) = NULL)
-		fatal();
-	while (fgets (buffer, 1024, stdin) != NULL) {
-		int nbase;
-		if (!strncmp (buffer, relrec, rellen))
-			goto main1;
-		if (mode = 0)
-			set_mode (buffer);
-		p = strchr (buffer, '\n');
-		if (p) *p = 0;
-		if (strlen (buffer) < 22+mode)
-			continue;
-		if (strncmp (buffer + mode, " R_SPARC_", 9))
-			continue;
-		nbase = 27 - 8 + mode;
-		if (buffer[nbase] != '_' || buffer[nbase+1] != '_' || buffer[nbase+2] != '_')
-			continue;
-		switch (buffer[nbase+3]) {
-			case 'f':	/* CALL */
-			case 'b':	/* BLACKBOX */
-			case 's':	/* SIMM13 */
-			case 'a':	/* HALF */
-			case 'h':	/* SETHI */
-			case 'i':	/* INT */
-				break;
-			default:
-				continue;
-		}
-		p = strchr (buffer + nbase+5, '+');
-		if (p) *p = 0;
-		shift = nbase + 5;
-		if (buffer[nbase+4] = 's' && buffer[nbase+5] = '_') {
-			shift = nbase + 6;
-			if (strcmp (sect, ".init.text")) {
-				fprintf(stderr,
-				    "Wrong use of '%s' BTFIXUPSET in '%s' section.\n"
-				    "BTFIXUPSET_CALL can be used only in"
-				    " __init sections\n",
-				    buffer + shift, sect);
-				exit(1);
-			}
-		} else if (buffer[nbase+4] != '_')
-			continue;
-		if (!strcmp (sect, ".text.exit"))
-			continue;
-		if (strcmp (sect, ".text") &&
-		    strcmp (sect, ".init.text") &&
-		    strcmp (sect, ".fixup") &&
-		    (strcmp (sect, "__ksymtab") || buffer[nbase+3] != 'f')) {
-			if (buffer[nbase+3] = 'f')
-				fprintf(stderr,
-				    "Wrong use of '%s' in '%s' section.\n"
-				    " It can be used only in .text, .init.text,"
-				    " .fixup and __ksymtab\n",
-				    buffer + shift, sect);
-			else
-				fprintf(stderr,
-				    "Wrong use of '%s' in '%s' section.\n"
-				    " It can be only used in .text, .init.text,"
-				    " and .fixup\n", buffer + shift, sect);
-			exit(1);
-		}
-		p = strstr (buffer + shift, "__btset_");
-		if (p && buffer[nbase+4] = 's') {
-			fprintf(stderr, "__btset_ in BTFIXUP name can only be used when defining the variable, not for setting\n%s\n", buffer);
-			exit(1);
-		}
-		initval = 0;
-		initvalstr = NULL;
-		if (p) {
-			if (p[8] != '0' || p[9] != 'x') {
-				fprintf(stderr, "Pre-initialized values can be only initialized with hexadecimal constants starting 0x\n%s\n", buffer);
-				exit(1);
-			}
-			initval = strtoul(p + 10, &q, 16);
-			if (*q || !initval) {
-				fprintf(stderr, "Pre-initialized values can be only in the form name__btset_0xXXXXXXXX where X are hex digits.\nThey cannot be name__btset_0x00000000 though. Use BTFIXUPDEF_XX instead of BTFIXUPDEF_XX_INIT then.\n%s\n", buffer);
-				exit(1);
-			}
-			initvalstr = p + 10;
-			*p = 0;
-		}
-		f = find(buffer[nbase+3], buffer + shift);
-		if (buffer[nbase+4] = 's')
-			continue;
-		switch (buffer[nbase+3]) {
-		case 'f':
-			if (initval) {
-				fprintf(stderr, "Cannot use pre-initialized fixups for calls\n%s\n", buffer);
-				exit(1);
-			}
-			if (!strcmp (sect, "__ksymtab")) {
-				if (strncmp (buffer + mode+9, "32        ", 10)) {
-					fprintf(stderr, "BTFIXUP_CALL in EXPORT_SYMBOL results in relocation other than R_SPARC_32\n\%s\n", buffer);
-					exit(1);
-				}
-			} else if (strncmp (buffer + mode+9, "WDISP30   ", 10) &&
-				   strncmp (buffer + mode+9, "HI22      ", 10) &&
-				   strncmp (buffer + mode+9, "LO10      ", 10)) {
-				fprintf(stderr, "BTFIXUP_CALL results in relocation other than R_SPARC_WDISP30, R_SPARC_HI22 or R_SPARC_LO10\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		case 'b':
-			if (initval) {
-				fprintf(stderr, "Cannot use pre-initialized fixups for blackboxes\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "HI22      ", 10)) {
-				fprintf(stderr, "BTFIXUP_BLACKBOX results in relocation other than R_SPARC_HI22\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		case 's':
-			if (initval + 0x1000 >= 0x2000) {
-				fprintf(stderr, "Wrong initializer for SIMM13. Has to be from $fffff000 to $00000fff\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "13        ", 10)) {
-				fprintf(stderr, "BTFIXUP_SIMM13 results in relocation other than R_SPARC_13\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		case 'a':
-			if (initval + 0x1000 >= 0x2000 && (initval & 0x3ff)) {
-				fprintf(stderr, "Wrong initializer for HALF.\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "13        ", 10)) {
-				fprintf(stderr, "BTFIXUP_HALF results in relocation other than R_SPARC_13\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		case 'h':
-			if (initval & 0x3ff) {
-				fprintf(stderr, "Wrong initializer for SETHI. Cannot have set low 10 bits\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "HI22      ", 10)) {
-				fprintf(stderr, "BTFIXUP_SETHI results in relocation other than R_SPARC_HI22\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		case 'i':
-			if (initval) {
-				fprintf(stderr, "Cannot use pre-initialized fixups for INT\n%s\n", buffer);
-				exit(1);
-			}
-			if (strncmp (buffer + mode+9, "HI22      ", 10) && strncmp (buffer + mode+9, "LO10      ", 10)) {
-				fprintf(stderr, "BTFIXUP_INT results in relocation other than R_SPARC_HI22 and R_SPARC_LO10\n%s\n", buffer);
-				exit(1);
-			}
-			break;
-		}
-		if (!f->setinitval) {
-			f->initval = initval;
-			if (initvalstr) {
-				f->initvalstr = strdup(initvalstr);
-				if (!f->initvalstr) fatal();
-			}
-			f->setinitval = 1;
-		} else if (f->initval != initval) {
-			fprintf(stderr, "Btfixup %s previously used with initializer %s which doesn't match with current initializer\n%s\n",
-					f->name, f->initvalstr ? : "0x00000000", buffer);
-			exit(1);
-		} else if (initval && strcmp(f->initvalstr, initvalstr)) {
-			fprintf(stderr, "Btfixup %s previously used with initializer %s which doesn't match with current initializer.\n"
-					"Initializers have to match literally as well.\n%s\n",
-					f->name, f->initvalstr, buffer);
-			exit(1);
-		}
-		offset = strtoul(buffer, &q, 16);
-		if (q != buffer + mode || (!offset && (mode = 8 ? strncmp (buffer, "00000000 ", 9) : strncmp (buffer, "0000000000000000 ", 17)))) {
-			fprintf(stderr, "Malformed relocation address in\n%s\n", buffer);
-			exit(1);
-		}
-		for (k = 0, r = f->rel, rr = &f->rel; r; rr = &r->next, r = r->next, k++)
-			if (r->offset = offset && !strcmp(r->sect, sect)) {
-				fprintf(stderr, "Ugh. One address has two relocation records\n");
-				exit(1);
-			}
-		*rr = malloc(sizeof(btfixuprel));
-		if (!*rr) fatal();
-		(*rr)->offset = offset;
-		(*rr)->f = NULL;
-		if (buffer[nbase+3] = 'f') {
-			lastf = f;
-			lastfoffset = offset;
-			lastfrelno = k;
-		} else if (lastfoffset + 4 = offset) {
-			(*rr)->f = lastf;
-			(*rr)->frel = lastfrelno;
-		}
-		(*rr)->sect = sect;
-		(*rr)->next = NULL;
-	}
-	printf("! Generated by btfixupprep. Do not edit.\n\n");
-	printf("\t.section\t\".data..init\",#alloc,#write\n\t.align\t4\n\n");
-	printf("\t.global\t___btfixup_start\n___btfixup_start:\n\n");
-	for (i = 0; i < last; i++) {
-		f = array + i;
-		printf("\t.global\t___%cs_%s\n", f->type, f->name);
-		if (f->type = 'f')
-			printf("___%cs_%s:\n\t.word 0x%08x,0,0,", f->type, f->name, f->type << 24);
-		else
-			printf("___%cs_%s:\n\t.word 0x%08x,0,", f->type, f->name, f->type << 24);
-		for (j = 0, r = f->rel; r != NULL; j++, r = r->next);
-		if (j)
-			printf("%d\n\t.word\t", j * 2);
-		else
-			printf("0\n");
-		for (r = f->rel, j--; r != NULL; j--, r = r->next) {
-			if (!strcmp (r->sect, ".text"))
-				printf ("_stext+0x%08lx", r->offset);
-			else if (!strcmp (r->sect, ".init.text"))
-				printf ("__init_begin+0x%08lx", r->offset);
-			else if (!strcmp (r->sect, "__ksymtab"))
-				printf ("__start___ksymtab+0x%08lx", r->offset);
-			else if (!strcmp (r->sect, ".fixup"))
-				printf ("__start___fixup+0x%08lx", r->offset);
-			else
-				fatal();
-			if (f->type = 'f' || !r->f)
-				printf (",0");
-			else
-				printf (",___fs_%s+0x%08x", r->f->name, (4 + r->frel*2)*4 + 4);
-			if (j) printf (",");
-			else printf ("\n");
-		}
-		printf("\n");
-	}
-	printf("\n\t.global\t___btfixup_end\n___btfixup_end:\n");
-	printf("\n\n! Define undefined references\n\n");
-	for (i = 0; i < last; i++) {
-		f = array + i;
-		if (f->type = 'f') {
-			printf("\t.global\t___f_%s\n", f->name);
-			printf("___f_%s:\n", f->name);
-		}
-	}
-	printf("\tretl\n\t nop\n\n");
-	for (i = 0; i < last; i++) {
-		f = array + i;
-		if (f->type != 'f') {
-			if (!f->initval) {
-				printf("\t.global\t___%c_%s\n", f->type, f->name);
-				printf("___%c_%s = 0\n", f->type, f->name);
-			} else {
-				printf("\t.global\t___%c_%s__btset_0x%s\n", f->type, f->name, f->initvalstr);
-				printf("___%c_%s__btset_0x%s = 0x%08x\n", f->type, f->name, f->initvalstr, f->initval);
-			}
-		}
-	}
-	printf("\n\n");
-    	exit(0);
-}
-- 
1.6.0.6

