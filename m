From: Roland McGrath <roland@redhat.com>
Date: Tue, 13 Mar 2007 08:25:28 +0000
Subject: [PATCH] sparc: avoid CHILD_MAX and OPEN_MAX constants
Message-Id: <20070313082528.E00F51801C5@magilla.sf.frob.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I don't figure anyone really cares about SunOS syscall emulation, and I
certainly don't.  But I'm getting rid of uses of the OPEN_MAX and CHILD_MAX
compile-time constant, and these are almost the only ones.  OPEN_MAX is a
bogus constant with no meaning about anything.  The RLIMIT_NOFILE resource
limit is what sysconf (_SC_OPEN_MAX) actually wants to return.

The CHILD_MAX cases weren't actually using anything I want to get rid of,
but I noticed that they are there and are wrong too.  The CHILD_MAX value
is not really unlimited as a -1 return from sysconf indicates.  The
RLIMIT_NPROC resource limit is what sysconf (_SC_CHILD_MAX) wants to return.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/sparc/kernel/sys_sunos.c     |    4 ++--
 arch/sparc64/kernel/sys_sunos32.c |    4 ++--
 arch/sparc64/solaris/misc.c       |    6 ++++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/sys_sunos.c b/arch/sparc/kernel/sys_sunos.c
index da6606f..f807172 100644  
--- a/arch/sparc/kernel/sys_sunos.c
+++ b/arch/sparc/kernel/sys_sunos.c
@@ -910,7 +910,7 @@ asmlinkage long sunos_sysconf (int name)
 		ret = ARG_MAX;
 		break;
 	case _SC_CHILD_MAX:
-		ret = -1; /* no limit */
+		ret = current->signal->rlim[RLIMIT_NPROC].rlim_cur;
 		break;
 	case _SC_CLK_TCK:
 		ret = HZ;
@@ -919,7 +919,7 @@ asmlinkage long sunos_sysconf (int name)
 		ret = NGROUPS_MAX;
 		break;
 	case _SC_OPEN_MAX:
-		ret = OPEN_MAX;
+		ret = current->signal->rlim[RLIMIT_NOFILE].rlim_cur;
 		break;
 	case _SC_JOB_CONTROL:
 		ret = 1;	/* yes, we do support job control */
diff --git a/arch/sparc64/kernel/sys_sunos32.c b/arch/sparc64/kernel/sys_sunos32.c
index 4cff95b..8f7a06e 100644  
--- a/arch/sparc64/kernel/sys_sunos32.c
+++ b/arch/sparc64/kernel/sys_sunos32.c
@@ -871,7 +871,7 @@ asmlinkage s32 sunos_sysconf (int name)
 		ret = ARG_MAX;
 		break;
 	case _SC_CHILD_MAX:
-		ret = -1; /* no limit */
+		ret = current->signal->rlim[RLIMIT_NPROC].rlim_cur;
 		break;
 	case _SC_CLK_TCK:
 		ret = HZ;
@@ -880,7 +880,7 @@ asmlinkage s32 sunos_sysconf (int name)
 		ret = NGROUPS_MAX;
 		break;
 	case _SC_OPEN_MAX:
-		ret = OPEN_MAX;
+		ret = current->signal->rlim[RLIMIT_NOFILE].rlim_cur;
 		break;
 	case _SC_JOB_CONTROL:
 		ret = 1;	/* yes, we do support job control */
diff --git a/arch/sparc64/solaris/misc.c b/arch/sparc64/solaris/misc.c
index bca16e8..9fcaad6 100644  
--- a/arch/sparc64/solaris/misc.c
+++ b/arch/sparc64/solaris/misc.c
@@ -363,8 +363,10 @@ asmlinkage int solaris_sysconf(int id)
 {
 	switch (id) {
 	case SOLARIS_CONFIG_NGROUPS:	return NGROUPS_MAX;
-	case SOLARIS_CONFIG_CHILD_MAX:	return -1; /* no limit */
-	case SOLARIS_CONFIG_OPEN_FILES:	return OPEN_MAX;
+	case SOLARIS_CONFIG_CHILD_MAX:
+		return current->signal->rlim[RLIMIT_NPROC].rlim_cur;
+	case SOLARIS_CONFIG_OPEN_FILES:
+		return current->signal->rlim[RLIMIT_NOFILE].rlim_cur;
 	case SOLARIS_CONFIG_POSIX_VER:	return 199309;
 	case SOLARIS_CONFIG_PAGESIZE:	return PAGE_SIZE;
 	case SOLARIS_CONFIG_XOPEN_VER:	return 3;
