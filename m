From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 30 Apr 2007 21:54:14 +0000
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
Message-Id: <20070430145414.88fda272.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704291345480.690@mtfhpc.demon.co.uk>
	<1177852457.4390.26.camel@localhost.localdomain>
	<Pine.LNX.4.61.0704302159140.3178@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704302159140.3178@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, wli@holomorphy.com, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-mm@kvack.org

On Mon, 30 Apr 2007 22:36:27 +0100 (BST)
Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:

> Hi all,
> 
> I have tracked down a failure to successfully load/run the init task on my 
> Sparcstation 1 clone (SS1) and Sparcstation 2 (SS2), sparc32 sun4c 
> systems, to a patch:
> 
>    commit 1a44e149084d772a1bcf4cdbdde8a013a8a1cfde.
>    [PATCH] .text page fault SMP scalability optimization
> 
> Removing this patch fixes the issue and allows me to use kernels later 
> than v2.5.14. (tested using linux-2.6.20.9).
> 
> Given the comment provided by the git bisect, backing out this patch will 
> probably have undesirable conseqnences for other platforms (especially 
> powerpc64) so, if an architecture independent solution is not available, 
> some/all of the code in handle_pte_fault() in mm/memory.c will need be to 
> made architecture dependent.
> 
> I am not sufficiently familear with the how the SS1/SS2 mmu works and how 
> the linux memory management system works to understand why this patch 
> prevents my sun4c SS1/SS2 systems from working.
> 
> Advice and help on the approch to take and any code changes regarding this 
> issue would be most welcome.
> 

Interesting - thanks for working that out.  Let's keep linux-mm on cc please.

