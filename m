From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 09 Aug 2017 21:25:57 +0000
Subject: [PATCH v7 4/9] sparc64: Add HV fault type handlers for ADI related faults
Message-Id: <870629f367fbd5d487a54b3796f66348218b5d7d.1502219353.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1502219353.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1502219353.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, vegard.nossum@oracle.com, mingo@kernel.org, peterz@infradead.org, dan.carpenter@oracle.com, Liam.Howlett@oracle.com, paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

ADI (Application Data Integrity) feature on M7 and newer processors
adds new fault types for hypervisor - Invalid ASI and MCD disabled.
This patch expands data access exception handler to handle these
faults.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
v7:
	- new patch split off from patch 4/4 in v6

 arch/sparc/kernel/traps_64.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 88eed0dc3faf..88c96d349f2f 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -352,12 +352,35 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	info.si_signo = SIGSEGV;
+	/* MCD (Memory Corruption Detection) disabled trap (TT=0x19) in HV
+	 * is vectored thorugh data access exception trap with fault type
+	 * set to HV_FAULT_TYPE_MCD_DIS. Check for MCD disabled trap.
+	 * Accessing an address with invalid ASI for the address, for
+	 * example setting an ADI tag on an address with ASI_MCD_PRIMARY
+	 * when TTE.mcd is not set for the VA, is also vectored into
+	 * kerbel by HV as data access exception with fault type set to
+	 * HV_FAULT_TYPE_INV_ASI.
+	 */
 	info.si_errno = 0;
-	info.si_code = SEGV_MAPERR;
 	info.si_addr = (void __user *) addr;
 	info.si_trapno = 0;
-	force_sig_info(SIGSEGV, &info, current);
+	switch (type) {
+	case HV_FAULT_TYPE_INV_ASI:
+		info.si_signo = SIGILL;
+		info.si_code = ILL_ILLADR;
+		force_sig_info(SIGILL, &info, current);
+		break;
+	case HV_FAULT_TYPE_MCD_DIS:
+		info.si_signo = SIGSEGV;
+		info.si_code = SEGV_ACCADI;
+		force_sig_info(SIGSEGV, &info, current);
+		break;
+	default:
+		info.si_signo = SIGSEGV;
+		info.si_code = SEGV_MAPERR;
+		force_sig_info(SIGSEGV, &info, current);
+		break;
+	}
 }
 
 void sun4v_data_access_exception_tl1(struct pt_regs *regs, unsigned long addr, unsigned long type_ctx)
-- 
2.11.0

