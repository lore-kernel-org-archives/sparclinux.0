From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 17 Jan 2011 17:35:27 +0000
Subject: Re: silo fails to build with e2fsprogs-1.41.14 (undefined
Message-Id: <1295285727.13721.8.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <4D2B59AC.8040203@gentoo.org>
In-Reply-To: <4D2B59AC.8040203@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2011-01-17 at 17:23 +0000, Alex Buell wrote:
> On Mon, 2011-01-17 at 17:02 +0000, Richard Mortimer wrote:
> 
> > >> -    malloc_ptr = (char *) ((((unsigned long) malloc_ptr) + 7)&
> (~7));
> > >> +    malloc_ptr = align_ptr_to(malloc_ptr, 7UL);
> > I think that should be 8UL because align_ptr_to does -1 to make it
> 7.
> 
> > >> +    malloc_ptr = align_ptr_to(malloc_ptr, 7UL);
> > Ditto
> 
> That would explain the different error, this time it was 256, the
> previous error was -1^32. 
> 
> I'll change the patch with the new values and see if that works. 

Well done, that fixed the problem. Thank you. For anyone who's
interested, here's the patch in full with Richard Mortimer's changes:

diff -uNr silo-1.4.14/second/fs/ext2.c silo/second/fs/ext2.c
--- a/common/malloc.c
+++ b/common/malloc.c
@@ -27,6 +27,12 @@ static char *malloc_ptr = (char *) MALLOC_BASE;
 
 static char *last_alloc = 0;
 
+static char *align_ptr_to(char *ptr, unsigned long align)
+{
+    return (char *) ((((unsigned long) ptr) + (align - 1UL)) &
+                    ~(align - 1UL));
+}
+
 void *malloc (int size)
 {
     char *caddr;
@@ -34,10 +40,34 @@ void *malloc (int size)
     caddr = malloc_ptr;
     malloc_ptr += size;
     last_alloc = caddr;
-    malloc_ptr = (char *) ((((unsigned long) malloc_ptr) + 7) & (~7));
+    malloc_ptr = align_ptr_to(malloc_ptr, 8UL);
     return caddr;
 }
 
+int posix_memalign(void **memptr, unsigned long alignment, unsigned
long size)
+{
+    char *caddr;
+
+    if (alignment & (alignment - 1UL))
+        return -1;
+    if (alignment & (sizeof(void *) - 1UL))
+        return -1;
+
+    if (size = 0) {
+      *memptr = (void *) 0;
+      return 0;
+    }
+
+    caddr = align_ptr_to(malloc_ptr, alignment);
+    malloc_ptr = (caddr + size);
+    last_alloc = caddr;
+    malloc_ptr = align_ptr_to(malloc_ptr, 8UL);
+
+    *memptr = caddr;
+
+    return 0;
+}
+
 void free (void *m)
 {
     if (m = last_alloc)

-- 
Tactical Nuclear Kittens
