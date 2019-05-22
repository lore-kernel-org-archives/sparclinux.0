From: David Miller <davem@davemloft.net>
Date: Wed, 22 May 2019 17:40:19 +0000
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
Message-Id: <20190522.104019.40493905027242516.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a43f9224e6b245ade4b587a018c8a21815091f0f.camel@intel.com>
	<20190520.184336.743103388474716249.davem@davemloft.net>
	<339ef85d984f329aa66f29fa80781624e6e4aecc.camel@intel.com>
In-Reply-To: <339ef85d984f329aa66f29fa80781624e6e4aecc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rick.p.edgecombe@intel.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, linux-mm@kvack.org, mroos@linux.ee, mingo@redhat.com, namit@vmware.com, luto@kernel.org, bp@alien8.de, netdev@vger.kernel.org, dave.hansen@intel.com, sparclinux@vger.kernel.org

From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 01:59:54 +0000

> On Mon, 2019-05-20 at 18:43 -0700, David Miller wrote:
>> From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
>> Date: Tue, 21 May 2019 01:20:33 +0000
>> 
>> > Should it handle executing an unmapped page gracefully? Because
>> > this
>> > change is causing that to happen much earlier. If something was
>> > relying
>> > on a cached translation to execute something it could find the
>> > mapping
>> > disappear.
>> 
>> Does this work by not mapping any kernel mappings at the beginning,
>> and then filling in the BPF mappings in response to faults?
> No, nothing too fancy. It just flushes the vm mapping immediatly in
> vfree for execute (and RO) mappings. The only thing that happens around
> allocation time is setting of a new flag to tell vmalloc to do the
> flush.
> 
> The problem before was that the pages would be freed before the execute
> mapping was flushed. So then when the pages got recycled, random,
> sometimes coming from userspace, data would be mapped as executable in
> the kernel by the un-flushed tlb entries.

If I am to understand things correctly, there was a case where 'end'
could be smaller than 'start' when doing a range flush.  That would
definitely kill some of the sparc64 TLB flush routines.
