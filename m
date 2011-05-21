From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 21 May 2011 21:33:34 +0000
Subject: Re: [PATCH 0/2] sparc32 build fixes
Message-Id: <20110521213334.GA18566@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110521212549.GA17236@merkur.ravnborg.org>
In-Reply-To: <20110521212549.GA17236@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 21, 2011 at 11:25:50PM +0200, Sam Ravnborg wrote:
> While trying to do some other hacking on sparc32 tonight
> I hit several build issues.
> 
> Some of these are already addressed by Stephen Rotwell.
> The sparc specific patches follows.
> 
> I have not posted the generic ones - I assume Stephen
> will take care...
> 
> 	Sam
> 
>  arch/sparc/include/asm/smp_32.h      |    8 --------
>  arch/sparc/include/asm/spinlock_32.h |    1 +
>  arch/sparc/kernel/smp_32.c           |    8 ++++++++
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> Sam Ravnborg (2):
>       sparc: fix build, fix missing cpu_relax declaration
>       sparc32: fix build, move inline function to .c file

Btw. patches are on top of:

commit c21fd1a8c68ce3f49b00caf10337169262cfb8ad
Merge: 1a4022f... 5d41452...
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat May 21 00:13:03 2011 -0700

as I was working on latest upstream.

	Sam
