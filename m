From: "David S. Miller" <davem@redhat.com>
Date: Thu, 15 Jan 2004 22:42:43 +0000
Subject: Re: finding origin of dTLB miss
Message-Id: <20040115144243.07fd6936.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87isjcg7g3.fsf@uga.edu>
In-Reply-To: <87isjcg7g3.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 15 Jan 2004 17:42:20 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> Hi.  I'm trying to learn more about a dTLB fault that's occurring on
> my system.  Inside do_sparc64_fault, these things are true:
> 
>   address:              0xefffe000   (bottom of the user stack region)
>   fault code:           0x2          (dTLB miss)
>   insn:                 0xc2060000
>   tstate:               0x11009606
>   tstate & TSTATE_PRIV: 1

The 'insn' is "ld [%i0], %g1"  Presumably the compute stack address
causing the fault is in register %i0.

> Since tstate & TSTATE_PRIV is true, it seems like insn should be in
> the kernel, but it doesn't look like a kernel address, since the
> userland memory maps look like this:

The userland memory maps have nothing to do with where this fault
is occuring.  If TSTATE_PRIV is true, then absolutely the fault is occuring
in the kernel somewhere.

Also, the kernel and the user live in two seperate address spaces on sparc64.
Therefore, virtual address "X" means something totally different when in kernel
mode than the same virtual address "X" means in user mode.  Comparing raw
virtual addresses does not tell you if something is in the kernel or not, you must
combine the state of TSTATE_PRIV and the virtual address to determine where
something really is.

> Ksymoops doesn't say anything helpful when I input the line, "TSTATE:
> 0000000011009606 TPC: c2060000".  

That number after "TPC" is not the program counter, it is the instruction
itself.

Get the real TPC value from regs->tpc at the time of the fault, the look
up that instruction in the 'vmlinux' kernel image either using 'objdump'
or 'gdb'.
