From: Michael Witten <mfwitten@gmail.com>
Date: Fri, 04 Sep 2020 19:40:00 +0000
Subject: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions; use string size
Message-Id: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The following patch improves the quality and correctness of the openprom code.

I have neither a machine to test the result nor a toolchain to compile it, and
that is why it is listed currently as an "RFC". Nonetheless, I believe those
who do have these tools will find the proposed changes useful; I hope you will
help me iterate this patch into something worthy of merging (or use it as the
basis for your own changes).

Sincerely,
Michael Witten

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

This commit fixes or improves a conglomeration of related issues:

  * 'opiocnextprop()' was incorrectly implemented.
  * Integer conversions were not checked.
  * Faulty PROMs and users can leave out nul-termination
  * The confusion of string lengths for string sizes.

OPIOCNEXTPROP
======
According to NetBSD's documentation, this ioctl is supposed to
return a property's *name*. However, until this commit, it has
returned a property's *value*; this commit implements the return
of the name.

In addition, the 'op_buflen' field is now also updated, whereas
before it was not.

Conversions
=====
There are a number of different integer types used throughout this
code to represent the size of some buffer; this commit introduces
some checks to help ensure that these conversions will succeed, or
at least to help ensure that bad conversions will be handled in a
meaningful way.

Nul-Termination
=======
Faulty PROMs
------------

The Sun/Oracle documentation says that when returning data via the
user-supplied buffers, the data should be explicitly nul-terminated
if the buffer size is larger than the size of the data, just in case
a faulty PROM fails to include nul-termination properly.

In the "Sun" ioctls, this should already be handled, because the data
structure in question is zeroed when allocated, but this commit also
introduces some checks for this when the following kernel config is
defined:

  CONFIG_DEBUG_KERNEL

One BSD ioctl was amended to include this automatic nul-termination:

  OPIOCGET

User Error
----------

It is perhaps worth noting that the following helper function
was already being used to append a nul character to user data
provided to the BSD ioctl implementations:

  copyin_string()

The BSD documentation for those ioctl functions does indeed
refer to "counted" strings, which may mean that nul-termination
is not required, so the behavior of copyin_string() is merely
a defensive way to handle input that is not nul-terminated.
Such defensive programming is maintained by this commit; in
addition, where applicable, strlen() is used to determine a
length, rather than relying on a user-supplied value.

String Size
=====
There is an important distinction to be made between the following:

  * A nul-terminated string's size
  * A nul-terminated string's length

This commit tries to make this distinction as much as possible,
and assumes that all strings are intended to be nul-terminated.
The result is the following:

  * Sometimes a variable's name is simply changed (e.g., from
    'len' to 'size').

  * Sometimes 'strlen()' is called rather than relying on
    some buffer size.

  * Sometimes, there is the replacement of code that erroneously
    uses string length rather than string size.

All together, these changes make the code more robust and correct.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 arch/sparc/include/asm/prom.h   |   2 +-
 arch/sparc/kernel/prom_common.c |  14 +--
 drivers/sbus/char/openprom.c    | 263 ++++++++++++++++++++++++++++------------
 3 files changed, 194 insertions(+), 85 deletions(-)

diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index 587edb8b5a65..b523dab16877 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -30,7 +30,7 @@ struct of_irq_controller {
 };
 
 struct device_node *of_find_node_by_cpuid(int cpuid);
-int of_set_property(struct device_node *node, const char *name, void *val, int len);
+int of_set_property(struct device_node *node, const char *name, void *val, int size);
 extern struct mutex of_set_property_mutex;
 int of_getintprop_default(struct device_node *np,
 			  const char *name,
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index c9ec70888a39..fbc96c6e554c 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -34,10 +34,10 @@ EXPORT_SYMBOL(of_console_options);
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
-	int len;
+	int size;
 
-	prop = of_find_property(np, name, &len);
-	if (!prop || len != 4)
+	prop = of_find_property(np, name, &size);
+	if (!prop || size != 4)
 		return def;
 
 	return *(int *) prop->value;
@@ -47,14 +47,14 @@ EXPORT_SYMBOL(of_getintprop_default);
 DEFINE_MUTEX(of_set_property_mutex);
 EXPORT_SYMBOL(of_set_property_mutex);
 
-int of_set_property(struct device_node *dp, const char *name, void *val, int len)
+int of_set_property(struct device_node *dp, const char *name, void *val, int size)
 {
 	struct property **prevp;
 	unsigned long flags;
 	void *new_val;
 	int err;
 
-	new_val = kmemdup(val, len, GFP_KERNEL);
+	new_val = kmemdup(val, size, GFP_KERNEL);
 	if (!new_val)
 		return -ENOMEM;
 
@@ -70,12 +70,12 @@ int of_set_property(struct device_node *dp, const char *name, void *val, int len
 			void *old_val = prop->value;
 			int ret;
 
-			ret = prom_setprop(dp->phandle, name, val, len);
+			ret = prom_setprop(dp->phandle, name, val, size);
 
 			err = -EINVAL;
 			if (ret >= 0) {
 				prop->value = new_val;
-				prop->length = len;
+				prop->length = size;
 
 				if (OF_IS_DYNAMIC(prop))
 					kfree(old_val);
diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 30b9751aad30..9bc2877aa09a 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -16,6 +16,7 @@
  */
 
 
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -54,42 +55,76 @@ static struct device_node *options_node;
  * Copy an openpromio structure into kernel space from user space.
  * This routine does error checking to make sure that all memory
  * accesses are within bounds. A pointer to the allocated openpromio
- * structure will be placed in "*opp_p". Return value is the length
- * of the user supplied buffer.
+ * structure will be placed in "*opp_p". The return value is the size
+ * of the user supplied buffer; the return value is negative on error.
  */
-static int copyin(struct openpromio __user *info, struct openpromio **opp_p)
+static ssize_t copyin(struct openpromio __user *info, struct openpromio **opp_p)
 {
-	unsigned int bufsize;
+	unsigned int oprom_size;
+	size_t bufsize;
+	ssize_t result;
 
 	if (!info || !opp_p)
 		return -EFAULT;
 
-	if (get_user(bufsize, &info->oprom_size))
+	if (get_user(oprom_size, &info->oprom_size))
 		return -EFAULT;
 
-	if (bufsize = 0)
+	if (oprom_size = 0)
 		return -EINVAL;
 
+	static_assert(SIZE_MAX >= UINT_MAX);
+
 	/* If the bufsize is too large, just limit it.
 	 * Fix from Jason Rappleye.
 	 */
-	if (bufsize > OPROMMAXPARAM)
-		bufsize = OPROMMAXPARAM;
+	#if UINT_MAX <= OPROMMAXPARAM
+		bufsize = oprom_size;
+	#else
+		if (oprom_size <= OPROMMAXPARAM)
+			bufsize =  oprom_size;
+		else
+			bufsize = OPROMMAXPARAM;
+	#endif
+
+	#if CONFIG_DEBUG_KERNEL
+		if (WARN_ON(bufsize > OPROMMAXPARAM))
+			bufsize = OPROMMAXPARAM;
+	#endif
+
+	#if OPROMMAXPARAM > SIZE_MAX/2
+		if (bufsize > SIZE_MAX/2)
+			return -EFAULT;
+	#endif
+
+	result = (ssize_t)bufsize;
 
+	/* The buffer 'oprom_array' is often supposed to contain a
+	 * nul-terminated string, but the user may have erroneously
+	 * set 'oprom_size' to the length of that string rather than
+	 * the size of that string; therefore, the '+ 1' essentially
+	 * appends a nul character. Any code that expects a string
+	 * to be nul-terminated must not trust the size returned by
+	 * this function.
+	 */
+	static_assert(OPROMMAXPARAM <= SIZE_MAX - sizeof(int) - 1);
 	if (!(*opp_p = kzalloc(sizeof(int) + bufsize + 1, GFP_KERNEL)))
 		return -ENOMEM;
 
+	static_assert(ULONG_MAX >= SIZE_MAX);
 	if (copy_from_user(&(*opp_p)->oprom_array,
 			   &info->oprom_array, bufsize)) {
 		kfree(*opp_p);
 		return -EFAULT;
 	}
-	return bufsize;
+
+	return result;
 }
 
-static int getstrings(struct openpromio __user *info, struct openpromio **opp_p)
+static ssize_t getstrings(struct openpromio __user *info, struct openpromio **opp_p)
 {
-	int n, bufsize;
+	int n;
+	ssize_t bufsize;
 	char c;
 
 	if (!info || !opp_p)
@@ -98,9 +133,8 @@ static int getstrings(struct openpromio __user *info, struct openpromio **opp_p)
 	if (!(*opp_p = kzalloc(sizeof(int) + OPROMMAXPARAM + 1, GFP_KERNEL)))
 		return -ENOMEM;
 
-	(*opp_p)->oprom_size = 0;
-
-	n = bufsize = 0;
+	bufsize = n = 0;
+	static_assert((SIZE_MAX/2) >= OPROMMAXPARAM);
 	while ((n < 2) && (bufsize < OPROMMAXPARAM)) {
 		if (get_user(c, &info->oprom_array[bufsize])) {
 			kfree(*opp_p);
@@ -120,69 +154,109 @@ static int getstrings(struct openpromio __user *info, struct openpromio **opp_p)
 /*
  * Copy an openpromio structure in kernel space back to user space.
  */
-static int copyout(void __user *info, struct openpromio *opp, int len)
+static int copyout(void __user *info, struct openpromio *opp, const size_t size)
 {
-	if (copy_to_user(info, opp, len))
+	static_assert(ULONG_MAX >= SIZE_MAX);
+	if (copy_to_user(info, opp, size))
 		return -EFAULT;
 	return 0;
 }
 
-static int opromgetprop(void __user *argp, struct device_node *dp, struct openpromio *op, int bufsize)
+static int opromgetprop(void __user *argp, struct device_node *dp, struct openpromio *op, const size_t bufsize)
 {
 	const void *pval;
-	int len;
+	int pval_size;
 
 	if (!dp ||
-	    !(pval = of_get_property(dp, op->oprom_array, &len)) ||
-	    len <= 0 || len > bufsize)
+	    !(pval = of_get_property(dp, op->oprom_array, &pval_size)) ||
+	    pval_size <= 0 || pval_size > bufsize) {
+		#ifdef CONFIG_DEBUG_KERNEL
+			if (WARN_ON(op->oprom_size))
+				op->oprom_size = 0;
+		#endif
 		return copyout(argp, op, sizeof(int));
+	}
+
+	op->oprom_size = pval_size;
+	memcpy(op->oprom_array, pval, pval_size);
 
-	memcpy(op->oprom_array, pval, len);
-	op->oprom_array[len] = '\0';
-	op->oprom_size = len;
+	#ifdef CONFIG_DEBUG_KERNEL
+		// If the buffer is larger than needed, then
+		// the contents should be nul-terminated in
+		// case the PROM erroneously produces a string
+		// that is not nul-terminated.
+		if (pval_size < bufsize)
+			char *const end = op->oprom_array + pval_size;
+			if (WARN_ON(*end))
+				*end = 0;
+	#endif
 
 	return copyout(argp, op, sizeof(int) + bufsize);
 }
 
-static int opromnxtprop(void __user *argp, struct device_node *dp, struct openpromio *op, int bufsize)
+static int opromnxtprop(void __user *argp, struct device_node *dp, struct openpromio *op, const size_t bufsize)
 {
 	struct property *prop;
-	int len;
+	size_t name_size;
+	unsigned int uint_name_size;
 
 	if (!dp)
-		return copyout(argp, op, sizeof(int));
+		goto nothing;
+
 	if (op->oprom_array[0] = '\0') {
 		prop = dp->properties;
-		if (!prop)
-			return copyout(argp, op, sizeof(int));
-		len = strlen(prop->name);
 	} else {
 		prop = of_find_property(dp, op->oprom_array, NULL);
+		if (prop)
+			prop = prop->next;
+	}
 
-		if (!prop ||
-		    !prop->next ||
-		    (len = strlen(prop->next->name)) + 1 > bufsize)
-			return copyout(argp, op, sizeof(int));
+	if (!prop)
+		goto nothing;
 
-		prop = prop->next;
-	}
+	name_size = 1 + strlen(prop->name);
+
+	uint_name_size = name_size;
+	if (unlikely(uint_name_size != name_size))
+		goto nothing; // overflow
+
+	if (name_size > bufsize)
+		goto nothing;
 
-	memcpy(op->oprom_array, prop->name, len);
-	op->oprom_array[len] = '\0';
-	op->oprom_size = ++len;
+	memcpy(op->oprom_array, prop->name, name_size);
+	op->oprom_size = uint_name_size;
 
 	return copyout(argp, op, sizeof(int) + bufsize);
+
+nothing:
+	#ifdef CONFIG_DEBUG_KERNEL
+		if (WARN_ON(op->oprom_size))
+			op-oprom_size = 0;
+	#endif
+	return copyout(argp, op, sizeof(int));
 }
 
-static int opromsetopt(struct device_node *dp, struct openpromio *op, int bufsize)
+static int opromsetopt(struct device_node *dp, struct openpromio *op, const size_t name_value_size)
 {
-	char *buf = op->oprom_array + strlen(op->oprom_array) + 1;
-	int len = op->oprom_array + bufsize - buf;
+	const char *const name = op->oprom_array;
+	const size_t name_size = 1 + strlen(name);
+	char *const value = op->oprom_array + name_size;
+	const size_t value_size = name_value_size - name_size;
+	int int_value_size;
+
+	#if CONFIG_DEBUG_KERNEL
+		if (WARN_ON(name_value_size <= name_size))
+			return -EFAULT;
+	#endif
 
-	return of_set_property(options_node, op->oprom_array, buf, len);
+	if (unlikely(value_size > INT_MAX))
+		return -EINVAL;
+	int_value_size = (int)value_size;
+
+	return of_set_property(options_node, name, value, int_value_size);
 }
 
-static int opromnext(void __user *argp, unsigned int cmd, struct device_node *dp, struct openpromio *op, int bufsize, DATA *data)
+static int opromnext(void __user *argp, unsigned int cmd, struct device_node *dp, struct openpromio *op, const size_t bufsize, DATA *data)
 {
 	phandle ph;
 
@@ -229,7 +303,7 @@ static int opromnext(void __user *argp, unsigned int cmd, struct device_node *dp
 	return copyout(argp, op, bufsize + sizeof(int));
 }
 
-static int oprompci2node(void __user *argp, struct device_node *dp, struct openpromio *op, int bufsize, DATA *data)
+static int oprompci2node(void __user *argp, struct device_node *dp, struct openpromio *op, const size_t bufsize, DATA *data)
 {
 	int err = -EINVAL;
 
@@ -255,7 +329,7 @@ static int oprompci2node(void __user *argp, struct device_node *dp, struct openp
 	return err;
 }
 
-static int oprompath2node(void __user *argp, struct device_node *dp, struct openpromio *op, int bufsize, DATA *data)
+static int oprompath2node(void __user *argp, struct device_node *dp, struct openpromio *op, const size_t bufsize, DATA *data)
 {
 	phandle ph = 0;
 
@@ -269,16 +343,24 @@ static int oprompath2node(void __user *argp, struct device_node *dp, struct open
 	return copyout(argp, op, bufsize + sizeof(int));
 }
 
-static int opromgetbootargs(void __user *argp, struct openpromio *op, int bufsize)
+static int opromgetbootargs(void __user *argp, struct openpromio *op, const size_t bufsize)
 {
-	char *buf = saved_command_line;
-	int len = strlen(buf);
+	const char *const buf = saved_command_line;
+	const size_t size = 1 + strlen(buf);
+	unsigned int uint_size;
+
+	if (unlikely(size = 0))
+		return -EFAULT; // overflow
 
-	if (len > bufsize)
+	if (size > bufsize)
 		return -EINVAL;
 
-	strcpy(op->oprom_array, buf);
-	op->oprom_size = len;
+	if (unlikely(size > UINT_MAX))
+		return -EFAULT;
+	uint_size = (unsigned int)size;
+
+	memcpy(op->oprom_array, buf, size);
+	op->oprom_size = uint_size;
 
 	return copyout(argp, op, bufsize + sizeof(int));
 }
@@ -292,7 +374,8 @@ static long openprom_sunos_ioctl(struct file * file,
 {
 	DATA *data = file->private_data;
 	struct openpromio *opp = NULL;
-	int bufsize, error = 0;
+	ssize_t bufsize;
+	int error = 0;
 	static int cnt;
 	void __user *argp = (void __user *)arg;
 
@@ -301,6 +384,12 @@ static long openprom_sunos_ioctl(struct file * file,
 	else
 		bufsize = copyin(argp, &opp);
 
+	#ifdef CONFIG_DEBUG_KERNEL
+		if (WARN_ON(bufsize = 0))
+			bufsize = -EFAULT;
+	#enif
+
+	static_assert(LONG_MIN <= -(SIZE_MAX/2)-1);
 	if (bufsize < 0)
 		return bufsize;
 
@@ -373,7 +462,9 @@ static struct device_node *get_node(phandle n, DATA *data)
 /* Copy in a whole string from userspace into kernelspace. */
 static char * copyin_string(char __user *user, size_t len)
 {
-	if ((ssize_t)len < 0 || (ssize_t)(len + 1) < 0)
+	// Is this test even necessary? Surely, memdup_user_nul()
+	// will fail to allocate space in this condition.
+	if (len = SIZE_MAX)
 		return ERR_PTR(-EINVAL);
 
 	return memdup_user_nul(user, len);
@@ -388,7 +479,7 @@ static int opiocget(void __user *argp, DATA *data)
 	struct device_node *dp;
 	char *str;
 	const void *pval;
-	int err, len;
+	int err, size;
 
 	if (copy_from_user(&op, argp, sizeof(op)))
 		return -EFAULT;
@@ -399,15 +490,21 @@ static int opiocget(void __user *argp, DATA *data)
 	if (IS_ERR(str))
 		return PTR_ERR(str);
 
-	pval = of_get_property(dp, str, &len);
+	pval = of_get_property(dp, str, &size);
 	err = 0;
-	if (!pval || len > op.op_buflen) {
+	if (!pval || size > op.op_buflen) {
 		err = -EINVAL;
 	} else {
-		op.op_buflen = len;
+		const int buflen = op.op_buflen;
+		op.op_buflen = size;
 		if (copy_to_user(argp, &op, sizeof(op)) ||
-		    copy_to_user(op.op_buf, pval, len))
+		    copy_to_user(op.op_buf, pval, size))
 			err = -EFAULT;
+		if (size < buflen) {
+			const char c = 0;
+			if (copy_to_user(op.op_buf + size, &c, 1)) // To correct faulty PROMs
+				err = -EFAULT;
+		}
 	}
 	kfree(str);
 
@@ -420,7 +517,7 @@ static int opiocnextprop(void __user *argp, DATA *data)
 	struct device_node *dp;
 	struct property *prop;
 	char *str;
-	int len;
+	size_t name_size;
 
 	if (copy_from_user(&op, argp, sizeof(op)))
 		return -EFAULT;
@@ -443,18 +540,28 @@ static int opiocnextprop(void __user *argp, DATA *data)
 	kfree(str);
 
 	if (!prop)
-		len = 0;
-	else
-		len = prop->length;
+		name_size = 0;
+	else {
+		name_size = 1 + strlen(prop->name);
+		if (unlikely(name_size = 0))
+			return -EFAULT; // overflow
+	}
+
+	if (op.op_buflen <= 0)
+		op.op_buflen = 0;
+
+	if (name_size > op.op_buflen)
+		name_size = op.op_buflen;
+
+	if (unlikely(name_size > INT_MAX))
+		name_size = INT_MAX;
 
-	if (len > op.op_buflen)
-		len = op.op_buflen;
+	op.op_buflen = (int)name_size;
 
 	if (copy_to_user(argp, &op, sizeof(op)))
 		return -EFAULT;
 
-	if (len &&
-	    copy_to_user(op.op_buf, prop->value, len))
+	if (name_size && copy_to_user(op.op_buf, prop->name, name_size))
 		return -EFAULT;
 
 	return 0;
@@ -464,7 +571,7 @@ static int opiocset(void __user *argp, DATA *data)
 {
 	struct opiocdesc op;
 	struct device_node *dp;
-	char *str, *tmp;
+	char *name, *value;
 	int err;
 
 	if (copy_from_user(&op, argp, sizeof(op)))
@@ -474,20 +581,22 @@ static int opiocset(void __user *argp, DATA *data)
 	if (!dp)
 		return -EINVAL;
 
-	str = copyin_string(op.op_name, op.op_namelen);
-	if (IS_ERR(str))
-		return PTR_ERR(str);
+	name = copyin_string(op.op_name, op.op_namelen);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
 
-	tmp = copyin_string(op.op_buf, op.op_buflen);
-	if (IS_ERR(tmp)) {
-		kfree(str);
-		return PTR_ERR(tmp);
+	value = copyin_string(op.op_buf, op.op_buflen);
+	if (IS_ERR(value)) {
+		kfree(name);
+		return PTR_ERR(value);
 	}
 
-	err = of_set_property(dp, str, tmp, op.op_buflen);
+	// Note that op.op_buflen is not trusted; strlen() is
+	// used instead to calculate the proper size.
+	err = of_set_property(dp, name, value, 1 + strlen(value));
 
-	kfree(str);
-	kfree(tmp);
+	kfree(name);
+	kfree(value);
 
 	return err;
 }
-- 
2.22.0
