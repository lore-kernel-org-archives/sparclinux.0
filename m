From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 01 Sep 2004 21:57:47 +0000
Subject: Re: Fwd: [patch] uts-semaphore fix for sparc64 solaris emu for
Message-Id: <20040901145747.7cec62f9.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <23088.1094052429@www41.gmx.net>
In-Reply-To: <23088.1094052429@www41.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I think this is a better fix.

The based problem is that this thing is a macro at all,
that is where the problems come from.  It was also
implementing strnchr() by hand as well, so I fixed
that too.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/01 14:40:21-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: Fix set_utsname returning with uts semaphore held.
#   
#   Based upon a patch from Alexander Stohr.
#   
#   This thing was also reimplementing strnchr() as well.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# arch/sparc64/solaris/misc.c
#   2004/09/01 14:39:26-07:00 davem@nuts.davemloft.net +44 -25
#   [SPARC64]: Fix set_utsname returning with uts semaphore held.
# 
diff -Nru a/arch/sparc64/solaris/misc.c b/arch/sparc64/solaris/misc.c
--- a/arch/sparc64/solaris/misc.c	2004-09-01 14:40:53 -07:00
+++ b/arch/sparc64/solaris/misc.c	2004-09-01 14:40:53 -07:00
@@ -137,21 +137,34 @@
 	return sunos_brk(brk);
 }
 
-#define set_utsfield(to, from, dotchop, countfrom) {			\
-	char *p; 							\
-	int i, len = (countfrom) ? 					\
-		((sizeof(to) > sizeof(from) ? 				\
-			sizeof(from) : sizeof(to))) : sizeof(to); 	\
-	if (copy_to_user(to, from, len))				\
-		return -EFAULT;						\
-	if (dotchop) 							\
-		for (p=from,i=0; *p && *p != '.' && --len; p++,i++); 	\
-	else 								\
-		i = len - 1; 						\
-	if (__put_user('\0', (char __user *)((to)+i)))			\
-		return -EFAULT;						\
+static int __set_utsfield(char __user *to, int to_size,
+			  const char *from, int from_size,
+			  int dotchop, int countfrom)
+{
+	int len = countfrom ? (to_size > from_size ?
+			       from_size : to_size) : to_size;
+	int off;
+
+	if (copy_to_user(to, from, len))
+		return -EFAULT;
+
+	if (dotchop) {
+		off = (strnchr(from, len, '.') - from);
+	} else{
+		off = len - 1;
+	}
+
+	if (__put_user('\0', to + off))
+		return -EFAULT;
+
+	return 0;
 }
 
+#define set_utsfield(to, from, dotchop, countfrom) \
+	__set_utsfield((to), sizeof(to), \
+		       (from), sizeof(from), \
+		       (dotchop), (countfrom))
+
 struct sol_uname {
 	char sysname[9];
 	char nodename[9];
@@ -219,17 +232,20 @@
 asmlinkage int solaris_utssys(u32 buf, u32 flags, int which, u32 buf2)
 {
 	struct sol_uname __user *v = A(buf);
+	int err;
+
 	switch (which) {
 	case 0:	/* old uname */
 		/* Let's cheat */
-		set_utsfield(v->sysname, "SunOS", 1, 0);
+		err  = set_utsfield(v->sysname, "SunOS", 1, 0);
 		down_read(&uts_sem);
-		set_utsfield(v->nodename, system_utsname.nodename, 1, 1);
+		err |= set_utsfield(v->nodename, system_utsname.nodename,
+				    1, 1);
 		up_read(&uts_sem);
-		set_utsfield(v->release, "2.6", 0, 0);
-		set_utsfield(v->version, "Generic", 0, 0);
-		set_utsfield(v->machine, machine(), 0, 0);
-		return 0;
+		err |= set_utsfield(v->release, "2.6", 0, 0);
+		err |= set_utsfield(v->version, "Generic", 0, 0);
+		err |= set_utsfield(v->machine, machine(), 0, 0);
+		return (err ? -EFAULT : 0);
 	case 2: /* ustat */
 		return -ENOSYS;
 	case 3: /* fusers */
@@ -242,15 +258,18 @@
 asmlinkage int solaris_utsname(u32 buf)
 {
 	struct sol_utsname __user *v = A(buf);
+	int err;
+
 	/* Why should we not lie a bit? */
 	down_read(&uts_sem);
-	set_utsfield(v->sysname, "SunOS", 0, 0);
-	set_utsfield(v->nodename, system_utsname.nodename, 1, 1);
-	set_utsfield(v->release, "5.6", 0, 0);
-	set_utsfield(v->version, "Generic", 0, 0);
-	set_utsfield(v->machine, machine(), 0, 0);
+	err  = set_utsfield(v->sysname, "SunOS", 0, 0);
+	err |= set_utsfield(v->nodename, system_utsname.nodename, 1, 1);
+	err |= set_utsfield(v->release, "5.6", 0, 0);
+	err |= set_utsfield(v->version, "Generic", 0, 0);
+	err |= set_utsfield(v->machine, machine(), 0, 0);
 	up_read(&uts_sem);
-	return 0;
+
+	return (err ? -EFAULT : 0);
 }
 
 #define SI_SYSNAME		1       /* return name of operating system */
