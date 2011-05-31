From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 May 2011 07:47:15 +0000
Subject: Re: [PATCH 0/4] resources: Add lookup_resource()
Message-Id: <BANLkTi=YE4fSVQTNaYAwZ1YijqsUfTRmHg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1306006756-32009-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1306006756-32009-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>

On Sat, May 21, 2011 at 21:39, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> The resource system is a nice existing subsystem to implement simple allocators
> on top of.
> Unfortunately, there's no official method to find an existing resource by a
> resource start address, which is needed for a freeing function that just takes
> the start address of the region to free.
>
> Currently there are 3 users of the resource subsystem that implement this by
> traversing the resource tree theirselves:
>  - The Amiga Chip RAM allocator on m68k,
>  - iomap()/iounmap() on sparc,
>  - DMA allocation API on sparc.
> They all lack locking of the resource tree, as resource_lock is static in
> kernel/resource.c.
>
> Hence this patchset adds lookup_resource() and converts the above users to it.
>
>  [1/4] sparc: _sparc_find_resource() should check for exact matches
>  [2/4] resources: Add lookup_resource()
>  [3/4] m68k/amiga: Chip RAM - Use lookup_resource()
>  [4/4] sparc: iounmap() and *_free_coherent() - Use lookup_resource()

As I got two acks from David for the sparc bits and no objections, I
queued these
on my for-2.6.41 and for-next branches.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
