From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 04 Jan 2012 21:56:18 +0000
Subject: Re: [WIP] sparc32: replace bootmem with memblock
Message-Id: <20120104215618.GA7968@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120103204516.GA4271@merkur.ravnborg.org>
In-Reply-To: <20120103204516.GA4271@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 04, 2012 at 04:29:19PM -0500, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 3 Jan 2012 21:45:16 +0100
> 
> > - kern_addr_valid is (temporary) disabled
> >   I could not grock the code allocating sparc_valid_addr_bitmap
> >   and I noticed most archs do not implement this check
> 
> Is it hard to grok where the memory is allocated from or the
> calculation of the bitmap memory's size? :-)

        i = last_valid_pfn >> ((20 - PAGE_SHIFT) + 5);
        i += 1;
        sparc_valid_addr_bitmap = (unsigned long *)
                __alloc_bootmem(i << 2, SMP_CACHE_BYTES, 0UL);

I failed to find out how we calculate the amount
of memory to allocate.

last_valid_pfn is the last page of the available memory.
So last_valid_pfn >> (20 - PAGE_SHIFT) is the amount of
memory expressed in MB.

But then we shifted an additional "+ 5".
This looks like we go for 32 MB.
+ 1 is just to make sure we cover the last page I think.
And when we allocate we do " i << 2 " so we are down to
8 MB.

When we use it we do:
#define kern_addr_valid(addr) \
        (test_bit(__pa((unsigned long)(addr))>>20, sparc_valid_addr_bitmap))

so here it looks like we have one bit for each MB.

I also looked at:
static void __init taint_real_pages(void)
{
        int i;

        for (i = 0; sp_banks[i].num_bytes; i++) {
                unsigned long start, end;

                start = sp_banks[i].base_addr;
                end = start + sp_banks[i].num_bytes;

                while (start < end) {
                        set_bit(start >> 20, sparc_valid_addr_bitmap);
                        start += PAGE_SIZE;
                }
        }
}

Here I could see that we set a bit for each MB
in sparc_valid_addr_bitmap and it is not limited
to the kernel address range.
 
In the end I got confused and dropped it because I could see that
lots of other archs did not implment this check either.

I will capture all this info in the commit which drop this
for later reference.

	Sam
