From: David Miller <davem@davemloft.net>
Date: Tue, 05 Mar 2019 17:01:48 +0000
Subject: Re: [PATCH v4 2/4] sparc: Advertise gigantic page support
Message-Id: <20190305.090148.215877410650179589.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <08671d74-3851-5ff2-97c3-1da3ab0458af@ghiti.fr>
In-Reply-To: <08671d74-3851-5ff2-97c3-1da3ab0458af@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Ghiti <alex@ghiti.fr>
Date: Tue, 5 Mar 2019 02:01:03 -0500

> On 2/28/19 1:36 AM, Alexandre Ghiti wrote:
>> sparc actually supports gigantic pages and selecting
>> ARCH_HAS_GIGANTIC_PAGE allows it to allocate and free
>> gigantic pages at runtime.
>>
>> sparc allows configuration such as huge pages of 16GB,
>> pages of 8KB and MAX_ORDER = 13 (default):
>> HPAGE_SHIFT (34) - PAGE_SHIFT (13) = 21 >= MAX_ORDER (13)
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/sparc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index d5dd652fb8cc..053a36246d4d 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -46,6 +46,7 @@ config SPARC
>>   	select LOCKDEP_SMALL if LOCKDEP
>>   	select NEED_DMA_MAP_STATE
>>   	select NEED_SG_DMA_LENGTH
>> + select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) ||
>> CMA
>>     config SPARC32
>>   	def_bool !64BIT
> 
> Hi David,
> 
> Do you have any remark regarding this patch before I send a v5 ?

You should probably put conditional on SPARC64.
