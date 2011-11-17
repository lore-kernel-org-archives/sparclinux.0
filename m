From: Roland Dreier <roland@purestorage.com>
Date: Thu, 17 Nov 2011 23:30:19 +0000
Subject: Re: [BUG] Bad page map in process ibv_devinfo
Message-Id: <CAL1RGDV_AwOOnLvWJKGqBTaptetfVN_gXNG=PcaFUXYSXrQ5AA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1321110951.99968.YahooMailNeo@web24712.mail.ird.yahoo.com>
 <CAL1RGDXnzQTQuMica3ZsRYbGNhT7GcySQvcAnJ+-5E2P0xw4Ag@mail.gmail.com>
 <1321471354.5493.YahooMailNeo@web24714.mail.ird.yahoo.com> <20111117.164941.2104520709167256016.davem@davemloft.net>
In-Reply-To: <20111117.164941.2104520709167256016.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: linux@razik.name, sparclinux@vger.kernel.org, linux-rdma@vger.kernel.org

On Thu, Nov 17, 2011 at 1:49 PM, David Miller <davem@davemloft.net> wrote:
>> I'm wondering if the bug is in the mlx4 code or in the sparc
>> io_remap_pfn_range()
>> code.=A0 From the "Bad page map" pte value, if I understand sparc mm cor=
rectly,
>> the PTE is seen as not present.

> The not-present test is essentially testing the PTE against zero.

Isn't the pte_present assembly checking if the _PAGE_PRESENT_4V bit
is set, not whether it's completely 0?

> This bug check is making sure that there are not already existing mappings
> at that address when the io_remap_pfn_range() call occurs.

But the call trace is in the munmap() call -- it's just printing where the
bad map was set up initially.  We're somewhere in unmap_vmas(),
probably one of the tests in zap_pte_range().  Since we got

    [ 9305.698663] swap_free: Bad swap file entry 100005e000061800

I'm guessing somehow we reached

		} else {
			swp_entry_t entry =3D pte_to_swp_entry(ptent);

			if (!non_swap_entry(entry))
				rss[MM_SWAPENTS]--;
			if (unlikely(!free_swap_and_cache(entry)))
				print_bad_pte(vma, addr, ptent, NULL);
		}

which shouldn't be possible if pte_present() were set.

 > The only thing I can come up with is that perhaps there is an assumption
 > hiding around somewhere that PAGE_SIZE is 4096.

It's a good idea.  But I don't see how we get past:

static int mlx4_ib_mmap(struct ib_ucontext *context, struct vm_area_struct =
*vma)
{
	struct mlx4_ib_dev *dev =3D to_mdev(context->device);

	if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
		return -EINVAL;

 - R.
