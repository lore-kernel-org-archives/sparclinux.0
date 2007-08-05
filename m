From: David Miller <davem@davemloft.net>
Date: Sun, 05 Aug 2007 03:16:10 +0000
Subject: Re: procps needs PAGE_SIZE
Message-Id: <20070804.201610.104033771.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0708050326390.25352@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0708050326390.25352@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 5 Aug 2007 03:41:15 +0100 (BST)

> Is there a syscall, /proc file or some other system that that provides 
> access to PAGE_SIZE for user space programs (like procps ps)?

sys_getpagesize()
