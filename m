From: David Miller <davem@davemloft.net>
Date: Wed, 01 Jun 2011 08:38:05 +0000
Subject: Re: mmap operation not working as expected on sparc linux
Message-Id: <20110601.013805.430771453759400027.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DE5F5B9.4020601@redhat.com>
In-Reply-To: <4DE5F5B9.4020601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Steven Dake <sdake@redhat.com>
Date: Wed, 01 Jun 2011 01:18:01 -0700

> I maintain a project called corosync which uses a memory backed file to
> generate a duplicate mapping in memory to implement a ring buffer.  It
> essentially uses the concepts here:
> 
> http://en.wikipedia.org/wiki/Ring_buffer#Exemplary_POSIX_Implementation
> 
> This doesn't appear to work on sparclinux, returning an error EINVAL  on
> the second memory map operation:
> 
> address = mmap (buffer->address + buffer->count_bytes,
>                   buffer->count_bytes, PROT_READ | PROT_WRITE,
>                   MAP_FIXED | MAP_SHARED, file_descriptor, 0);
> 
> Any ideas?

The start addresses of fixed and shared mappings need to have a
certain property relative to other such mappings.

And that property is that the addresses must all be modulo the
D-cache alias factor, which on sparc64 is 16384 bytes.

If we didn't enfore this, then writes from one mapping could get
aliased in the L1 D-cache, and not show up in other mappings.

However if we force all the start address to the same 16K boundary,
then this guarentees that writes to one mapping will show up in
others.

You'll hit similar issues on MIPS, ARM, PARISC, and SH.  Just look for
which platforms define __ARCH_FORCE_SHMLBA in their shmparam.h header
file.
