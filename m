From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sat, 07 Dec 2013 23:26:58 +0000
Subject: [PATCH 09/10] tilo: support ELF binaries
Message-Id: <1386458819-6590-10-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Support booting ELF and normal a.out binaries, also retain compatiblity
with the "raw" a.out prepared by tilo.sh.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/tilo.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tilo/tilo.c b/tilo/tilo.c
index dc626efc7b02..d2fcd97b525f 100644
--- a/tilo/tilo.c
+++ b/tilo/tilo.c
@@ -18,6 +18,7 @@
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
    USA.  */
 
+#include <elf.h>
 #include <silo.h>
 #include <setjmp.h>
 #ifndef NULL
@@ -170,6 +171,108 @@ extern struct ImageInfo image_table[4];	/* Sun4 kernel, Sun4c/d/m kernel, Sun4u
 
 #define HDRS_TAG	(('H'<<24) | ('d'<<16) | ('r'<<8) | 'S')
 
+void parse_executable(char *base, int image_len)
+{
+	union {
+		char *b;
+		struct aout_hdr *a;
+		Elf32_Ehdr *e;
+		Elf64_Ehdr *f;
+	} hp;
+	unsigned off = 0;
+	int len = 0;
+
+	/*
+	 * Check if the image is an executable file, either an a.out or an elf
+	 * binary.
+	 */
+
+	hp.b = base;
+	if (hp.a->magic = 0x01030107) {
+		off = sizeof (struct aout_hdr);
+		if (image_len > hp.a->ltext + hp.a->ldata)
+			len = hp.a->ltext + hp.a->ldata;
+		else
+			len = image_len;
+	} else if (hp.e->e_ident[EI_MAG0] = ELFMAG0 &&
+		   hp.e->e_ident[EI_MAG1] = ELFMAG1 &&
+		   hp.e->e_ident[EI_MAG2] = ELFMAG2 &&
+		   hp.e->e_ident[EI_MAG3] = ELFMAG3) {
+		if (hp.e->e_ident[EI_DATA] != ELFDATA2MSB) {
+			printf("Image is not a MSB ELF.\n");
+			prom_halt();
+		}
+		if (hp.e->e_ident[EI_CLASS] = ELFCLASS32) {
+			Elf32_Phdr *p;
+			int i;
+			unsigned long n;
+			Elf32_Phdr *q;
+
+			p = (Elf32_Phdr *) (hp.b + hp.e->e_phoff);
+			if (p->p_type != PT_LOAD) {
+				printf("Cannot find a loadable segment in your ELF image.\n");
+				prom_halt();
+			}
+
+			q = p + 1;
+			for (i = 1; i < hp.e->e_phnum; i++, q++) {
+				if (q->p_type != PT_LOAD)
+				break;
+				n = q->p_offset - p->p_offset;
+				if (q->p_vaddr - p->p_vaddr = n &&
+				    q->p_paddr - p->p_paddr = n &&
+				    p->p_memsz = p->p_filesz &&
+				    p->p_memsz <= n) {
+					p->p_filesz = n + q->p_filesz;
+					p->p_memsz = n + q->p_memsz;
+				} else {
+					printf("Multiple loadable segments in your ELF image.\n");
+					prom_halt();
+				}
+			}
+			off = p->p_offset + hp.e->e_entry - p->p_vaddr;
+			len = p->p_filesz;
+			if (len > image_len)
+				len = image_len;
+		} else if (hp.e->e_ident[EI_CLASS] = ELFCLASS64) {
+			Elf64_Phdr *p;
+			unsigned long long n;
+			int i;
+			Elf64_Phdr *q;
+
+			p = (Elf64_Phdr *) (hp.b + hp.f->e_phoff);
+			if (p->p_type != PT_LOAD) {
+				printf("Cannot find a loadable segment in your ELF image.\n");
+				prom_halt();
+			}
+			q = p + 1;
+			for (i = 1; i < hp.f->e_phnum; i++, q++) {
+				if (q->p_type != PT_LOAD)
+					break;
+				n = q->p_offset - p->p_offset;
+				if (q->p_vaddr - p->p_vaddr = n &&
+				    q->p_paddr - p->p_paddr = n &&
+				    p->p_memsz = p->p_filesz &&
+				    p->p_memsz <= n) {
+					p->p_filesz = n + q->p_filesz;
+					p->p_memsz = n + q->p_memsz;
+				} else {
+					printf("Multiple loadable segments in your ELF image.\n");
+					prom_halt();
+				}
+			}
+			off = p->p_offset + hp.f->e_entry - p->p_vaddr;
+			len = p->p_filesz;
+			if (len > image_len)
+				len = image_len;
+		}
+	} else {
+		/* Assume "raw" a.out format prepared by tilo.sh. */
+		return;
+	}
+	memmove(base, base + off, len);
+}
+
 char *my_main (struct linux_romvec *promvec, void *cifh, void *cifs)
 {
 char *orig_code,*moved_code,*moved_ramdisk,*moved_kernel,*kernel_base;
@@ -231,6 +334,8 @@ char *kernel_end, *kernel_limit;
         prom_halt();
     	}
 
+    parse_executable(kernel_base, kernel_end - kernel_base);
+
     switch (kernel_number)
     	{
     	case SUN4U_KERNEL:
-- 
1.8.4.4

