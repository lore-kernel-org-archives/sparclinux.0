From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 22 Feb 2021 22:35:05 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <5c14289d-501f-ed36-e1dd-ec00a540a823@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

On 2/22/21 12:34 PM, Meelis Roos wrote:
> Hello!
>
>>> 1. https://www.spinics.net/lists/sparclinux/msg25915.html
>>> 2. https://www.spinics.net/lists/sparclinux/msg25917.html
>>
>> I've looked at those and they don't contain the information I am 
>> interested in. I believe that stress-ng issues random opcodes in 
>> order to test how the system reacts. The actual random opcodes are 
>> what I need to see printed out directly from stress-ng before it 
>> actually executes the opcode. The kernel crash traces do not show 
>> those, just the aftermath. For instance, in the second trace I can 
>> see that the faulting instruction is c2070005 (lduw [ %i4 + %g5 ], 
>> %g1) and with i4: 00000000010e11c0 and g5: 794b00a7d5ede977, we can 
>> see how that instruction generated an unaligned access. But that is 
>> not the instruction executed by stress-ng, it's an instruction in the 
>> kernel, operating on faulty data, and I can't tell from the trace 
>> where that strange g5 value came from. The actual user instruction 
>> that was executed may provide a good hint.
>
>
> I instrumented stress-ng with simple opcode block logging patch 
> https://pastebin.com/1dZiCzCg and the results are hard to find usable, 
> so far :(
>
> 1. The amount of code generated at each try is huge - last time it was 
> more than the scrollback buffer of my "screen".
>
> 2. Adding these logging statements makes the bug harder to trigger - 
> tried on 5.10 and it ran fine multiple times and then  failed but that 
> took many minutes of running before the crash. I was observing the 
> data over SSH, that might also change scheduling/CPU usage.
>
> Any ideas for better logging that would not be in the way?
>

Here are a few things to try:

1. If you want to do it just with ng-stress, you could change it so that 
instead of generating a random opcode and executing it, generate a list 
of (many) random opcodes on your ssh client, and send them over to the 
test machine to be executed. If the system doesn't crash or hang, 
generate a new list and try again. If it does crash, then do a binary 
search on the list of opcodes to find the culprit.

2. If that sounds like too much work, we could print the instructions in 
the kernel when we know we're going to return true. (Sorry the 
formatting of this will likely be messed up):

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 27778b65a965..77e31d7c4097 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -277,11 +277,13 @@ bool is_no_fault_exception(struct pt_regs *regs)
                         asi = (insn >> 5);          /* immediate asi    */
                 if ((asi & 0xf2) = ASI_PNF) {
                         if (insn & 0x1000000) {     /* op3[5:4]=3       */
+                               printk(KERN_ALERT "fixing up no fault 
insn %x\n", insn);
                                 handle_ldf_stq(insn, regs);
                                 return true;
                         } else if (insn & 0x200000) { /* op3[2], stores */
                                 return false;
                         }
+                       printk(KERN_ALERT "fixing up no fault insn 
%x\n", insn);
                         handle_ld_nf(insn, regs);
                         return true;
                 }

3. I have a theory that the instruction may be something like this:

         sta %f0, [ %g0 ] #ASI_PNF

which should assemble to 0xc1a01040. You could just try this instruction.

4. If this does result in a crash, this patch might be the fix:

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 77e31d7c4097..c0d2e3665e69 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -276,12 +276,12 @@ bool is_no_fault_exception(struct pt_regs *regs)
                 else
                         asi = (insn >> 5);          /* immediate asi    */
                 if ((asi & 0xf2) = ASI_PNF) {
+                       if (insn & 0x200000)  /* op3[2], stores */
+                               return false;
                         if (insn & 0x1000000) {     /* op3[5:4]=3       */
                                 printk(KERN_ALERT "fixing up no fault 
insn %x\n", insn);
                                 handle_ldf_stq(insn, regs);
                                 return true;
-                       } else if (insn & 0x200000) { /* op3[2], stores */
-                               return false;
                         }
                         printk(KERN_ALERT "fixing up no fault insn 
%x\n", insn);
                         handle_ld_nf(insn, regs);

5. Try the patch in #4 regardless of the outcome of step #3

5. Here is another patch to try after the others:

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index c0d2e3665e69..e383738fdd9f 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -275,7 +275,7 @@ bool is_no_fault_exception(struct pt_regs *regs)
                         asi = (regs->tstate >> 24); /* saved %asi       */
                 else
                         asi = (insn >> 5);          /* immediate asi    */
-               if ((asi & 0xf2) = ASI_PNF) {
+               if (asi = ASI_PNF) {
                         if (insn & 0x200000)  /* op3[2], stores */
                                 return false;
                         if (insn & 0x1000000) {     /* op3[5:4]=3       */


Let me know what you find out from all this and I'll try to come up with 
more ideas.


Rob
