From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Mon, 21 Feb 2005 18:56:51 +0000
Subject: Re: Who restores %g6 for trap/irq handlers?
Message-Id: <BAY12-F23A223ADCC544B9308A395FF610@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
In-Reply-To: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

>%g6 is loaded at "arch/sparc/kernel/etrap.S:trap_setup_from_user" by the
>"LOAD_CURRENT()" macro.

Yes, I used that when patching.

>At context switch time, it is updated by the switch_to() macro.

There has been no context switch yet.

>At bootup, the first cpu sets up it's %g6 in arch/sparc/kernel/head.S
>by this instruction:
>
>                 set     init_thread_union, %g6

This is fine, the kernel survives using %g6 until first text fault from 
executing /sbin/init.

>and on SMP, subsequent processors setup their %g6 via this instruction
>sequence in arch/sparc/kernel/trampoline.S:
>
>         /* Give ourselves a stack and curptr. */
>         set     current_set, %g5
>         srl     %g3, 10, %g4
>         and     %g4, 0xc, %g4
>         ld      [%g5 + %g4], %g6

No SMP yet either.

>It's all very nearly the same as 2.4.x

That makes it even stranger. But let me follow the first text fault 
execution:
head.S:
t_tflt:	SPARC_TFAULT                        /* Inst. Access Exception        
*/

entry.S:
srmmu_fault:
	mov	0x400, %l5
	mov	0x300, %l4

	lda	[%l5] ASI_M_MMUREGS, %l6	! read sfar first
	lda	[%l4] ASI_M_MMUREGS, %l5	! read sfsr last

	andn	%l6, 0xfff, %l6
	srl	%l5, 6, %l5			! and encode all info into l7

	and	%l5, 2, %l5
	or	%l5, %l6, %l6

	or	%l6, %l7, %l7			! l7 = [addr,write,txtfault]

	SAVE_ALL

	mov	%l7, %o1
	mov	%l7, %o2
	and	%o1, 1, %o1		! arg2 = text_faultp
	mov	%l7, %o3
	and	%o2, 2, %o2		! arg3 = writep
	andn	%o3, 0xfff, %o3		! arg4 = faulting address

	wr	%l0, PSR_ET, %psr
	WRITE_PAUSE

	call	do_sparc_fault

(SAVE_ALL and WRITE_PAUSE don't touch %g6)

fault.c:
asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int 
write,
			       unsigned long address)
{
	struct vm_area_struct *vma;
	struct task_struct *tsk = current;
	struct mm_struct *mm = tsk->mm;
	unsigned int fixup;
	unsigned long g2;
	siginfo_t info;
	int from_user = !(regs->psr & PSR_PS);

	if(text_fault)
		address = regs->pc;
In asm, this means:
IN: do_sparc_fault
0xf001c6a0:  save  %sp, -304, %sp
0xf001c6a4:  ld  [ %i0 ], %o0
0xf001c6a8:  cmp  %i1, 0
0xf001c6ac:  ld  [ %g6 + 4 ], %l5
0xf001c6b0:  srl  %o0, 6, %l4
0xf001c6b4:  xor  %l4, 1, %l4
0xf001c6b8:  ld  [ %l5 + 0x6c ], %l1
0xf001c6bc:  be  0xf001c6c8
0xf001c6c0:  and  %l4, 1, %l4

So, at 0xf001c6ac there is a use of %g6, but nowhere in t_tflt, srmmu_fault 
and do_sparc_fault is %g6 set something other from its previous value, zero. 
A horrible bug not uncovered even in 2.4? Or did I miss something?

In Qemu, the data fault from unmapped zero page access with interrupts 
disabled results in Qemu exit. Maybe this is not what happens in real 
hardware, enabling the kernel survive?

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

