From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 17:26:13 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <20120515.132613.1143923069007142641.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 17:28:55 +0200

> On Tue, May 15, 2012 at 01:09:44AM -0400, David Miller wrote:
>>  arch/sparc/include/asm/cypress.h |   79 ---------
>>  arch/sparc/include/asm/elf_32.h  |   12 +-
>>  arch/sparc/include/asm/mbus.h    |    4 -
>>  arch/sparc/kernel/head_32.S      |   15 --
>>  arch/sparc/kernel/irq_32.c       |   11 --
>>  arch/sparc/mm/srmmu.c            |  333 +-------------------------------------
>>  6 files changed, 5 insertions(+), 449 deletions(-)
> 
> I had hoped to see more code gone with Cypress.
> - kernel/muldiv.c
> - lib/mul.S/umul.S etc.
> - PATCH_IT() stuff in head_32.S
> - "-mcpu=v8" in top-level Makefile
> 
> Partly on the todo list I assume.

It is the next step I planned to make.

> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Pushed, thanks Sam.
