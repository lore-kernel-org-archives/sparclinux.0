From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Thu, 16 Nov 2017 14:38:24 +0000
Subject: [PATCH RESEND v10 01/10] signals, sparc: Add signal codes for ADI violations
Message-Id: <b52fbbf0de4a0aaeef31b0e0919eeedf5950cf9f.1510768775.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1510768775.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1510768775.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de, hpa@zytor.com, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, 0x7f454c46@gmail.com, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, jroedel@suse.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

SPARC M7 processor introduces a new feature - Application Data
Integrity (ADI). ADI allows MMU to  catch rogue accesses to memory.
When a rogue access occurs, MMU blocks the access and raises an
exception. In response to the exception, kernel sends the offending
task a SIGSEGV with si_code that indicates the nature of exception.
This patch adds three new signal codes specific to ADI feature:

1. ADI is not enabled for the address and task attempted to access
   memory using ADI
2. Task attempted to access memory using wrong ADI tag and caused
   a deferred exception.
3. Task attempted to access memory using wrong ADI Ttag and caused
   a precise exception.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
v10:
	- Updated si_code definitions to match other definitions

 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 8c6da1a643da..20be1bc923f9 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 8);
 	BUILD_BUG_ON(NSIGFPE  != 8);
-	BUILD_BUG_ON(NSIGSEGV != 4);
+	BUILD_BUG_ON(NSIGSEGV != 7);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 4);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index e447283b8f52..279b7c0d2977 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -202,7 +202,10 @@ typedef struct siginfo {
 #define SEGV_ACCERR	2	/* invalid permissions for mapped object */
 #define SEGV_BNDERR	3	/* failed address bound checks */
 #define SEGV_PKUERR	4	/* failed protection key checks */
-#define NSIGSEGV	4
+#define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
+#define SEGV_ADIDERR	6	/* Disrupting MCD error */
+#define SEGV_ADIPERR	7	/* Precise MCD exception */
+#define NSIGSEGV	7
 
 /*
  * SIGBUS si_codes
-- 
2.11.0

