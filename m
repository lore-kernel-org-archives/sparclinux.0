From: "David S. Miller" <davem@redhat.com>
Date: Wed, 12 May 2004 19:15:18 +0000
Subject: Re: Another gcc 3.4 fix
Message-Id: <20040512121518.4877b510.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040512052744.GA31207@localhost>
In-Reply-To: <20040512052744.GA31207@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 12 May 2004 14:51:14 -0400
Mathieu Chouquet-Stringer <mchouque@online.fr> wrote:

> It is (at this stage the patch doesn't make any difference, the output
> being the same with or without it):
> 
>         .global kernel_unaligned_trap
>         .type   kernel_unaligned_trap, #function
>         .proc   020
> kernel_unaligned_trap:
>         .register       %g7, #scratch
>         !#PROLOGUE# 0
>         save    %sp, -208, %sp
>         !#PROLOGUE# 1

It can't be the same in both cases, because something is
making kernel_unaligned_trap_fault underfined right?  One
way is for it not to get emitted at all, and that's what
I thought was occurring with gcc-3.4 builds.

Meanwhile, I've put your workaround in for the time being.

