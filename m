From: David Miller <davem@davemloft.net>
Date: Sat, 01 Jun 2019 23:46:43 +0000
Subject: Re: RFC: switch the remaining architectures to use generic GUP v2
Message-Id: <20190601.164643.756724745563418604.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de>
In-Reply-To: <20190601074959.14036-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: torvalds@linux-foundation.org, paul.burton@mips.com, jhogan@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, npiggin@gmail.com, khalid.aziz@oracle.com, andreyknvl@google.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  1 Jun 2019 09:49:43 +0200

> below is a series to switch mips, sh and sparc64 to use the generic
> GUP code so that we only have one codebase to touch for further
> improvements to this code.  I don't have hardware for any of these
> architectures, and generally no clue about their page table
> management, so handle with care.
> 
> Changes since v1:
>  - fix various issues found by the build bot
>  - cherry pick and use the untagged_addr helper form Andrey
>  - add various refactoring patches to share more code over architectures
>  - move the powerpc hugepd code to mm/gup.c and sync it with the generic
>    hup semantics

I will today look seriously at the sparc64 stuff wrt. tagged pointers.
