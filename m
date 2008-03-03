From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Mon, 03 Mar 2008 21:41:11 +0000
Subject: Re: sparc vs. gcc 4.3
Message-Id: <1204580471.22933.17.camel@brick>
List-Id: <sparclinux.vger.kernel.org>
References: <20080303192651.GL26072@cs181133002.pp.htv.fi>
	 <20080303.130348.25289482.davem@davemloft.net>
In-Reply-To: <20080303.130348.25289482.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: bunk@kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2008-03-03 at 13:03 -0800, David Miller wrote:
> From: Adrian Bunk <bunk@kernel.org>
> Date: Mon, 3 Mar 2008 21:26:51 +0200
> 
> >   LD      arch/sparc/boot/image
> > arch/sparc/kernel/built-in.o:(__ex_table+0x394): undefined reference to `kernel_unaligned_trap_fault'
> ...
> > arch/sparc/kernel/built-in.o:(__ex_table+0x46c): undefined reference to `user_unaligned_trap_fault'
> 
> > Does anyone have a clue what's going wrong here?
> 
> We hit the same problem a while back on sparc64 too.
> 
> GCC can't see how the inline asm is reachable so eliminates it
> entirely.  We hide the label inside the inline asm string and call it
> from exception handlers.
> 
> The way we fixed this on sparc64 was quite invasive (patch below for
> reference), so I'll try to come up with something simpler.

Could you hide the asm inside an actual function and annotate the
function with __used?

Similar to how the kprobes has a function called kretprobe_trampoline_holder
for their trampoline asm?

arch/x86/kernel/kprobes.c line 584

Cheers,

Harvey


