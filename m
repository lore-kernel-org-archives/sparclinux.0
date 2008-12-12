From: Bob <bo-liu@hotmail.com>
Date: Fri, 12 Dec 2008 09:02:36 +0000
Subject: RE: help about trap_setup..
Message-Id: <COL115-W61EA9546A458182615C7279FF90@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY117-W358094378343A8012C52A49FF80@phx.gbl>
In-Reply-To: <BAY117-W358094378343A8012C52A49FF80@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Still no answer...



> From: bo-liu@hotmail.com
> To: sparclinux@vger.kernel.org
> Subject: help about trap_setup..
> Date: Thu, 11 Dec 2008 11:17:54 +0800
> 
> 
> In trap path "trap_setup", if in trap window we will jmp to "trap_setup_kernel_spill". 
> 
> /* See if we are in the trap window. */
> 93 andcc %t_twinmask, %t_wim, %g0
> 94 bne trap_setup_kernel_spill ! in trap window, clean up
> 95 nop
> 96
> 97 /* Trap from kernel with a window available.
> 98 * Just do it...
> 99 */
> 100 jmpl %t_retpc + 0x8, %g0 ! return to caller
> 101 mov %t_kstack, %sp ! jump onto new stack
> 102
> 103trap_setup_kernel_spill:
> 104 ld [%curptr + TI_UWINMASK], %g1
> 105 orcc %g0, %g1, %g0
> 106 bne trap_setup_user_spill ! there are some user windows, yuck
> 
> But where is the %curptr in line 104 is setted? 
> 
> the comment said #define curptr g6 /* Set after pt_regs frame is built */ 
> 
> but i can't find the code set %g6 in these scene. 
> 
> what'more, what are "user windows" like the line 106 said meaning. There need a lot of particular dealing, 
> 
> I am still reading it. 
> 
> Thanks! 
> 
_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE
