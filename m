From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 18:53:27 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <20120515.145327.478612534461593725.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 17:28:55 +0200

> I had hoped to see more code gone with Cypress.
> - kernel/muldiv.c
> - lib/mul.S/umul.S etc.
> - PATCH_IT() stuff in head_32.S
> - "-mcpu=v8" in top-level Makefile

These should all be taken care of now.

I suspect that divdi3.S and udivdi3.S can be removed as well.  I think
the muldiv.c code as the only reference that could be generated to
those.

I know that muldi3 and the "di3" shift routines need to stay.  Other
32-bit platforms have to provide those too, since gcc does emit
references to them for some of the expressions we have in the tree.
