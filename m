From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Sat, 29 Jul 2017 01:29:32 +0000
Subject: [PATCH v3] sparc64: Increase max_phys_bits to 51 and VA bits to 53 for M8.
Message-Id: <1501291772-470855-1-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On M8 chips, use a max_phys_bits value of 51.

Also, M8 supports VA bits up to 54 bits. However, for now
restrict VA bits to 53 due to 4-level pagetable limitation.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/mm/init_64.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index a111625..d4d96b8 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1921,12 +1921,22 @@ static void __init setup_page_offset(void)
 			break;
 		case SUN4V_CHIP_SPARC_M7:
 		case SUN4V_CHIP_SPARC_SN:
-		default:
 			/* M7 and later support 52-bit virtual addresses.  */
 			sparc64_va_hole_top =    0xfff8000000000000UL;
 			sparc64_va_hole_bottom = 0x0008000000000000UL;
 			max_phys_bits = 49;
 			break;
+		case SUN4V_CHIP_SPARC_M8:
+		default:
+			/* M8 and later support 54-bit virtual addresses.
+			 * However, restricting M8 and above VA bits to 53
+			 * as 4-level page table cannot support more than
+			 * 53 VA bits.
+			 */
+			sparc64_va_hole_top =    0xfff0000000000000UL;
+			sparc64_va_hole_bottom = 0x0010000000000000UL;
+			max_phys_bits = 51;
+			break;
 		}
 	}
 
-- 
1.7.1

