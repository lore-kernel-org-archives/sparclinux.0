From: Ed L Cashin <ecashin@uga.edu>
Date: Fri, 16 Jan 2004 20:29:56 +0000
Subject: Re: finding origin of dTLB miss
Message-Id: <87wu7rfxh7.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <87isjcg7g3.fsf@uga.edu>
In-Reply-To: <87isjcg7g3.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks very much for the helpful response.

"David S. Miller" <davem@redhat.com> writes:

...
> The userland memory maps have nothing to do with where this fault
> is occuring.  If TSTATE_PRIV is true, then absolutely the fault is occuring
> in the kernel somewhere.
>
> Also, the kernel and the user live in two seperate address spaces on sparc64.

AH!  I may have known that at some point, but I had definitely
regressed into i386 assumptions.

> Therefore, virtual address "X" means something totally different when in kernel
> mode than the same virtual address "X" means in user mode.  Comparing raw
> virtual addresses does not tell you if something is in the kernel or not, you must
> combine the state of TSTATE_PRIV and the virtual address to determine where
> something really is.
>
>> Ksymoops doesn't say anything helpful when I input the line, "TSTATE:
>> 0000000011009606 TPC: c2060000".  
>
> That number after "TPC" is not the program counter, it is the instruction
> itself.
>
> Get the real TPC value from regs->tpc at the time of the fault, the look
> up that instruction in the 'vmlinux' kernel image either using 'objdump'
> or 'gdb'.

Oh, thanks.  I didn't notice that get_fault_insn dereferences
regs->tpc.  

I was able to find the kernel code that is inducing the dTLB miss
using gdb.  :)

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

