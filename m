From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 11 Apr 2004 16:24:18 +0000
Subject: Re: srmmu: out of nocache
Message-Id: <20040411162418.GA20914@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200403282153.19509.lists@naasa.net>
In-Reply-To: <200403282153.19509.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Apr 11, 2004 at 05:36:06PM +0200, Joerg Platte wrote:

> This happens with a 2.6.5er kernel with the following patch applied:

> Apr 11 15:05:10 ferdi kernel: bitmap out: size 8800 used 6268 off
> 8016 len 16 align 16 count 8816
> Apr 11 15:05:10 ferdi kernel: srmmu: out of nocache 4096: 2252800/1604608

It would appear that the allocation sequence patch is also needed,
then (below).  Please try with both patches while I brainstorm ways to
fix the problem for good.

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
