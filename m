From: Mathieu Chouquet-Stringer <mchouque@online.fr>
Date: Wed, 12 May 2004 18:51:14 +0000
Subject: Re: Another gcc 3.4 fix
Message-Id: <20040512185114.GA14319@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20040512052744.GA31207@localhost>
In-Reply-To: <20040512052744.GA31207@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, May 12, 2004 at 11:32:28AM -0700, David S. Miller wrote:
> Well, what seems to be happening is that GCC believes that
> kernel_unaligned_trap() is not invoked so it does not emit
> the code for that function.

You meant kernel_unaligned_trap_fault, right? If not, why would
kernel_unaligned_trap function be defined in the .o file then? Only
kernel_unaligned_trap_fault is undefined (and unaligned_panic is simply
missing): 

0000000000000360 T kernel_unaligned_trap
                 U kernel_unaligned_trap_fault

> As a consequence, unaligned_panic() can also not be emitted since
> it is only invoked from kernel_unaligned_trap().
>
> Is gcc-3.4 emitting kernel_unaligned_trap() into the unaligned.s file?

It is (at this stage the patch doesn't make any difference, the output
being the same with or without it):

        .global kernel_unaligned_trap
        .type   kernel_unaligned_trap, #function
        .proc   020
kernel_unaligned_trap:
        .register       %g7, #scratch
        !#PROLOGUE# 0
        save    %sp, -208, %sp
        !#PROLOGUE# 1

-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
