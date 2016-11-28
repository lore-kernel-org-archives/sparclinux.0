From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Mon, 28 Nov 2016 18:33:57 +0000
Subject: Re: [PATCH v2 2/4] sparc64: Migrate hvcons irq to panicked cpu
Message-Id: <7e6a2af2-87b7-f042-cd8a-aabac3b3a80b@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1478887919-10361-1-git-send-email-vijay.ac.kumar@oracle.com>
 <1478887919-10361-3-git-send-email-vijay.ac.kumar@oracle.com>
 <20161119.104812.1434195314137737490.davem@davemloft.net>
In-Reply-To: <20161119.104812.1434195314137737490.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org


On 11/19/2016 9:48 AM, David Miller wrote:
> From: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Date: Fri, 11 Nov 2016 10:11:57 -0800
>
>> @@ -1444,8 +1444,12 @@ void smp_send_stop(void)
>>   	int cpu;
>>   
>>   	if (tlb_type = hypervisor) {
>> +		int this_cpu = smp_processor_id();
>> +
>> +		sunhv_migrate_hvcons_irq(this_cpu);
>> +
> You can't unconditionally call into code that might be configured
> out by a Kconfig option, as you are doing here.
>
> If SERIAL_SUNHV=n this change will thus result in a build error.
Thanks for your comment. I will fix this and send revised version of patch.

Thanks,
Vijay
