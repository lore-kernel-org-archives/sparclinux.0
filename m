From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 15:28:55 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <20120515152855.GA5499@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 15, 2012 at 01:09:44AM -0400, David Miller wrote:
> 
> It's the one aberration in v8, the only cpu that
> didn't actually have hardware multiply and divide
> instructions.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> 
> I'm tempted to push this.
> 
> Sam, what's your take on it?

I do not know of anyone using a working sun4m box with Cypress,
but then I do not know that many with SUN hw anyway.

We have started to get rid of the ancient sparc32 stuff
and I am in favour of also killing support for Cypress.
The message is then simple:
- we have dropped support for sun4c and the old Cypress based
SPARC chips.

My take is that we shall try to adapt the kernel to the
latest chip revisions / platfroms.
And then keep support for the relevant older platfroms,
while not sacrifying the hackability of the kernel.

In other words the prime chip / platform is LEON, and
the older platform we shall support is sun4d and sun4m.

Regarding hackability what we did the last week helped a lot!

>  arch/sparc/include/asm/cypress.h |   79 ---------
>  arch/sparc/include/asm/elf_32.h  |   12 +-
>  arch/sparc/include/asm/mbus.h    |    4 -
>  arch/sparc/kernel/head_32.S      |   15 --
>  arch/sparc/kernel/irq_32.c       |   11 --
>  arch/sparc/mm/srmmu.c            |  333 +-------------------------------------
>  6 files changed, 5 insertions(+), 449 deletions(-)

I had hoped to see more code gone with Cypress.
- kernel/muldiv.c
- lib/mul.S/umul.S etc.
- PATCH_IT() stuff in head_32.S
- "-mcpu=v8" in top-level Makefile

Partly on the todo list I assume.
Other parts may not be Cypress specific?

Anyway - you can add my:

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
