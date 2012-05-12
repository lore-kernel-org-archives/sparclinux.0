From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 02:21:21 +0000
Subject: Re: [PATCH 1/8] KEYS: Use the compat keyctl() syscall wrapper on Sparc64 for Sparc32 compat
Message-Id: <20120511.222121.943120845093240102.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120511104312.6307.79320.stgit@warthog.procyon.org.uk>
In-Reply-To: <20120511104312.6307.79320.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Fri, 11 May 2012 11:43:12 +0100

> Use the 32-bit compat keyctl() syscall wrapper on Sparc64 for Sparc32 binary
> compatibility.
> 
> Without this, keyctl(KEYCTL_INSTANTIATE_IOV) is liable to malfunction as it
> uses an iovec array read from userspace - though the kernel should survive this
> as it checks pointers and sizes anyway.
> 
> I think all the other keyctl() function should just work, provided (a) the top
> 32-bits of each 64-bit argument register are cleared prior to invoking the
> syscall routine, and the 32-bit address space is right at the 0-end of the
> 64-bit address space.  Most of the arguments are 32-bit anyway, and so for
> those clearing is not required.
> 
> Signed-off-by: David Howells <dhowells@redhat.com

I'm happy with someone else merging this in, thanks for doing this work:

Acked-by: David S. Miller <davem@davemloft.net>
