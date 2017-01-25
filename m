From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 25 Jan 2017 19:57:13 +0000
Subject: [PATCH v5 1/4] signals, sparc: Add signal codes for ADI violations
Message-Id: <9eba1d94727cb37dbe457c891f237e4ee694a7b1.1485362562.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1485362562.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1485362562.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de, davem@davemloft.net
Cc: Khalid Aziz <khalid.aziz@oracle.com>, hpa@zytor.com, 0x7f454c46@gmail.com, dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

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
3. Task attempted to access memory using wrong ADI tag and caused
   a precise exception.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index ec1f756..d1e860c 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -26,7 +26,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 8);
 	BUILD_BUG_ON(NSIGFPE  != 8);
-	BUILD_BUG_ON(NSIGSEGV != 4);
+	BUILD_BUG_ON(NSIGSEGV != 7);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 4);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 1abaf62..2446864 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -213,7 +213,10 @@ typedef struct siginfo {
 #define SEGV_ACCERR	(__SI_FAULT|2)	/* invalid permissions for mapped object */
 #define SEGV_BNDERR	(__SI_FAULT|3)  /* failed address bound checks */
 #define SEGV_PKUERR	(__SI_FAULT|4)  /* failed protection key checks */
-#define NSIGSEGV	4
+#define SEGV_ACCADI	(__SI_FAULT|5)	/* ADI not enabled for mapped object */
+#define SEGV_ADIDERR	(__SI_FAULT|6)	/* Disrupting MCD error */
+#define SEGV_ADIPERR	(__SI_FAULT|7)	/* Precise MCD exception */
+#define NSIGSEGV	7
 
 /*
  * SIGBUS si_codes
-- 
2.7.4

