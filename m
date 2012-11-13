From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 13 Nov 2012 04:46:17 +0000
Subject: Re: [PATCH] arch/sparc: additional len check in loop for prom_getbootargs
Message-Id: <50A1D099.9090707@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
References: <509B29F3.2040006@asianux.com>
In-Reply-To: <509B29F3.2040006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

于 2012年11月13日 11:25, Chen Gang 写道:
> 于 2012年11月09日 00:33, Sam Ravnborg 写道:
>> Anyway please consider this alternative fix:
>>
>> diff --git a/arch/sparc/prom/bootstr_32.c b/arch/sparc/prom/bootstr_32.c
>> index f5ec32e..4ce602f 100644
>> --- a/arch/sparc/prom/bootstr_32.c
>> +++ b/arch/sparc/prom/bootstr_32.c
>> @@ -31,14 +31,10 @@ prom_getbootargs(void)
>>  			arg = (*(romvec->pv_v0bootargs))->argv[iter];
>>  			if (arg = NULL)
>>  				break;
>> -			while(*arg != 0) {
>> -				/* Leave place for space and null. */
>> -				if(cp >= barg_buf + BARG_LEN-2){
>> -					/* We might issue a warning here. */
>> -					break;
>> -				}
>> +			while (*arg != 0 && cp < (barg_buf + BARG_LEN - 2))
>>  				*cp++ = *arg++;
>> -			}
>> +
>> +			/* Append trailing space + null */
>>  			*cp++ = ' ';
>>  		}
>>  		*cp = 0;
>>
>>
>> Adding the conditional inside the while loop makes
>> the logic simpler. And the patch actually deletes more lines than it adds.
>> And please take care to follow coding style too. In particular spaces around operators.
>>
>> The old code does not follow coding style - but this is no excuse.
>>
> 
>   I agree with the contents above.
> 

1) although I agree with what you said.

2) but for the patch code:
   after "*cp++ = ' ';", also need "break checking" for "for (; ;)" outside of "while()"

3) please check, and still it will be better to notice coding style, too.

-- 
Chen Gang

Asianux Corporation
