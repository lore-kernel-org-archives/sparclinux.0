From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 05 Jun 2017 03:52:32 +0000
Subject: Re: [v1 6/6] sparc64: initialize time early
Message-Id: <db5edeb2-2104-8329-3f9d-2e7ea7edfbde@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496428854-936411-7-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1496428854-936411-7-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave,

Thank you for your review. Sure, I can remove these restrictions, and I 
believe it will just work, but I do not have means to test it on that 
hardware.

Pasha

On 2017-06-04 22:23, David Miller wrote:
> From: Pavel Tatashin <pasha.tatashin@oracle.com>
> Date: Fri,  2 Jun 2017 14:40:54 -0400
> 
>> @@ -792,6 +791,12 @@ static void init_tick_ops(struct sparc64_tick_ops *ops)
>>   	tick_operations = *ops;
>>   }
>>   
>> +void __init time_init_early(void)
>> +{
>> +	if (tlb_type != spitfire)
>> +		init_tick_ops(&stick_operations);
>> +}
>> +
>>   void __init time_init(void)
>>   {
>>   	unsigned long freq;
>> @@ -801,8 +806,6 @@ void __init time_init(void)
>>   			init_tick_ops(&hbtick_operations);
>>   		else
>>   			init_tick_ops(&tick_operations);
>> -	} else {
>> -		init_tick_ops(&stick_operations);
>>   	}
>>   
>>   	freq = tick_operations.frequency;
> 
> Please make this early init work properly on spitfire and hummingbird.
> 
> There is no reason to special case things like this.
> 
> Thanks.
> 

