From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Dec 2004 07:34:45 +0000
Subject: Re: mmap breakage
Message-Id: <20041208233445.6a837c82.davem@davemloft.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart=_Wed__8_Dec_2004_23_34_45_-0800_aqYOfdT_ZRbDpwhK"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__8_Dec_2004_23_34_45_-0800_aqYOfdT_ZRbDpwhK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Ok, here is what I'm going to do about this.  Patches for
2.6.x and 2.4.x attached.

As I described in a previous email, the ELF_ET_DYN_BASE
value used for 32-bit sparc was choosen simple to make
"/lib/ld-linux.so.2 emacs" work.

That case is obscure, and even i386 doesn't work in this
case either.  In fact, this choice on sparc has shown to
break many more important things.

So I'm going to go back to using TASK_UNMAPPED_BASE for
this and it should fix the test cases in the debian bugs.


--Multipart=_Wed__8_Dec_2004_23_34_45_-0800_aqYOfdT_ZRbDpwhK
Content-Type: text/plain;
 name="et_dyn_base_24.diff"
Content-Disposition: attachment;
 filename="et_dyn_base_24.diff"
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/08 23:08:19-08:00 davem@nuts.davemloft.net 
#   [SPARC]: Adjust 32-bit ELF_ET_DYN_BASE.
#   
#   We were using 0x08000000 instead of TASK_UNMAPPED_BASE
#   so that running something like "/lib/ld-linux.so.2 emacs"
#   would work.
#   
#   The issue there was that wherever /lib/ld-linux.so.2 gets
#   mapped (controlled by ELF_ET_DYN_BASE), that is where the
#   BSS start for the process ends up.  Now, emacs allocates
#   dynamic memory for LISP objects from the BSS, and needs
#   the top 4 bits of the virtual address to be clear so that
#   it can encode LISP type and GC marking information there.
#   
#   But making this obscure emacs case work breaks lots of other
#   stuff.  For example, programs with a reasonably large data
#   section fail to load via direct ld.so interpreter execution
#   because the data section is large enough to begin overlapping
#   with the ELF_ET_DYN_BASE area.
#   
#   The /lib/ld-linux.so.2 emacs case does not work on a lot of
#   platforms due to this issue, including i386, so it is not
#   worth making work on sparc either.  It is indeed useful
#   sometimes when debugging a new experimental build of glibc
#   for example, but people doing that can hack the value of
#   ELF_ET_DYN_BASE in their kernels.  Perhaps at some point
#   we will make a sysctl controllable value.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# include/asm-sparc/elf.h
#   2004/12/08 23:08:07-08:00 davem@nuts.davemloft.net +1 -1
#   [SPARC]: Adjust 32-bit ELF_ET_DYN_BASE.
# 
# arch/sparc64/kernel/binfmt_elf32.c
#   2004/12/08 23:08:07-08:00 davem@nuts.davemloft.net +1 -1
#   [SPARC]: Adjust 32-bit ELF_ET_DYN_BASE.
# 
diff -Nru a/arch/sparc64/kernel/binfmt_elf32.c b/arch/sparc64/kernel/binfmt_elf32.c
--- a/arch/sparc64/kernel/binfmt_elf32.c	2004-12-08 23:09:43 -08:00
+++ b/arch/sparc64/kernel/binfmt_elf32.c	2004-12-08 23:09:43 -08:00
@@ -81,7 +81,7 @@
 
 #define elf_check_arch(x)	(((x)->e_machine == EM_SPARC) || ((x)->e_machine == EM_SPARC32PLUS))
 
-#define ELF_ET_DYN_BASE         0x08000000
+#define ELF_ET_DYN_BASE         0x70000000
 
 
 #include <asm/processor.h>
diff -Nru a/include/asm-sparc/elf.h b/include/asm-sparc/elf.h
--- a/include/asm-sparc/elf.h	2004-12-08 23:09:43 -08:00
+++ b/include/asm-sparc/elf.h	2004-12-08 23:09:43 -08:00
@@ -81,7 +81,7 @@
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE         (0x08000000)
+#define ELF_ET_DYN_BASE         (TASK_UNMAPPED_BASE)
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This can NOT be done in userspace

--Multipart=_Wed__8_Dec_2004_23_34_45_-0800_aqYOfdT_ZRbDpwhK
Content-Type: text/plain;
 name="et_dyn_base_26.diff"
Content-Disposition: attachment;
 filename="et_dyn_base_26.diff"
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/08 23:02:03-08:00 davem@nuts.davemloft.net 
#   [SPARC]: Adjust 32-bit ELF_ET_DYN_BASE.
#   
#   We were using 0x08000000 instead of TASK_UNMAPPED_BASE
#   so that running something like "/lib/ld-linux.so.2 emacs"
#   would work.
#   
#   The issue there was that wherever /lib/ld-linux.so.2 gets
#   mapped (controlled by ELF_ET_DYN_BASE), that is where the
#   BSS start for the process ends up.  Now, emacs allocates
#   dynamic memory for LISP objects from the BSS, and needs
#   the top 4 bits of the virtual address to be clear so that
#   it can encode LISP type and GC marking information there.
#   
#   But making this obscure emacs case work breaks lots of other
#   stuff.  For example, programs with a reasonably large data
#   section fail to load via direct ld.so interpreter execution
#   because the data section is large enough to begin overlapping
#   with the ELF_ET_DYN_BASE area.
#   
#   The /lib/ld-linux.so.2 emacs case does not work on a lot of
#   platforms due to this issue, including i386, so it is not
#   worth making work on sparc either.  It is indeed useful
#   sometimes when debugging a new experimental build of glibc
#   for example, but people doing that can hack the value of
#   ELF_ET_DYN_BASE in their kernels.  Perhaps at some point
#   we will make a sysctl controllable value.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# include/asm-sparc/elf.h
#   2004/12/08 22:56:54-08:00 davem@nuts.davemloft.net +1 -1
#   [SPARC]: Adjust 32-bit ELF_ET_DYN_BASE.
# 
# arch/sparc64/kernel/binfmt_elf32.c
#   2004/12/08 22:56:54-08:00 davem@nuts.davemloft.net +1 -1
#   [SPARC]: Adjust 32-bit ELF_ET_DYN_BASE.
# 
diff -Nru a/arch/sparc64/kernel/binfmt_elf32.c b/arch/sparc64/kernel/binfmt_elf32.c
--- a/arch/sparc64/kernel/binfmt_elf32.c	2004-12-08 23:05:11 -08:00
+++ b/arch/sparc64/kernel/binfmt_elf32.c	2004-12-08 23:05:11 -08:00
@@ -79,7 +79,7 @@
 
 #define elf_check_arch(x)	(((x)->e_machine == EM_SPARC) || ((x)->e_machine == EM_SPARC32PLUS))
 
-#define ELF_ET_DYN_BASE         0x08000000
+#define ELF_ET_DYN_BASE         0x70000000
 
 
 #include <asm/processor.h>
diff -Nru a/include/asm-sparc/elf.h b/include/asm-sparc/elf.h
--- a/include/asm-sparc/elf.h	2004-12-08 23:05:11 -08:00
+++ b/include/asm-sparc/elf.h	2004-12-08 23:05:11 -08:00
@@ -143,7 +143,7 @@
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE         (0x08000000)
+#define ELF_ET_DYN_BASE         (TASK_UNMAPPED_BASE)
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This can NOT be done in userspace

--Multipart=_Wed__8_Dec_2004_23_34_45_-0800_aqYOfdT_ZRbDpwhK--
