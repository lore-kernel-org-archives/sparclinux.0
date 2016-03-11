From: David Miller <davem@davemloft.net>
Date: Fri, 11 Mar 2016 17:13:38 +0000
Subject: Re: [PATCH 1/1] [RFC]sparc64: enable cpu hotplug feature
Message-Id: <20160311.121338.598244154579236845.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1456565906-2072-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1456565906-2072-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Fri, 11 Mar 2016 19:40:36 +0530

>> This patch provides users with an option to
>> disable/enable cpu at runtime by writing to
>> /sys/devices/system/cpu/cpuX/online field.
>> 
>> Eg:
>> $ echo [0/1] > /sys/devices/system/cpu/cpu2/online
>> 
>> Signed-off-by: Allen Pais <allen.pais@oracle.com>
>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> ---
>>  arch/sparc/kernel/smp_64.c |   48 +++++++++++++++++++++++--------------------
>>  arch/sparc/kernel/sysfs.c  |    4 +++
>>  2 files changed, 30 insertions(+), 22 deletions(-)
>> 
>> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
>> index 19cd08d..5ea2f91 100644
>> --- a/arch/sparc/kernel/smp_64.c
>> +++ b/arch/sparc/kernel/smp_64.c
>> @@ -1277,20 +1277,26 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>  {
>>  	int ret = smp_boot_one_cpu(cpu, tidle);
>>  
>> -	if (!ret) {
>> -		cpumask_set_cpu(cpu, &smp_commenced_mask);
>> -		while (!cpu_online(cpu))
>> -			mb();
>> -		if (!cpu_online(cpu)) {
>> -			ret = -ENODEV;
>> -		} else {
>> -			/* On SUN4V, writes to %tick and %stick are
>> -			 * not allowed.
>> -			 */
> 
> Any comments on this patch??

If I had the time to review it, I would have by now.

Instead, it is in my patchwork backlog waiting for the opportunity to
arise.

Pinging like this won't help and only makes it take longer for me to get
to reviewing your patch.

So if your patch is sitting in patchwork, the only thing you can do is
simply be patient.

Thanks.
