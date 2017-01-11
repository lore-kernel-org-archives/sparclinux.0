From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 11 Jan 2017 16:56:45 +0000
Subject: Re: [PATCH v4 0/4] Application Data Integrity feature introduced by SPARC M7
Message-Id: <f70cd704-f486-ed5c-7961-b71278fc8f9a@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1483999591.git.khalid.aziz@oracle.com>
 <621cfed0-3e56-13e6-689a-0637bce164fe@linux.intel.com>
In-Reply-To: <621cfed0-3e56-13e6-689a-0637bce164fe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Hansen <dave.hansen@linux.intel.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kerne

On 01/11/2017 09:33 AM, Dave Hansen wrote:
> On 01/11/2017 08:12 AM, Khalid Aziz wrote:
>> A userspace task enables ADI through mprotect(). This patch series adds
>> a page protection bit PROT_ADI and a corresponding VMA flag
>> VM_SPARC_ADI. VM_SPARC_ADI is used to trigger setting TTE.mcd bit in the
>> sparc pte that enables ADI checking on the corresponding page.
>
> Is there a cost in the hardware associated with doing this "ADI
> checking"?  For instance, instead of having this new mprotect()
> interface, why not just always set TTE.mcd on all PTEs?

There is no performance penalty in the MMU to check tags, but if 
PSTATE.mcd bit is set and TTE.mcde is set, the tag in VA must match what 
was set on the physical page for all memory accesses. Potential for side 
effects is too high in such case and would require kernel to either 
track tags for every page as they are re-allocated or migrated, or scrub 
pages constantly to ensure we do not get spurious tag mismatches. Unless 
there is a very strong reason to blindly set TTE.mcd on every PTE, I 
think the risk of instability is too high without lot of extra code.

>
> Also, should this be a privileged interface in some way?  The hardware
> is storing these tags *somewhere* and that storage is consuming
> resources *somewhere*.  What stops a crafty attacker from mmap()'ing a
> 128TB chunk of the zero pages and storing ADI tags for all of it?
> That'll be 128TB/64*4bits = 1TB worth of 4-bit tags.  Page tables, for
> instance, consume a comparable amount of storage, but the OS *knows*
> about those and can factor them into OOM decisions.

Hardware resources used to store tags are managed entirely by MMU and 
invisible to the kernel. Tags are stored in spare bits in memory. The 
only tag resource consumption visible to OS will be the space it 
allocates to store tags as pages are swapped in/out or migrated. If we 
choose to implement subpage granularity for tags in future, resource 
consumption will be a concern. You are right, each n pages of tagged 
memory requires n/128 pages to store tags. Since each tag is just 4 
bits, there are good possibilities to compress this data but that is for 
future.

Thanks,
Khalid
