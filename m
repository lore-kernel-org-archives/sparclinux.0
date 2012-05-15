From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 19:08:39 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <20120515190839.GA317@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 15, 2012 at 02:53:27PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 15 May 2012 17:28:55 +0200
> 
> > I had hoped to see more code gone with Cypress.
> > - kernel/muldiv.c
> > - lib/mul.S/umul.S etc.
> > - PATCH_IT() stuff in head_32.S
> > - "-mcpu=v8" in top-level Makefile
> 
> These should all be taken care of now.

Thanks - I preferred someone knowledgeable to do this.
> 
> I suspect that divdi3.S and udivdi3.S can be removed as well.  I think
> the muldiv.c code as the only reference that could be generated to
> those.
I can experiment with this.

	Sam
