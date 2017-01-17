From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 17 Jan 2017 21:43:07 +0000
Subject: Re: [PATCH v4 0/4] Application Data Integrity feature introduced by SPARC M7
Message-Id: <c1c944f7-d5e6-38ec-6fde-9e6d5c1af6d0@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <621cfed0-3e56-13e6-689a-0637bce164fe@linux.intel.com>
 <f70cd704-f486-ed5c-7961-b71278fc8f9a@oracle.com>
 <11d20dac-2c0f-6e9a-7f98-3839c749adb6@linux.intel.com>
 <20170116.234749.545252655332977761.davem@davemloft.net>
In-Reply-To: <20170116.234749.545252655332977761.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, dave.hansen@linux.intel.com
Cc: corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org, hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmwa

On 01/16/2017 09:47 PM, David Miller wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Date: Wed, 11 Jan 2017 10:13:54 -0800
>
>> For memory shared by two different processes, do they have to agree on
>> what the tags are, or can they differ?
>
> Whoever allocates the memory (does the mmap()+mprotect() or whatever),
> decides on the tag.  They set it, and this determines which virtual
> address is valid to access that mapping.
>
> It's like kmalloc() returns pointers with some weird bits set in the
> upper bits of the address.  Behind the scenes kmalloc() sets the
> TAG bits appropriately.
>
> It doesn't, in that sense, matter where in the non-tagged virtual
> address space the memory is mapped.  All that matters is that, for
> a given page, the TAG bits in the virtual address used for loads
> and stores to that mapping are set properly.
>
> I think the fundamental thing being missed is that the TAG bits in the
> virtual address are not interpreted by the TLB.  They are chopped off
> before virtual address translation occurs.
>
> The TAG bits of the virtual address serve only to indicate what ADI
> value the load or store thinks is valid to use for access to that
> piece of memory.
>
> Or something like that... :-)

Hi David,

Your explanation is spot on. MMU looks at the tag bits only to determine 
if the process has permission to access the memory address. Tag bits are 
not part of VA->PA translation. The tags are stored in physical memory 
though and MMU compares the tag stored at physical address obtained from 
TLB translation to the tag embedded in VA. What that means is if two 
processes map the same physical page in their address space, they both 
must embed the same tag in the VA they present to MMU irrespective of 
where in each process' address space the page is mapped in. If one 
process changes the tag, stored in physical memory, the other process 
must also embed the new tag in its VA when accessing this shared mapped 
page. This is something to consider because a tag can be set and changed 
entirely from userspace with no kernel involvement as long as the 
process has write access to memory.

--
Khalid

