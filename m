From: konrad@gaisler.com
Date: Wed, 10 Jun 2009 10:21:15 +0000
Subject: [PATCH 6/7] Handle sparc-leon SRMMU specific bug. Shielded by CONFIG_SPARC_LEON.
Message-Id: <1244629275-24007-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45EA.5040705@gaisler.com>
In-Reply-To: <4A2E45EA.5040705@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

>> +#ifdef CONFIG_LEON
>> +	   && !text_fault
>> +#endif
>> +	   ) {
>>  		if(!(vma->vm_flags & VM_WRITE))
>>  			goto bad_area;
>>  	} else {
> 
> We do not break up an if like this.
> And you need to comment on this.
> Consider using an inline helper function or similar to avoid
> obscufating the code.
> 

I added a additional comment.


---
 arch/sparc/mm/fault_32.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 12e447f..99c1e29 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -227,7 +227,14 @@ asmlinkage void do_sparc_fault(struct pt
 	 */
 good_area:
 	info.si_code = SEGV_ACCERR;
-	if(write) {
+	if (write
+#ifdef CONFIG_SPARC_LEON
+	    /* a hardware bug in the sparc-leon SRMMU makes icache
+	       text_fault look as if writing in certain sparc-leon
+	       versions */
+	   && !text_fault
+#endif
+	   ) {
 		if(!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-- 
1.4.2.1

