From: David Miller <davem@davemloft.net>
Date: Wed, 04 Jan 2012 21:29:19 +0000
Subject: Re: [WIP] sparc32: replace bootmem with memblock
Message-Id: <20120104.162919.2041376457282956157.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120103204516.GA4271@merkur.ravnborg.org>
In-Reply-To: <20120103204516.GA4271@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 3 Jan 2012 21:45:16 +0100

> - kern_addr_valid is (temporary) disabled
>   I could not grock the code allocating sparc_valid_addr_bitmap
>   and I noticed most archs do not implement this check

Is it hard to grok where the memory is allocated from or the
calculation of the bitmap memory's size? :-)

To be honest, leaving this defined to "0" is no real crime.
It just means that /proc/kcore isn't going to be supported as
that is the only place this test is really used.

On sparc64 we allocate the bitmap statically in the kernel image
because we use it in the TLB miss handler to validate addresses
when handling misses in the PAGE_OFFSET linear translation area.

On sparc64 the memory error (or hypervisor error, since when we load
TLB entries via the hypervisor it checks the address too) is harder to
recover from than just noticing the problem earlier in the TLB miss
handler.  So that's why we do it this way.

And since we have the table we use it to implement kern_addr_valid()
too since that's essentially free.

If the platform would properly fault on any bogus kernel address
access, kern_addr_valid() can seemingly just be defined to the
constant "1".
