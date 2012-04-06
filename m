From: David Miller <davem@davemloft.net>
Date: Fri, 06 Apr 2012 16:38:07 +0000
Subject: Re: sparc32 paging fault which I cannot explain
Message-Id: <20120406.123807.782715567642758628.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120406152619.GA17138@merkur.ravnborg.org>
In-Reply-To: <20120406152619.GA17138@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 6 Apr 2012 17:26:19 +0200

> What I think happens is that the MMU is not setup to handle virtual addresses
> in this area - as this is a much higher address than what we would have seen
> with the old bootmem allocator. memblock allocates top-down, where bootmem
> allocates bottom-up.

The first 16MB at KERNBASE is mapped by the head.S code, the rest is
mapped by arch/sparc/srmmu.c:map_kernel() and similar.
