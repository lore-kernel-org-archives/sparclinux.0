From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 23 Mar 2016 22:41:07 +0000
Subject: [Patch V2 1/2] sparc64 changes for gdb-7.6
Message-Id: <1458772868-10255-2-git-send-email-dave.kleikamp@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Originally by Karl Volz <karl.volz@oracle.com>
---
 gdb-7.6.patch |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/gdb-7.6.patch b/gdb-7.6.patch
index 5bd9b0c..8b2d5c8 100644
--- a/gdb-7.6.patch
+++ b/gdb-7.6.patch
@@ -2044,3 +2044,40 @@ diff -up gdb-7.6/bfd/elf64-ppc.c.orig gdb-7.6/bfd/elf64-ppc.c
  		  {
  		    struct type *target = TYPE_TYPEDEF_FIELD_TYPE (type, i);
  
+diff -up gdb-7.6/gdb/dwarf2read.c.old gdb-7.6/gdb/dwarf2read.c
+--- gdb-7.6/gdb/dwarf2read.c.old	2014-02-11 10:29:01.668110122 -0800
++++ gdb-7.6/gdb/dwarf2read.c	2014-02-11 14:13:30.257151330 -0800
+@@ -84,6 +84,10 @@ static int dwarf2_read_debug = 0;
+ /* When non-zero, dump DIEs after they are read in.  */
+ static unsigned int dwarf2_die_debug = 0;
+ 
++#if defined(__sparc__) && __WORDSIZE = 64
++static int pagesize;
++#endif
++
+ /* When non-zero, cross-check physname against demangler.  */
+ static int check_physname = 0;
+ 
+@@ -1932,9 +1936,21 @@ dwarf2_read_section (struct objfile *obj
+ 
+   abfd = sectp->owner;
+ 
++#if defined(__sparc__) && __WORDSIZE = 64
++  if (pagesize = 0)
++    pagesize = getpagesize ();
++#endif
++
+   /* If the section has relocations, we must read it ourselves.
+-     Otherwise we attach it to the BFD.  */
++     Otherwise we attach it to the BFD.  
++     Also, in sparc64 only try mmap for sections which
++     are properly aligned in order to avoid SIGBUS errors.  */
++
++#if defined(__sparc__) && __WORDSIZE = 64
++  if (info->size > 4 * pagesize && (sectp->flags & SEC_RELOC) = 0 && !(sectp->filepos & 0x3))
++#else
+   if ((sectp->flags & SEC_RELOC) = 0)
++#endif
+     {
+       const gdb_byte *bytes = gdb_bfd_map_section (sectp, &info->size);
+ 
-- 
1.7.1

