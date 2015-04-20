From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Apr 2015 05:17:21 +0000
Subject: Re: Fwd: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib
Message-Id: <55348BE1.4010305@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150419183625.GA18901@oracle.com>
 <1429498885.28239.4.camel@ellerman.id.au>
In-Reply-To: <1429498885.28239.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>, Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Hi Michael,

On 04/19/2015 08:01 PM, Michael Ellerman wrote:
> On Sun, 2015-04-19 at 14:36 -0400, Sowmini Varadhan wrote:
>>> On (04/19/15 14:09), David Miller wrote:
>>>
>>>> On (04/18/15 21:23), Guenter Roeck wrote:
>>>>> lib/built-in.o:(.discard+0x1): multiple definition of
>>>>> `__pcpu_unique_iommu_pool_hash'
>>>>> arch/powerpc/kernel/built-in.o:(.discard+0x18): first defined here
>>>>> .. I get a similar failure in the
>>>>> powerpc:allmodconfig build
>>      :
>>>
>>> Maybe ping the powerpc folks becuase if they can do a quick
>>> conversion, this change isn't necessary.
>>
>> linuxppc-dev,
>>
>> The disussion above [http://www.spinics.net/lists/sparclinux/msg13835.html]
>> is in reference to the issue that Guenter Roeck
>> identified. The problem is that we have a
>>    static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
>
> It's static ..
>
Not if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is configured.

>>    if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is configured, which is the case here.
>>    The marked line above shows that __pcpu_unique_iommu_pool_hash is declared as
>>    global variable"
>
> OK, so why doesn't CONFIG_DEBUG_FORCE_WEAK_PER_CPU depend on s390 and/or alpha?
>
The idea is to ensure that per cpu variable names are unique, even if static,
because that is what is needed for s390 and alpha.

> Someone needs to be doing s390/alpha builds with that enabled anyway, because
> otherwise a clash between generic code and s390/alpha won't be caught.
>
> Or if that's too hard we can rename the powerpc version, but it seems silly to
> rename a powerpc variable to deal with a debug option that is only useful for
> s390/alpha.
>

The debug option is intended for all _other_ architectures, to ensure that
changes made for those don't break alpha/s390 builds. alpha/s390 have
ARCH_NEEDS_WEAK_PER_CPU and don't need the debug option.

Sowmini's patch would change the variable name in the lib/ code. But that was
not the question here. The question was if the powerpc code could be changed
to use the generic iommu code instead of using the powerpc specific code.

Thanks,
Guenter

