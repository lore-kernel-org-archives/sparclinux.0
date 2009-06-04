From: oftedal <oftedal@gmail.com>
Date: Thu, 04 Jun 2009 08:39:48 +0000
Subject: Re: [Bugme-new] [Bug 13444] New: SparcServer 1000E SMP can cause
Message-Id: <Pine.LNX.4.64.0906041032490.12585@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090603144241.99669d0e.akpm@linux-foundation.org>
In-Reply-To: <20090603144241.99669d0e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 3 Jun 2009, David Miller wrote:

> From: oftedal <oftedal@gmail.com>
> Date: Thu, 4 Jun 2009 01:14:33 +0200 (CEST)
>
>> As mentioned in the bug-report(#13444) the sun4d-SMP code on
>> 2.4-series kernels(2.4.37) uses the physical cpu-mapping when
>> inserting tasks into the init_tasks array.
>> And the scheduler uses the logical cpu-mapping which will cause a
>> kernel nullpointer when there are gaps in the physical cpu-mapping.
>>
>> The attached patch uses the cpucount variable, which can be used to
>> find the next logical slot in the init_tasks array. As it is only
>> incremented
>> when a cpu is successfully started.
>>
>> (I hope this was more compliant with kernel-bugfixing standards. I am
>> new to this)
>>
>> Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>
>
> I don't think we're handling 2.4.x patches at this point. :-)
>
> If the bug exists in 2.6.x as well I'd be happy to review such
> a patch and apply it for you.
>

Yeah. 2.4.x is a "bit" old. But it was easier to fix. As the 2.6.x-series
is giving me all kinds of trouble. The SMP-code was redesigned for 2.6, 
and I havn't been able to confirm if it works or not.
I could have a go at it if someone could give me a small pointer in how to 
get the piggyback_32 utility working with 2.6s System.map.
(looks like "A end" is missing from it)

