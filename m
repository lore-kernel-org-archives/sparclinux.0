From: David Miller <davem@davemloft.net>
Date: Fri, 24 Sep 2010 04:48:56 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100923.214856.43029525.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100922204323.GG19804@ZenIV.linux.org.uk>
	<20100922.141514.232744402.davem@davemloft.net>
	<20100922231219.GH19804@ZenIV.linux.org.uk>
In-Reply-To: <20100922231219.GH19804@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 23 Sep 2010 00:12:19 +0100

> OK... sparc32 question: just what the !@#!@# happens if sun4c_rett_stackchk
> find (%fp & 7) != 0?  We go to ret_trap_user_stack_is_bolixed, which
> tries to page in the underlying page.  OK, suppose it's already there and
> readable; we return without doing anything - and go to signal_p.  Which finds
> itself with nothing to do, and %fp is *still* buggered.  Spin ad infinitum?
> srmmu_rett_stackchk will do the same, BTW...

That's a bug.

Likely all of the window_*_fault() routines should force a SIGILL when
the stack is mis-aligned.
