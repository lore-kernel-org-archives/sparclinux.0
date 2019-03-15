From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Fri, 15 Mar 2019 02:57:58 +0000
Subject: Re: [PATCH v6 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
Message-Id: <a96fefc5-c7dc-a335-8d87-603a0be03ac6@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190307132015.26970-1-alex@ghiti.fr>
 <20190307132015.26970-5-alex@ghiti.fr> <87va0movdh.fsf@linux.ibm.com>
 <e39f5b5b-efa1-c7b1-c1d8-89155b926027@ghiti.fr>
 <972208b7-5c05-cc05-efbf-0d48bff4cf77@linux.ibm.com>
 <b6259684-ddc0-ade4-1881-016b5e7fff66@ghiti.fr>
In-Reply-To: <b6259684-ddc0-ade4-1881-016b5e7fff66@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

On 3/14/19 7:22 PM, Alexandre Ghiti wrote:
> 
> 
> On 03/14/2019 02:17 PM, Aneesh Kumar K.V wrote:
>> On 3/14/19 5:13 PM, Alexandre Ghiti wrote:
>>> On 03/14/2019 06:52 AM, Aneesh Kumar K.V wrote:
>>>> Alexandre Ghiti <alex@ghiti.fr> writes:
>>>>
>>
>>> Thanks for noticing Aneesh.
>>>
>>> I can't find a better solution than bringing back 
>>> gigantic_page_supported check,
>>> since it is must be done at runtime in your case.
>>> I'm not sure of one thing though: you say that freeing boottime 
>>> gigantic pages
>>> is not needed, but is it forbidden ? Just to know where the check and 
>>> what its
>>> new name should be.
> 
> You did not answer this question: is freeing boottime gigantic pages 
> "forbidden" or just
> not needed ?

IMHO if we don't allow runtime allocation of gigantic hugepage, we 
should not allow runtime free of gigantic hugepage. Now w.r.t ppc64, 
hypervisor pass hints about the gignatic hugepages via device tree 
nodes. Early in boot we mark these pages as reserved and during hugetlb 
init we use these reserved pages for backing hugetlb fs.

Now "forbidden" is not the exact reason. We don't have code to put it 
back in the reserved list. Hence I would say "not supported".

-aneesh
