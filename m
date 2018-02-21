From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 17:15:43 +0000
Subject: [PATCH v12 01/11] signals, sparc: Add signal codes for ADI violations
Message-Id: <b1712b03774934c31afd9e394f07aae51eca74f8.1519227112.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de, hpa@zytor.com, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, ebiederm@xmission.com, anthony.yznaga@oracle.com, pombredanne@nexb.com, jroedel@suse.de, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

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
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v10:
	- Updated si_code definitions to match other definitions

 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index ac057f9b0763..41cf5996a2a9 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 11);
 	BUILD_BUG_ON(NSIGFPE  != 13);
-	BUILD_BUG_ON(NSIGSEGV != 4);
+	BUILD_BUG_ON(NSIGSEGV != 7);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 4);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 85dc965afd89..e94f03b3ee6f 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -246,7 +246,10 @@ typedef struct siginfo {
 #else
 # define SEGV_PKUERR	4	/* failed protection key checks */
 #endif
-#define NSIGSEGV	4
+#define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
+#define SEGV_ADIDERR	6	/* Disrupting MCD error */
+#define SEGV_ADIPERR	7	/* Precise MCD exception */
+#define NSIGSEGV	7
 
 /*
  * SIGBUS si_codes
-- 
2.11.0

