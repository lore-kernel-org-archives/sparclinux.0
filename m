From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 14 Dec 2009 07:57:06 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area
Message-Id: <4B25EFD2.7040306@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>> We did yes. You said that mem_map is not offset at phys_base and
>> then of course we don't need to add it in page_to_phys. Is mem_map
>> not offset because typically sp_banks[].base_addr = 0? In our case
>> we pass in one sp_banks entry which has base_addr = 0x40000000.
> 
> I'm still trying to find time to address this, just FYI.
> 
> 

Thanks. I have been working on non Linux stuff for a while
but in the meantime I have actually used the patch where
phys_base is added in page_to_phys.

I hope to continue Linux development after Christmas.

Happy holidays :)

/Kristoffer
