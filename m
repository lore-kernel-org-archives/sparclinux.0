From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 26 Feb 2021 21:26:31 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <6cd974c1-4727-8245-f149-7f971a3965d5@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

On 2/26/21 11:03 AM, Meelis Roos wrote:
>
>>> This resulted in a crash (this is different, irq5 during mm code):
>>>
>>> [  304.847868] Unable to handle kernel paging request at virtual 
>>> address ffffffffffffe000
>>
>>
>> But what was the last "fixing up no fault insn" message you got 
>> before this panic? I need that to be sure that this is just another 
>> instance of the other panics and not a different cause.
>
>
> Rechecked with the same kernel image of last patch only, this time the 
> fault address is different, but still no previous debug messages 
> (probably expected since no previous patches are there),
> just starts with
> Unable to handle kernel paging request at virtual address 
> 256c780a00000000
> And the rest of addresses and backtrace is also different.
>
>> Also, did you apply this code patch along with others or was it 
>> alone? If alone, please try running with all 3 patches applied. My 
>> logic leads me to believe that you should not see any panics/hangs 
>> with all the code changes applied.
>
> I hope to have the SSH console connection in better shape now (no 
> mikrotik jumphost on the way), will start retesting with incremental 
> patches.
>

Here is a single patch that does everything, and is cleaned up and more 
concise. If this all works then I can send it as an official patch 
(though with the printk removed of course.)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 27778b6..13d8763 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -275,14 +275,14 @@ bool is_no_fault_exception(struct pt_regs *regs)
                         asi = (regs->tstate >> 24); /* saved %asi       */
                 else
                         asi = (insn >> 5);          /* immediate asi    */
-               if ((asi & 0xf2) = ASI_PNF) {
-                       if (insn & 0x1000000) {     /* op3[5:4]=3       */
-                               handle_ldf_stq(insn, regs);
-                               return true;
-                       } else if (insn & 0x200000) { /* op3[2], stores */
+               if ((asi & 0xf6) = ASI_PNF) {
+                       if (insn & 0x200000)        /* op3[2], stores   */
                                 return false;
-                       }
-                       handle_ld_nf(insn, regs);
+                       printk(KERN_ALERT "fixing up no fault insn 
%x\n", insn);
+                       if (insn & 0x1000000)       /* op3[5:4]=3 (fp)  */
+                               handle_ldf_stq(insn, regs);
+                       else
+                               handle_ld_nf(insn, regs);
                         return true;
                 }
         }
