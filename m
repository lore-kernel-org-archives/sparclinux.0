From: David Miller <davem@davemloft.net>
Date: Tue, 31 Jul 2007 06:42:52 +0000
Subject: Re: [SPARC32] NULL pointer derefference
Message-Id: <20070730.234252.74747206.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707300301340.32210@mtfhpc.demon.co.uk>
	<20070729.211929.78713482.davem@davemloft.net>
	<Pine.LNX.4.61.0707310557470.3926@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707310557470.3926@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: aaw@google.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 31 Jul 2007 06:35:29 +0100 (BST)

> The original code did a job lot of pte stuf in install_arg_page. The
> new code seems to replace this using get_user_pages but I have not
> worked out how get_user_pages gets to the point at which it
> allocated pte's i.e.  maps the stack memory it is about to put the
> arguments into.

get_user_pages() essentially walks through the requested user address
space, faults in pages if necessary, and returns references to those
pages.

The logic of get_user_pages() you need to be concerned about is
this inner loop:

			while (!(page = follow_page(vma, start, foll_flags))) {
				int ret;
				ret = handle_mm_fault(mm, vma, start,
						foll_flags & FOLL_WRITE);
 ...
			}

handle_mm_fault() does all the dirty work of a page fault, and
is how we get to update_mmu_cache(), the sun4c implementation of
which is where you see the crash.
