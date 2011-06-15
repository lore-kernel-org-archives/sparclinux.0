From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jun 2011 12:05:29 +0000
Subject: Re: linux-next: build failure after merge of the final tree (staging related)
Message-Id: <BANLkTim5dYNmTMJo-Wa3LYCTi4vxPGMNeQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110609172745.dfd3a298.sfr@canb.auug.org.au>
	<20110609184127.GA2760@kroah.com>
	<20110609192243.GA3980@kroah.com>
	<20110610160548.529797c7.sfr@canb.auug.org.au>
In-Reply-To: <20110610160548.529797c7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, brudley@broadcom.com, henryp@broadcom.com, rvossen@broadcom.com, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Linus <torvalds@linux-foundation.org>, sparclinux@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Jun 10, 2011 at 08:05, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Thu, 9 Jun 2011 12:22:43 -0700 Greg KH <greg@kroah.com> wrote:
>> On Thu, Jun 09, 2011 at 11:41:27AM -0700, Greg KH wrote:
>> > > Also in several other files in drivers/staging/brcm80211/
>> > >
>> > > Also:
>> > >
>> > > drivers/staging/comedi/drivers.c: In function 'comedi_buf_alloc':
>> > > drivers/staging/comedi/drivers.c:505:37: error: 'PAGE_KERNEL_NOCACHE' undeclared (first use in this function)

I have my doubts

#ifdef PAGE_KERNEL_NOCACHE
                            vmap(pages, n_pages, VM_MAP, PAGE_KERNEL_NOCACHE);
#else
                            vmap(pages, n_pages, VM_MAP, PAGE_KERNEL);
#endif

is the right "fix" for this...

BTW, PAGE_KERNEL_NOCACHE is defined on frv, m32r, mn10300, sh, and x86 only.

Strangely, both sparc and tile have

/*
 * Some hardware wants to get fixmapped without caching.
 */
#define set_fixmap_nocache(idx, phys) \
                __set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)

in their <asm/fixmap.h>, without having PAGE_KERNEL_NOCACHE...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
