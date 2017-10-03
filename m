From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 03 Oct 2017 15:07:54 +0000
Subject: Re: [PATCH v9 01/12] x86/mm: setting fields in deferred pages
Message-Id: <00978c7c-8d05-fbc3-eaba-9455b66ff02e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-2-pasha.tatashin@oracle.com>
 <20171003122658.cv64pxnuavopjid6@dhcp22.suse.cz>
In-Reply-To: <20171003122658.cv64pxnuavopjid6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Michal,

> 
> I hope I haven't missed anything but it looks good to me.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you for your review.

> 
> one nit below
>> ---
>>   arch/x86/mm/init_64.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 5ea1c3c2636e..30fe22558720 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -1182,12 +1182,17 @@ void __init mem_init(void)
>>   
>>   	/* clear_bss() already clear the empty_zero_page */
>>   
>> -	register_page_bootmem_info();
>> -
>>   	/* this will put all memory onto the freelists */
>>   	free_all_bootmem();
>>   	after_bootmem = 1;
>>   
>> +	/* Must be done after boot memory is put on freelist, because here we
> 
> standard code style is to do
> 	/*
> 	 * text starts here

OK, will change for both patch 1 and 2.

Pasha
