From: David Miller <davem@davemloft.net>
Date: Thu, 22 Mar 2018 17:07:28 +0000
Subject: Re: sparc_pipe(2)
Message-Id: <20180322.130728.2287357812646510692.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180319.211125.314781796727440151.davem@davemloft.net>
In-Reply-To: <20180319.211125.314781796727440151.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 20 Mar 2018 23:02:12 +0000

>     [SPARC]: Add sys_remap_file_pages syscalls.
> 
> we have
> int sparc_remap_file_pages(unsigned long start, unsigned long size,
>                           unsigned long prot, unsigned long pgoff,
>                           unsigned long flags)
> {
>        /* This works on an existing mmap so we don't need to validate
>         * the range as that was done at the original mmap call.
>         */
>        return sys_remap_file_pages(start, size, prot,
>                                    (pgoff >> (PAGE_SHIFT - 12)), flags);
> }
> 
> put into native 32bit syscall table and plain sys_remap_file_pages() into
> 64bit ones - both native and compat.  AFAICS, that would have
> remap_file_pages() in 32bit binary operate in units of 4Kb on 32bit
> host and PAGE_SIZE - on 64bit one.

That's bogus, 32-bit binary should use system page size, rather than
a fixed 4K value.

> Other interesting differences:
> 	* no getpeername() or getsockname() in compat table; AFAICS,
> for both the native syscall should work...

The 32-bit userspace never used these and instead went through
socketcall(), so I simply never added them to the syscall table.

> 	* #254 is ni_syscall() on native an nis_syscall() on compat,
> #267 is the other way round.  Huh?  What are the rules for ni vs. nis,
> anyway?  I understand that the former is quiet and the latter reports
> attempts to issue the syscall in question, but how do we choose which
> one to use for given unimplemented syscall?

I think they should all be quiet, and the warning is of limited to no
value these days.
