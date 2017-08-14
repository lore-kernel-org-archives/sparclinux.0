From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 14 Aug 2017 13:30:35 +0000
Subject: Re: [v6 01/15] x86/mm: reserve only exiting low pages
Message-Id: <8da779a0-ade4-e43e-3b14-2686e347f8ab@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
 <20170811080706.GC30811@dhcp22.suse.cz>
 <47ebf53b-ea8b-1822-a63a-3682ed2f4753@oracle.com>
 <20170814114011.GG19063@dhcp22.suse.cz>
In-Reply-To: <20170814114011.GG19063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> Correct, the pgflags asserts were triggered when we were setting reserved
>> flags to struct page for PFN 0 in which was never initialized through
>> __init_single_page(). The reason they were triggered is because we set all
>> uninitialized memory to ones in one of the debug patches.
> 
> And why don't we need the same treatment for other architectures?
> 

I have not seen similar issues on other architectures. At least this low 
memory reserve is x86 specific for BIOS purposes:

Documentation/admin-guide/kernel-parameters.txt
3624	reservelow=	[X86]
3625			Format: nn[K]
3626			Set the amount of memory to reserve for BIOS at
3627			the bottom of the address space.

If there are similar cases with other architectures, they will be caught 
by the last patch in this series, where all allocated memory is set to 
ones, and page flags asserts will be triggered. I have boot-tested on 
SPARC, ARM, and x86.

Pasha
