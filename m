From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 06 Sep 2017 14:10:05 +0000
Subject: Re: [PATCH v7 9/9] sparc64: Add support for ADI (Application Data Integrity)
Message-Id: <6494b4c4-6d5b-7e45-f053-00535bb898aa@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1502219353.git.khalid.aziz@oracle.com>
 <3a687666c2e7972fb6d2379848f31006ac1dd59a.1502219353.git.khalid.aziz@oracle.com>
 <20170904162530.GA21781@amd>
In-Reply-To: <20170904162530.GA21781@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, corbet@lwn.net, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, mike.kravetz@oracle.com, mingo@kernel.org, nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, eric.saint.etienne@oracle.com, allen.pais@oracle.com, cmetcalf@mellanox.com, akpm@linux-foundation.org, geert@linux-m68k.org, tklauser@distanz.ch, atish.patra@oracle.com, vijay.ac.kumar@oracle.com, peterz@infradead.org, mhocko@suse.com, jack@suse.cz, lstoakes@gmail.com, hughd@google.com, thomas.tai@oracle.com, paul.gortmaker@windriver.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, willy@infradead.org, ying.huang@intel.com, zhongjiang@huawei.com, minchan@kernel.org, vegard.nossum@oracle.com, imbrenda@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Khalid Aziz <khalid@gonehiking.org>

On 09/04/2017 10:25 AM, Pavel Machek wrote:
> Hi!
> 
>> ADI is a new feature supported on SPARC M7 and newer processors to allow
>> hardware to catch rogue accesses to memory. ADI is supported for data
>> fetches only and not instruction fetches. An app can enable ADI on its
>> data pages, set version tags on them and use versioned addresses to
>> access the data pages. Upper bits of the address contain the version
>> tag. On M7 processors, upper four bits (bits 63-60) contain the version
>> tag. If a rogue app attempts to access ADI enabled data pages, its
>> access is blocked and processor generates an exception. Please see
>> Documentation/sparc/adi.txt for further details.
> 
> I'm afraid I still don't understand what this is meant to prevent.
> 
> IOMMU ignores these, so this is not to prevent rogue DMA from doing
> bad stuff.
> 
> Will gcc be able to compile code that uses these automatically? That
> does not sound easy to me. Can libc automatically use this in malloc()
> to prevent accessing freed data when buffers are overrun?
> 
> Is this for benefit of JITs?
> 

David explained it well. Yes, preventing buffer overflow is one of the 
uses of ADI. Protecting critical data from wild writes caused by 
programming errors is another use. ADI can be used for debugging as well 
during development.

Thanks,
Khalid
