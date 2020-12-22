From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 22 Dec 2020 23:52:28 +0000
Subject: Re: sparc32: Init process fails to load with generic kmap atomic
Message-Id: <87v9ctcsar.fsf@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
In-Reply-To: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Larsson <andreas@gaisler.com>, sparclinux <sparclinux@vger.kernel.org>, linux-mm@kvack.org
Cc: "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Dec 22 2020 at 18:58, Andreas Larsson wrote:
>  From as far as I have gotten into hunting down the problem, I get a
> failure from load_elf_binary here:
>
> 	/* First of all, some simple consistency checks */
> 	if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
> 		goto out;
>
> at least seemingly due to the kaddr from copy_page_to_iter in
> lib/iov_iter.c
>
> 	if (i->type & (ITER_BVEC|ITER_KVEC)) {
> 		void *kaddr = kmap_atomic(page);
> 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
>
> where kaddr points to memory with all zeroes (from an earlier bzero) in 
> this context:

The kaddr might be misleading you here. If the code flow is:

    kaddr1 = kmap_atomic(page1);
    ...
    kunmap_atomic(kaddr1);

    kaddr2 = kmap_atomic(page2);

Then kaddr1 = kaddr2, but first it maps page1 and then page2, but that
was the same in the original code.

> I will have to continue to dig deeper into this in January. If anyone
> has any ideas how this could stem from this kmap patch, I am all ears.

I can't spot it either. I'll send you a debug patch after the holidays.

Thanks,

        tglx
