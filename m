From: Allen Pais <allen.pais@oracle.com>
Date: Thu, 20 Jul 2017 07:52:37 +0000
Subject: [PATCH 3/3] sparc64: Increase max_phys_bits to 51 for M8.
Message-Id: <1500536437-14589-3-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>

On M8 chips, use a max_phys_bits value of 51 and also fix the VA hole.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/mm/init_64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 612b53a..7ebc17a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1936,12 +1936,18 @@ static void __init setup_page_offset(void)
 			break;
 		case SUN4V_CHIP_SPARC_M7:
 		case SUN4V_CHIP_SPARC_SN:
-		default:
 			/* M7 and later support 52-bit virtual addresses.  */
 			sparc64_va_hole_top =    0xfff8000000000000UL;
 			sparc64_va_hole_bottom = 0x0008000000000000UL;
 			max_phys_bits = 49;
 			break;
+               case SUN4V_CHIP_SPARC_M8:
+               default:
+                       /* M8 and later support 54-bit virtual addresses.  */
+                       sparc64_va_hole_top =    0xffe0000000000000UL;
+                       sparc64_va_hole_bottom = 0x0020000000000000UL;
+                       max_phys_bits = 51;
+                       break;
 		}
 	}
 
-- 
1.9.1

