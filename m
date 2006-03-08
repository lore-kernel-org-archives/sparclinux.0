From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 08 Mar 2006 08:02:35 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <20060308.000235.127227757.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Date: Tue, 07 Mar 2006 20:54:21 -0600

> With 2 sticks per CPU:
> 1} ok cd /memory
> {1} ok .properties
> reg                      00000000 00000000 00000000 40000000
>                          00000010 00000000 00000000 40000000
 ...
> free_bootmem(pavail:0): base[0] size[40000000]
> free_bootmem(pavail:1): base[1000000000] size[3effe000]
> free_bootmem(pavail:2): base[103f000000] size[e9e000]
> free_bootmem(pavail:3): base[103fea0000] size[10000]
> free_bootmem(pavail:4): base[103fee0000] size[6000]
> free_bootmem(pavail:5): base[103feea000] size[4000]
> reserve_bootmem(kernel): base[103f000000] size[31e960]
> reserve_bootmem(bootmap): base[103f320000] size[103ff0]

What's happening is that because the physical memory layout is so
sparse, tons of memory are being wasted on "struct page" objects being
used for that big gap between the two actual physical memory areas.

The gap is smaller when you put all the ram sticks under cpu0,
which is why the wastage is less pronounced in that case.

I guess I should code up some sparsemem support, it would help for
cases like this.

Thanks for the detailed report Josh :)
