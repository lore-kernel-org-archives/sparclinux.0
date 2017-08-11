From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 16:11:24 +0000
Subject: Re: [v6 13/15] mm: stop zeroing memory during allocation in vmemmap
Message-Id: <16bdfd76-d28a-0732-9a15-29cc373e1236@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-14-git-send-email-pasha.tatashin@oracle.com>
 <20170811130449.GL30811@dhcp22.suse.cz>
In-Reply-To: <20170811130449.GL30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/11/2017 09:04 AM, Michal Hocko wrote:
> On Mon 07-08-17 16:38:47, Pavel Tatashin wrote:
>> Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
>> we will get the performance improvement by zeroing the memory in parallel
>> when struct pages are zeroed.
> 
> First of all this should be probably merged with the previous patch. The
> I think vmemmap_alloc_block would be better to split up into
> __vmemmap_alloc_block which doesn't zero and vmemmap_alloc_block which
> does zero which would reduce the memset callsites and it would make it
> slightly more robust interface.

Ok, I will add: vmemmap_alloc_block_zero() call, and merge this and the 
previous patches together.
