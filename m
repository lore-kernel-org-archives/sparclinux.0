From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 01:57:35 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140929.215735.818277840518880235.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Mon, 29 Sep 2014 18:35:22 -0400

> This is M7-4:
> MM: PAGE_OFFSET is 0xfffe000000000000 (max_phys_bits = 49)^M
> MM: VMALLOC [0x0000000100000000 --> 0x0001000000000000]^M
> MM: VMEMMAP [0x0001000000000000 --> 0x0002000000000000]^M
> Kernel: Using 3 locked TLB entries for main kernel image.^M
> Remapping the kernel... done.^M
> ..
> Early memory node ranges^M
>   node   0: [mem 0x50400000-0x3fbf6bdfff]^M
>   node   0: [mem 0x3fbf6c4000-0x3fbf6c5fff]^M
>   node   1: [mem 0x400000000000-0x403bffffffff]^M
>   node   2: [mem 0x800000000000-0x803fffffffff]^M
>   node   3: [mem 0xc00000000000-0xc03fffd5dfff]^M
>   node   3: [mem 0xc03fffd90000-0xc03fffdaffff]^M
>   node   3: [mem 0xc03fffdc0000-0xc03fffdc3fff]^M
> Booting Linux...^M
> CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]^M
> CPU CAPS: [popc,vis,vis2,ASIBlkInit,fmaf,vis3,hpc,ima]^M
> CPU CAPS: [pause,cbcond,aes,des,camellia,md5,sha1,sha256]^M
> CPU CAPS: [sha512,mpmul,montmul,montsqr,crc32c]^M
> PERCPU: max_distance=0xc000c2410000 too large for vmalloc space 0xffff00000000^M
> PERCPU: auto allocator failed (-22), falling back to page size^M
> PERCPU: 6 8K pages/cpu @0000000100000000 s23552 r8192 d17408^M

Ok, it looks like we need to expand the vmalloc area a bit or two
more, which is easy to do.  I'll cook up a patch for that.

> Let me look at this in the morning when NOT distracted by family issue.

Take your time, your help is appreciated.
