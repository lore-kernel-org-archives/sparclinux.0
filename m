From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 06 Sep 2004 12:01:09 +0000
Subject: Please test: 2.6 read of openpromfs entries loops
Message-Id: <20040906120109.GA1169@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On 2.6.8 I have openpromfs mounted as such:
none on /proc/openprom type openpromfs (rw)

After this, reading anything in /proc/openprom loops forever:
$ cat /proc/openprom/model
'SUNW,S20,501-2324'
'SUNW,S20,501-2324'
'SUNW,S20,501-2324'
'SUNW,S20,501-2324'
'SUNW,S20,501-2324'
...

The patch attached fixes this problem for me. Basically it uses
ppos in stead of f_pos.
Since I only have a sparc32, I'd think someone on sparc64 should try it
it as well.

Thanks,
-- 
Martin

--- 2.6.8/fs/openpromfs/inode.c.orig	2004-09-05 16:05:29.000000000 +0100
+++ 2.6.8/fs/openpromfs/inode.c	2004-09-06 12:24:00.958380519 +0100
@@ -73,13 +73,13 @@
 	if (count < 0 || !inode->u.generic_ip)
 		return -EINVAL;
 	sprintf (buffer, "%8.8x\n", (u32)(long)(inode->u.generic_ip));
-	if (file->f_pos >= 9)
+	if (*ppos >= 9)
 		return 0;
-	if (count > 9 - file->f_pos)
-		count = 9 - file->f_pos;
-	if (copy_to_user(buf, buffer + file->f_pos, count))
+	if (count > 9 - *ppos)
+		count = 9 - *ppos;
+	if (copy_to_user(buf, buffer + *ppos, count))
 		return -EFAULT;
-	file->f_pos += count;
+	*ppos += count;
 	return count;
 }
 
@@ -94,7 +94,7 @@
 	openprom_property *op;
 	char buffer[64];
 	
-	if (filp->f_pos >= 0xffffff || count >= 0xffffff)
+	if (*ppos >= 0xffffff || count >= 0xffffff)
 		return -EINVAL;
 	if (!filp->private_data) {
 		node = nodes[(u16)((long)inode->u.generic_ip)].node;
@@ -180,7 +180,7 @@
 	} else {
 		i = (op->len << 1) + 1;
 	}
-	k = filp->f_pos;
+	k = *ppos;
 	if (k >= i) return 0;
 	if (count > i - k) count = i - k;
 	if (op->flag & OPP_STRING) {
@@ -197,7 +197,7 @@
 			j = count;
 
 		if (j >= 0) {
-			if (copy_to_user(buf + k - filp->f_pos,
+			if (copy_to_user(buf + k - *ppos,
 					 op->value + k - 1, j))
 				return -EFAULT;
 			count -= j;
@@ -205,11 +205,11 @@
 		}
 
 		if (count) {
-			if (put_user('\'', &buf [k++ - filp->f_pos]))
+			if (put_user('\'', &buf [k++ - *ppos]))
 				return -EFAULT;
 		}
 		if (count > 1) {
-			if (put_user('\n', &buf [k++ - filp->f_pos]))
+			if (put_user('\n', &buf [k++ - *ppos]))
 				return -EFAULT;
 		}
 	} else if (op->flag & OPP_STRINGLIST) {
@@ -287,7 +287,7 @@
 		if ((k < i - 1) && (k & 1)) {
 			sprintf (buffer, "%02x",
 				 (unsigned char) *(op->value + (k >> 1)) & 0xff);
-			if (put_user(buffer[1], &buf[k++ - filp->f_pos]))
+			if (put_user(buffer[1], &buf[k++ - *ppos]))
 				return -EFAULT;
 			count--;
 		}
@@ -295,7 +295,7 @@
 		for (; (count > 1) && (k < i - 1); k += 2) {
 			sprintf (buffer, "%02x",
 				 (unsigned char) *(op->value + (k >> 1)) & 0xff);
-			if (copy_to_user(buf + k - filp->f_pos, buffer, 2))
+			if (copy_to_user(buf + k - *ppos, buffer, 2))
 				return -EFAULT;
 			count -= 2;
 		}
@@ -303,18 +303,18 @@
 		if (count && (k < i - 1)) {
 			sprintf (buffer, "%02x",
 				 (unsigned char) *(op->value + (k >> 1)) & 0xff);
-			if (put_user(buffer[0], &buf[k++ - filp->f_pos]))
+			if (put_user(buffer[0], &buf[k++ - *ppos]))
 				return -EFAULT;
 			count--;
 		}
 
 		if (count) {
-			if (put_user('\n', &buf [k++ - filp->f_pos]))
+			if (put_user('\n', &buf [k++ - *ppos]))
 				return -EFAULT;
 		}
 	}
-	count = k - filp->f_pos;
-	filp->f_pos = k;
+	count = k - *ppos;
+	*ppos = (loff_t) k;
 	return count;
 }
 
@@ -327,14 +327,14 @@
 	void *b;
 	openprom_property *op;
 	
-	if (filp->f_pos >= 0xffffff || count >= 0xffffff)
+	if (*ppos >= 0xffffff || count >= 0xffffff)
 		return -EINVAL;
 	if (!filp->private_data) {
 		i = property_read (filp, NULL, 0, NULL);
 		if (i)
 			return i;
 	}
-	k = filp->f_pos;
+	k = *ppos;
 	op = (openprom_property *)filp->private_data;
 	if (!(op->flag & OPP_STRING)) {
 		u32 *first, *last;
@@ -462,7 +462,7 @@
 				op->len = i;
 		} else
 			op->len = i;
-		filp->f_pos += count;
+		*ppos += count;
 	}
 write_try_string:
 	if (!(op->flag & OPP_BINARY)) {
@@ -480,7 +480,7 @@
 				op->flag |= OPP_QUOTED;
 				buf++;
 				count--;
-				filp->f_pos++;
+				(*ppos)++;
 				if (!count) {
 					op->flag |= OPP_STRING;
 					return 1;
@@ -489,9 +489,9 @@
 				op->flag |= OPP_NOTQUOTED;
 		}
 		op->flag |= OPP_STRING;
-		if (op->alloclen <= count + filp->f_pos) {
+		if (op->alloclen <= count + *ppos) {
 			b = kmalloc (sizeof (openprom_property)
-				     + 2 * (count + filp->f_pos), GFP_KERNEL);
+				     + 2 * (count + *ppos), GFP_KERNEL);
 			if (!b)
 				return -ENOMEM;
 			memcpy (b, filp->private_data,
@@ -499,14 +499,14 @@
 				+ strlen (op->name) + op->alloclen);
 			memset (((char *)b) + sizeof (openprom_property)
 				+ strlen (op->name) + op->alloclen, 
-				0, 2*(count - filp->f_pos) - op->alloclen);
+				0, 2*(count - *ppos) - op->alloclen);
 			op = (openprom_property *)b;
-			op->alloclen = 2*(count + filp->f_pos);
+			op->alloclen = 2*(count + *ppos);
 			b = filp->private_data;
 			filp->private_data = (void *)op;
 			kfree (b);
 		}
-		p = op->value + filp->f_pos - ((op->flag & OPP_QUOTED) ? 1 : 0);
+		p = op->value + *ppos - ((op->flag & OPP_QUOTED) ? 1 : 0);
 		if (copy_from_user(p, buf, count))
 			return -EFAULT;
 		op->flag |= OPP_DIRTY;
@@ -517,17 +517,17 @@
 			}
 		if (i < count) {
 			op->len = p - op->value;
-			filp->f_pos += i + 1;
+			*ppos += i + 1;
 			if ((p > op->value) && (op->flag & OPP_QUOTED)
 			    && (*(p - 1) = '\''))
 				op->len--;
 		} else {
 			if (p - op->value > op->len)
 				op->len = p - op->value;
-			filp->f_pos += count;
+			*ppos += count;
 		}
 	}
-	return filp->f_pos - k;
+	return *ppos - k;
 }
 
 int property_release (struct inode *inode, struct file *filp)
@@ -850,6 +850,7 @@
 		}
 	}
 out:
+	filp->f_version = 0;
 	unlock_kernel();
 	return 0;
 }
