From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 16:18:24 +0000
Subject: Re: [v6 15/15] mm: debug for raw alloctor
Message-Id: <87d84cad-f03a-88f0-7828-6d3bf7ac473c@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-16-git-send-email-pasha.tatashin@oracle.com>
 <20170811130831.GN30811@dhcp22.suse.cz>
In-Reply-To: <20170811130831.GN30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> When CONFIG_DEBUG_VM is enabled, this patch sets all the memory that is
>> returned by memblock_virt_alloc_try_nid_raw() to ones to ensure that no
>> places excpect zeroed memory.
> 
> Please fold this into the patch which introduces
> memblock_virt_alloc_try_nid_raw.

OK

  I am not sure CONFIG_DEBUG_VM is the
> best config because that tends to be enabled quite often. Maybe
> CONFIG_MEMBLOCK_DEBUG? Or even make it kernel command line parameter?
> 

Initially, I did not want to make it CONFIG_MEMBLOCK_DEBUG because we 
really benefit from this debugging code when VM debug is enabled, and 
especially struct page debugging asserts which also depend on 
CONFIG_DEBUG_VM.

However, now thinking about it, I will change it to 
CONFIG_MEMBLOCK_DEBUG, and let users decide what other debugging configs 
need to be enabled, as this is also OK.

Thank you,
Pasha
