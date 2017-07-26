From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 20:10:00 +0000
Subject: Re: [PATCH 2/3] sparc64: Add 16GB hugepage support
Message-Id: <20170726.131000.188457155250159722.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1499982815-183450-3-git-send-email-nitin.m.gupta@oracle.com>
        <20170720.130435.1273416665807575517.davem@davemloft.net>
        <d2438f2d-87ca-c09a-1891-ed39f4139089@oracle.com>
In-Reply-To: <d2438f2d-87ca-c09a-1891-ed39f4139089@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, mhocko@suse.com, mingo@kernel.org, akpm@linux-foundation.org, steve.capper@arm.com, hughd@google.com, punit.agrawal@arm.com, bob.picco@oracle.com, pasha.tatashin@oracle.com, steven.sistare@oracle.com, paul.gortmaker@windriver.com, thomas.tai@oracle.com, atish.patra@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 26 Jul 2017 11:35:28 -0700

> 
> 
> On 07/20/2017 01:04 PM, David Miller wrote:
>> From: Nitin Gupta <nitin.m.gupta@oracle.com>
>> Date: Thu, 13 Jul 2017 14:53:24 -0700
>> 
>>> Testing:
>>>
>>> Tested with the stream benchmark which allocates 48G of
>>> arrays backed by 16G hugepages and does RW operation on
>>> them in parallel.
>> 
>> It would be great if we started adding tests under
>> tools/testing/selftests so that other people can recreate
>> your tests/benchmarks.
>> 
> 
> Yes, I would like to add the stream benchmark to selftests too.
> I will check if our internal version of stream can be released.

That would be great.

>> This macro is getting way out of control, every TLB/TSB miss is
>> going to invoke this sequence of code.
>> 
>> Yes, it's just a two cycle constant load, a test modifying the
>> condition codes, and an easy to predict branch.
>> 
>> But every machine will eat this overhead, even if they don't use
>> hugepages or don't set the 16GB knob.
>> 
>> I think we can do better, using code patching or similar.
>> 
>> Once the knob is set, you can know for sure that this code path
>> will never actually be taken.
> 
> The simplest way I can think of is to add CONFIG_SPARC_16GB_HUGEPAGE
> and exclude PUD check if not enabled.  Would this be okay?

I am saying above to do a run-time code patch.

Kconfig knobs are completely pointless in this kind of situation
since every distribution is going to turn the thing on so essentially
all real users eat the overhead if you do it the Kconfig way.

So do a run-time code patch instead, thank you.
