From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 29 Sep 2016 13:53:24 +0000
Subject: Re: [PATCH v3 1/2] config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc
Message-Id: <c4035ddb-effb-f9ef-9110-aef0703276cd@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
 <1475004808-91920-2-git-send-email-babu.moger@oracle.com>
 <20160928083926.GQ5016@twins.programming.kicks-ass.net>
In-Reply-To: <20160928083926.GQ5016@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, sam@ravnborg.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>


On 9/28/2016 3:39 AM, Peter Zijlstra wrote:
> On Tue, Sep 27, 2016 at 12:33:27PM -0700, Babu Moger wrote:
>> This new config parameter limits the space used for "Lock debugging:
>> prove locking correctness" by about 4MB. The current sparc systems have
>> the limitation of 32MB size for kernel size including .text, .data and
>> .bss sections. With PROVE_LOCKING feature, the kernel size could grow
>> beyond this limit and causing system boot-up issues. With this option,
>> kernel limits the size of the entries of lock_chains, stack_trace etc.,
>> so that kernel fits in required size limit. This is not visible to user
>> and only used for sparc.
>>
>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> You forgot to Cc Dave, and since you're touching sparc I need an Ack
> from him before I can queue this.
Dave, Can you please take a look at the patch. Please ack it if it looks 
good.
Thanks
>
> Dave?
>
>> ---
>>   arch/sparc/Kconfig |    1 +
>>   lib/Kconfig.debug  |    3 +++
>>   2 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 59b0960..8da321c 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -44,6 +44,7 @@ config SPARC
>>   	select ARCH_HAS_SG_CHAIN
>>   	select CPU_NO_EFFICIENT_FFS
>>   	select HAVE_ARCH_HARDENED_USERCOPY
>> +	select PROVE_LOCKING_SMALL if PROVE_LOCKING
>>   
>>   config SPARC32
>>   	def_bool !64BIT
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index cab7405..597e589 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1084,6 +1084,9 @@ config PROVE_LOCKING
>>   
>>   	 For more details, see Documentation/locking/lockdep-design.txt.
>>   
>> +config PROVE_LOCKING_SMALL
>> +	bool
>> +
>>   config LOCKDEP
>>   	bool
>>   	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
>> -- 
>> 1.7.1
>>

