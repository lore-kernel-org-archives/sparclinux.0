From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 20 Mar 2018 23:02:12 +0000
Subject: Re: sparc_pipe(2)
Message-Id: <20180320230212.GB30522@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180319.211125.314781796727440151.davem@davemloft.net>
In-Reply-To: <20180319.211125.314781796727440151.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 20, 2018 at 02:22:48PM -0400, David Miller wrote:

> > Anyway, I've put together some cleanups ({COMPAT_,}SYSCALL_DEFINE
> > conversions, getting rid of SIGN... wrappers) in
> > git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git misc.sparc
> > Do you see any obviour problems with the stuff in there?  It's not
> > urgent - the real fun with compat wrappers will be on mips and s390,
> > anyway; sparc is fairly benign in that respect...
> 
> Nothing in there seems objectionable to me.

More oddities: in commit b340b81a6554facb1b2fbe68691e254d53315d20
Author: David S. Miller <davem@nuts.ninka.net>
Date:   Sun Nov 3 09:24:46 2002 -0800

    [SPARC]: Add sys_remap_file_pages syscalls.

we have
int sparc_remap_file_pages(unsigned long start, unsigned long size,
                          unsigned long prot, unsigned long pgoff,
                          unsigned long flags)
{
       /* This works on an existing mmap so we don't need to validate
        * the range as that was done at the original mmap call.
        */
       return sys_remap_file_pages(start, size, prot,
                                   (pgoff >> (PAGE_SHIFT - 12)), flags);
}

put into native 32bit syscall table and plain sys_remap_file_pages() into
64bit ones - both native and compat.  AFAICS, that would have
remap_file_pages() in 32bit binary operate in units of 4Kb on 32bit
host and PAGE_SIZE - on 64bit one.

Confused...

Other interesting differences:
	* no getpeername() or getsockname() in compat table; AFAICS,
for both the native syscall should work...
	* #254 is ni_syscall() on native an nis_syscall() on compat,
#267 is the other way round.  Huh?  What are the rules for ni vs. nis,
anyway?  I understand that the former is quiet and the latter reports
attempts to issue the syscall in question, but how do we choose which
one to use for given unimplemented syscall?
