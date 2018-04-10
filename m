From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 15:10:52 +0000
Subject: Re: [PATCH 2/3] mm: replace __HAVE_ARCH_PTE_SPECIAL
Message-Id: <3a330851-d545-ebd8-e74c-c44e12220c24@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180409175757.GA12938@infradead.org>
 <alpine.DEB.2.21.1804091307480.56406@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1804091307480.56406@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/04/2018 22:08, David Rientjes wrote:
> On Mon, 9 Apr 2018, Christoph Hellwig wrote:
> 
>>> -#ifdef __HAVE_ARCH_PTE_SPECIAL
>>> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>>  # define HAVE_PTE_SPECIAL 1
>>>  #else
>>>  # define HAVE_PTE_SPECIAL 0
>>
>> I'd say kill this odd indirection and just use the
>> CONFIG_ARCH_HAS_PTE_SPECIAL symbol directly.
>>
>>
> 
> Agree, and I think it would be easier to audit/review if patches 1 and 3 
> were folded together to see the relationship between the newly added 
> selects and what #define's it is replacing.  Otherwise, looks good!
>

Ok I will fold the 3 patches and introduce a new one removing HAVE_PTE_SPECIAL.

Thanks,
Laurent.

