From: Kumba <kumba@gentoo.org>
Date: Wed, 08 Aug 2007 05:32:04 +0000
Subject: Re: procps needs PAGE_SIZE
Message-Id: <46B95554.1030609@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0708050326390.25352@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0708050326390.25352@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Sun, 5 Aug 2007 03:41:15 +0100 (BST)
> 
>> Is there a syscall, /proc file or some other system that that provides 
>> access to PAGE_SIZE for user space programs (like procps ps)?
> 
> sys_getpagesize()

We've (gentoo/mips) had our run-ins with Albert on PAGE_SIZE and procps before. 
  Our fix was a patch that simply defined PAGE_SIZE to be sysconf(_SC_PAGESIZE), 
and that's fixed the program for the last 2-3 years or so.  Try giving that a shot.

http://lkml.org/lkml/2007/7/14/244 is also an amusing read too.



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
