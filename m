From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 09 Jun 2009 11:22:18 +0000
Subject: [PATCH 6/7] Handle sparc-leon SRMMU specific bug
Message-Id: <4A2E45EA.5040705@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000200020307040605020301"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000200020307040605020301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From f95779d3a4d478d9df1070cc54a42163993f3b97 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 13:05:17 +0200
Subject: [PATCH 6/7] Handle sparc-leon SRMMU specific bug. Shielded by CONFIG_LEON.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
  arch/sparc/mm/fault_32.c |    6 +++++-
  1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 12e447f..602eb82 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -227,7 +227,11 @@ asmlinkage void do_sparc_fault(struct pt
  	 */
  good_area:
  	info.si_code = SEGV_ACCERR;
-	if(write) {
+	if (write
+#ifdef CONFIG_LEON
+	   && !text_fault
+#endif
+	   ) {
  		if(!(vma->vm_flags & VM_WRITE))
  			goto bad_area;
  	} else {
-- 
1.4.2.1


--------------000200020307040605020301
Content-Type: text/plain;
 name="0006-Handle-sparc-leon-SRMMU-specific-bug.-Shielded-by-CONFIG_LEON.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0006-Handle-sparc-leon-SRMMU-specific-bug.-Shielded-by-CONFI";
 filename*1="G_LEON.txt"

From f95779d3a4d478d9df1070cc54a42163993f3b97 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 13:05:17 +0200
Subject: [PATCH 6/7] Handle sparc-leon SRMMU specific bug. Shielded by CONFIG_LEON.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/mm/fault_32.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 12e447f..602eb82 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -227,7 +227,11 @@ asmlinkage void do_sparc_fault(struct pt
 	 */
 good_area:
 	info.si_code = SEGV_ACCERR;
-	if(write) {
+	if (write
+#ifdef CONFIG_LEON
+	   && !text_fault
+#endif
+	   ) {
 		if(!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-- 
1.4.2.1


--------------000200020307040605020301--
