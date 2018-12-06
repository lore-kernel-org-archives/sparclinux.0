From: Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 06 Dec 2018 07:31:11 +0000
Subject: Re: [PATCH v2 2/6] microblaze: prefer memblock API returning virtual address
Message-Id: <20181206073111.GH19181@rapoport-lnx>
List-Id: <sparclinux.vger.kernel.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-3-git-send-email-rppt@linux.ibm.com>
 <0a5e0aef-15fd-2d0c-765c-e7ba60219b00@monstr.eu>
In-Reply-To: <0a5e0aef-15fd-2d0c-765c-e7ba60219b00@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michal Simek <michal.simek@xilinx.com>, linux-mm@kvack.org, Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Wed, Dec 05, 2018 at 04:29:40PM +0100, Michal Simek wrote:
> On 03. 12. 18 16:47, Mike Rapoport wrote:
> > Rather than use the memblock_alloc_base that returns a physical address and
> > then convert this address to the virtual one, use appropriate memblock
> > function that returns a virtual address.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/microblaze/mm/init.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> > index b17fd8a..44f4b89 100644
> > --- a/arch/microblaze/mm/init.c
> > +++ b/arch/microblaze/mm/init.c
> > @@ -363,8 +363,9 @@ void __init *early_get_page(void)
> >  	 * Mem start + kernel_tlb -> here is limit
> >  	 * because of mem mapping from head.S
> >  	 */
> > -	return __va(memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
> > -				memory_start + kernel_tlb));
> > +	return memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
> > +				MEMBLOCK_LOW_LIMIT, memory_start + kernel_tlb,
> > +				NUMA_NO_NODE);
> >  }
> >  
> >  #endif /* CONFIG_MMU */
> > 
> 
> I can't see any issue with functionality when this patch is applied.
> If you want me to take this via my tree please let me know.

I thought to route this via mmotm tree.

> Otherwise:
> 
> Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks!

 
> Thanks,
> Michal
> 
> -- 
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
> 
> 




-- 
Sincerely yours,
Mike.
