From: David Miller <davem@davemloft.net>
Date: Fri, 06 Jan 2017 20:04:18 +0000
Subject: Re: [PATCH 1/2] sparc64: Don't panic on user mode non-resumable errors
Message-Id: <20170106.150418.36903978448243159.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1483731540-8055-2-git-send-email-Liam.Howlett@Oracle.com>
In-Reply-To: <1483731540-8055-2-git-send-email-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Fri,  6 Jan 2017 14:38:59 -0500

> Send a SIGBUS to the offending process on all userspace non-resumable
> traps.  This prevents userspace applications from creating a kernel
> panic.  The siginfo will return the code BUS_ADRERR and a valid address
> if possible.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Now that the code will potentially actually continue, you _must_ check
the nature of the error, and potentially retire the physical page if
it is real memory in order to prevent it from being used in some other
way by either userspace of kernel space and thus triggering the
non-resumable error all over again.

The various sun4u async fault handlers have this logic present and do the
right thing, something like:

	if (pfn_valid(afar >> PAGE_SHIFT))
		get_page(pfn_to_page(afar >> PAGE_SHIFT));

This logic prevents the page from being freed up and returned to the
free page pool, even if we kill the process and thus tear down it's
address space.

Thank you.
