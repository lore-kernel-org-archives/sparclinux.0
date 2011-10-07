From: David Miller <davem@davemloft.net>
Date: Fri, 07 Oct 2011 23:42:26 +0000
Subject: Re: longjmp question
Message-Id: <20111007.194226.1066813263621273392.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 8 Oct 2011 00:22:10 +0100

> At the end of the procedure %g3 contains the target (post-jump) frame 
> pointer address, which we would like to end up in %fp as a result of 
> restore instruction in the retl delay slot. To that end we write it to 
> a location determined by RW_FP, which is [%fp + 0x48]. However, 
> according to http://www.sics.se/~psm/sparcstack.html, which nicely 
> describes the layout of registers in memory and the effect of 
> save/restore operations, the post-restore frame pointer value should 
> be located at [%fp + 0x38], as we are only saving 16 word-sized 
> registers, and %fp is 15-th out of them (see Figure 4), so offset 
> should be 14 * 4 = 56 = 0x38. I'm not sure whether if that's just an 
> off-by-0x10, or I don't understand how this things work - anyone has 
> any ideas?

Strange... your analysis seems correct, but we might be missing something.

You'll probably find the following glibc commit amusing, and the commit
message is scant on details too :-/

commit ab52d206a3bd4dbd671b46a1797dee063926604e
Author: Ulrich Drepper <drepper@redhat.com>
Date:   Mon Sep 11 07:01:16 2000 +0000

    Update.
    
    2000-09-10  David S. Miller  <davem@redhat.com>
    
    	* sysdeps/sparc/sparc32/__longjmp.S (__longjmp): Correct %fp
    	frame pointer offset for non-fast path.
    
    2000-09-10  Ulrich Drepper  <drepper@redhat.com>
    
    	* locale/programs/3level.h (*_init): Initialize level1, level2,
    	and level3 as well.
    	(*_add): Remove a few unnecessary conditionals.

diff --git a/ChangeLog b/ChangeLog
index 007e433..8d9ddf7 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,14 @@
+2000-09-10  David S. Miller  <davem@redhat.com>
+
+	* sysdeps/sparc/sparc32/__longjmp.S (__longjmp): Correct %fp
+	frame pointer offset for non-fast path.
+
+2000-09-10  Ulrich Drepper  <drepper@redhat.com>
+
+	* locale/programs/3level.h (*_init): Initialize level1, level2,
+	and level3 as well.
+	(*_add): Remove a few unnecessary conditionals.
+
 2000-09-05  Wolfram Gloger  <wg@malloc.de>
 
 	* malloc/thread-m.h [_LIBC]: Even if not linking with libpthread,
diff --git a/locale/programs/3level.h b/locale/programs/3level.h
index d829332..5bb8929 100644
--- a/locale/programs/3level.h
+++ b/locale/programs/3level.h
@@ -66,8 +66,11 @@ struct TABLE
 static inline void
 CONCAT(TABLE,_init) (struct TABLE *t)
 {
+  t->level1 = NULL;
   t->level1_alloc = t->level1_size = 0;
+  t->level2 = NULL;
   t->level2_alloc = t->level2_size = 0;
+  t->level3 = NULL;
   t->level3_alloc = t->level3_size = 0;
 }
 
@@ -116,10 +119,8 @@ CONCAT(TABLE,_add) (struct TABLE *t, uint32_t wc, ELEMENT value)
 	  size_t alloc = 2 * t->level1_alloc;
 	  if (alloc <= index1)
 	    alloc = index1 + 1;
-	  t->level1 = (t->level1_alloc > 0
-		       ? (uint32_t *) xrealloc ((char *) t->level1,
-						alloc * sizeof (uint32_t))
-		       : (uint32_t *) xmalloc (alloc * sizeof (uint32_t)));
+	  t->level1 = (uint32_t *) xrealloc ((char *) t->level1,
+					     alloc * sizeof (uint32_t));
 	  t->level1_alloc = alloc;
 	}
       while (index1 >= t->level1_size)
@@ -131,10 +132,8 @@ CONCAT(TABLE,_add) (struct TABLE *t, uint32_t wc, ELEMENT value)
       if (t->level2_size = t->level2_alloc)
 	{
 	  size_t alloc = 2 * t->level2_alloc + 1;
-	  t->level2 = (t->level2_alloc > 0
-		       ? (uint32_t *) xrealloc ((char *) t->level2,
-						(alloc << t->q) * sizeof (uint32_t))
-		       : (uint32_t *) xmalloc ((alloc << t->q) * sizeof (uint32_t)));
+	  t->level2 = (uint32_t *) xrealloc ((char *) t->level2,
+					     (alloc << t->q) * sizeof (uint32_t));
 	  t->level2_alloc = alloc;
 	}
       i1 = t->level2_size << t->q;
@@ -151,10 +150,8 @@ CONCAT(TABLE,_add) (struct TABLE *t, uint32_t wc, ELEMENT value)
       if (t->level3_size = t->level3_alloc)
 	{
 	  size_t alloc = 2 * t->level3_alloc + 1;
-	  t->level3 = (t->level3_alloc > 0
-		       ? (ELEMENT *) xrealloc ((char *) t->level3,
-					       (alloc << t->p) * sizeof (ELEMENT))
-		       : (ELEMENT *) xmalloc ((alloc << t->p) * sizeof (ELEMENT)));
+	  t->level3 = (ELEMENT *) xrealloc ((char *) t->level3,
+					    (alloc << t->p) * sizeof (ELEMENT));
 	  t->level3_alloc = alloc;
 	}
       i1 = t->level3_size << t->p;
diff --git a/sysdeps/sparc/sparc32/__longjmp.S b/sysdeps/sparc/sparc32/__longjmp.S
index 1d49b26..ef83dee 100644
--- a/sysdeps/sparc/sparc32/__longjmp.S
+++ b/sysdeps/sparc/sparc32/__longjmp.S
@@ -1,4 +1,4 @@
-/* Copyright (C) 1991, 93, 96, 97, 98, 99 Free Software Foundation, Inc.
+/* Copyright (C) 1991, 93, 96, 97, 98, 99, 2000 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -23,7 +23,7 @@
 #include <bits/setjmp.h>
 #define ENV(base,reg) [%base + (reg * 4)]
 #define ST_FLUSH_WINDOWS 3
-#define RW_FP [%fp + 0x38]
+#define RW_FP [%fp + 0x48]
 
 ENTRY(__longjmp)
 	/* Store our arguments in global registers so we can still
