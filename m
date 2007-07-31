From: David Miller <davem@davemloft.net>
Date: Tue, 31 Jul 2007 09:02:19 +0000
Subject: Re: [PATCH] Re: [SPARC32] NULL pointer derefference
Message-Id: <20070731.020219.78708972.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707310557470.3926@mtfhpc.demon.co.uk>
	<20070730.234252.74747206.davem@davemloft.net>
	<Pine.LNX.4.61.0707310831080.4116@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707310831080.4116@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: aaw@google.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 31 Jul 2007 08:55:20 +0100 (BST)

> I have formulated a patch that prevents the update_mmu_cache from doing 
> enything if there is no context available. This apears to have no 
> immediate, undesirable side effects.
> 
> This worked better than the alternative of setting up a context to work with.
> 
> Can you for see any issues in doing this?
> 
> If not, can you check+apply the attached (un-mangled) patch.

Thanks for tracking this down Mark.

The issue is that, when exec()'ing to userspace from a kernel thread,
we need activate_context() to be invoked before we try to touch
userspace at all.  This new argument handling is invoking
get_user_pages() before that happens.

activate_context() happens via flush_old_exec(), but that occurs via
load_elf_binary() et al. which is long after the argument fetching
code runs in fs/exec.c that is using get_user_pages().

(Mark, hint: activate_context() is defined to switch_mm() on
 sparc32, which is sun4c_switch_mm() which you thought was only
 invoked from context switches :-))

Touching userspace before activate_context() is questionable at best,
in my opinion.  But I can't come up with a good way to fix this right
now other than Mark's sparc patch, so I will apply it.

Thanks again Mark!

