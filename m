From: Eldar Abusalimov <eldar.abusalimov@gmail.com>
Date: Mon, 03 Aug 2009 17:36:31 +0000
Subject: Is it a bug in etrap.S srmmu stack check routine?
Message-Id: <d543c060908031036k66ebd6a5h5285dabf3f5aefe3@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, David!

I've been looking into traps-related routines for some time, and was
confused with srmmu user stack checking code.

Here is the corresponding part of etrap.S file:

278 	        .globl  tsetup_srmmu_stackchk
279 	tsetup_srmmu_stackchk:
280 	        /* Check results of callers andcc %sp, 0x7, %g0 */
281 	        bne     trap_setup_user_stack_is_bolixed
282 	         sethi   %hi(PAGE_OFFSET), %glob_tmp
283 	
284 	        cmp     %glob_tmp, %sp
285 	        bleu,a  1f
286 	         lda    [%g0] ASI_M_MMUREGS, %glob_tmp          ! read MMU control
287 	
288 	trap_setup_user_stack_is_bolixed:
289 	        /* From user/kernel into invalid window w/bad user
290 	         * stack. Save bad user stack, and return to caller.
291 	         */
292 	        SAVE_BOLIXED_USER_STACK(curptr, g3)
293 	        restore %g0, %g0, %g0
294 	
295 	        jmpl    %t_retpc + 0x8, %g0
296 	         mov    %t_kstack, %sp
297 	
298 	1:
299 	        /* Clear the fault status and turn on the no_fault bit. */
300 	        or      %glob_tmp, 0x2, %glob_tmp               ! or in
no_fault bit
301 	        sta     %glob_tmp, [%g0] ASI_M_MMUREGS          ! set it
302 	
303 	        /* Dump the registers and cross fingers. */
304 	        STORE_WINDOW(sp)

On the line 284 we compare user stack pointer with PAGE_OFFSET, and if
it is greater than PAGE_OFFSET, then we consider user stack is still
ok and continue checking. On the contrary, if %sp is small enough,
bollixed stack handler is entered at once. Is it right?

The same part of wof.S looks more logical - if %sp is greater than
kernel base, then branch into a spwin_user_stack_is_bolixed.

398 	         sethi   %hi(PAGE_OFFSET), %glob_tmp
399 	        cmp     %glob_tmp, %sp
400 	        bleu    spwin_user_stack_is_bolixed

I am perplexed especially because of the fact that this part of logic
has not been changed since 1999, and nevertheless Linux works well.
(but trap_setup_user_stack_is_bolixed is reached in fact, I've just
tested on the hardware with grmon).
Linux version is 2.6.21.1.

Please let me know if this is really a bug or where am I wrong else.
Thanks in advance.

-- 
Best regards,
Eldar Sh. Abusalimov
