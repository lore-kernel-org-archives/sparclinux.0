From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 29 Mar 2004 10:21:27 +0000
Subject: Re: srmmu: out of nocache
Message-Id: <20040329102127.GA22081@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200403282153.19509.lists@naasa.net>
In-Reply-To: <200403282153.19509.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 29, 2004 at 08:25:09AM +0200, Joerg Platte wrote:

> OK, here's the first report for a 2.6.4... :-) I had more problems with a 
> 2.6.3, but the problem remains... Is it possible to increase the nocached 
> part of the memory?

Yes, but I don't recommend it.  You're using only about 2/3 of the
pagetable memory when you run out because of fragmentation.

This patch changes the next-fit allocator to a next/first to possibly
reduce fragmentation.  There is some performance cost associated.
Please try it and report your results.  If it does fail, the log
messages are important.

Thanks.

=== arch/sparc/lib/bitext.c 1.1 vs edited ==--- 1.1/arch/sparc/lib/bitext.c	Wed Apr 30 01:05:41 2003
+++ edited/arch/sparc/lib/bitext.c	Mon Mar 29 01:57:44 2004
@@ -42,7 +42,10 @@
 		BUG();
 
 	spin_lock(&t->lock);
-	offset = t->last_off & ~align1;
+	if (len < t->last_size)
+		offset = t->first_free;
+	else
+		offset = t->last_off & ~align1;
 	count = 0;
 	for (;;) {
 		off_new = find_next_zero_bit(t->map, t->size, offset);
@@ -71,9 +74,14 @@
 			if (i = len) {
 				for (i = 0; i < len; i++)
 					__set_bit(offset + i, t->map);
+				if (offset = t->first_free)
+					t->first_free = find_next_zero_bit
+							(t->map, t->size,
+							 t->first_free + len);
 				if ((t->last_off = offset + len) >= t->size)
 					t->last_off = 0;
 				t->used += len;
+				t->last_size = len;
 				spin_unlock(&t->lock);
 				return offset;
 			}
@@ -96,6 +104,8 @@
 			BUG();
 		__clear_bit(offset + i, t->map);
 	}
+	if (offset < t->first_free)
+		t->first_free = offset;
 	t->used -= len;
 	spin_unlock(&t->lock);
 }
@@ -111,4 +121,6 @@
 	spin_lock_init(&t->lock);
 	t->map = map;
 	t->size = size;
+	t->last_size = 0;
+	t->first_free = 0;
 }
=== include/asm-sparc/bitext.h 1.2 vs edited ==--- 1.2/include/asm-sparc/bitext.h	Thu Oct 30 12:50:10 2003
+++ edited/include/asm-sparc/bitext.h	Mon Mar 29 01:39:07 2004
@@ -15,6 +15,8 @@
 	int size;
 	int used;
 	int last_off;
+	int last_size;
+	int first_free;
 };
 
 extern int bit_map_string_get(struct bit_map *t, int len, int align);


-- 
Keith M Wesolowski
