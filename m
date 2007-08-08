From: David Miller <davem@davemloft.net>
Date: Wed, 08 Aug 2007 05:40:08 +0000
Subject: Re: procps needs PAGE_SIZE
Message-Id: <20070807.224008.26967607.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0708050326390.25352@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0708050326390.25352@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kumba <kumba@gentoo.org>
Date: Wed, 08 Aug 2007 01:32:04 -0400

> David Miller wrote:
> > From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> > Date: Sun, 5 Aug 2007 03:41:15 +0100 (BST)
> > 
> >> Is there a syscall, /proc file or some other system that that provides 
> >> access to PAGE_SIZE for user space programs (like procps ps)?
> > 
> > sys_getpagesize()
> 
> We've (gentoo/mips) had our run-ins with Albert on PAGE_SIZE and procps before. 

You're discussing something different from what Mark is asking about.

Mark is asking if /proc filesystem provides the PAGE_SIZE value
currently in use, not knowing about the sys_getpagesize() system
call and similar.

You're mentioning the use of PAGE_SIZE in userspace programs, such
as the procps utilities, which is totally unrelated.
