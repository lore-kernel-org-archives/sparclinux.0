From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 20 Feb 2005 20:08:58 +0000
Subject: Re: Who restores %g6 for trap/irq handlers?
Message-Id: <20050220120858.501c9ebd.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
In-Reply-To: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 20 Feb 2005 19:48:55 +0100
"Blue Swirl" <blueswir1@hotmail.com> wrote:

> Qemu's Sparc32 system emulator is getting to the point where the first user 
> space application almost executes. But there is some strangeness with 
> kernel's use of %g6, it's used for example in do_sparc_fault, but nothing is 
> restoring it before that, so there is a kernel zero page access as a result. 

%g6 is loaded at "arch/sparc/kernel/etrap.S:trap_setup_from_user" by the
"LOAD_CURRENT()" macro.

At context switch time, it is updated by the switch_to() macro.

At bootup, the first cpu sets up it's %g6 in arch/sparc/kernel/head.S
by this instruction:

                set     init_thread_union, %g6

and on SMP, subsequent processors setup their %g6 via this instruction
sequence in arch/sparc/kernel/trampoline.S:

        /* Give ourselves a stack and curptr. */
        set     current_set, %g5
        srl     %g3, 10, %g4
        and     %g4, 0xc, %g4
        ld      [%g5 + %g4], %g6

It's all very nearly the same as 2.4.x
