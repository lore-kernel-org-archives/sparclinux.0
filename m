From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 05 Oct 2016 22:56:16 +0000
Subject: Re: [PATCH v3 1/2] config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc
Message-Id: <95f51c11-8b72-b7d3-03c4-942d42128a7a@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-2-git-send-email-babu.moger@oracle.com>
 <20160928083926.GQ5016@twins.programming.kicks-ass.net>
 <c4035ddb-effb-f9ef-9110-aef0703276cd@oracle.com>
 <20160930.011915.39029193323355575.davem@davemloft.net>
In-Reply-To: <20160930.011915.39029193323355575.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, sam@ravnborg.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Dave, Gentle reminder to review this patch. Thanks

On 9/30/2016 12:19 AM, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Thu, 29 Sep 2016 08:53:24 -0500
>
>> On 9/28/2016 3:39 AM, Peter Zijlstra wrote:
>>> On Tue, Sep 27, 2016 at 12:33:27PM -0700, Babu Moger wrote:
>>>> This new config parameter limits the space used for "Lock debugging:
>>>> prove locking correctness" by about 4MB. The current sparc systems
>>>> have
>>>> the limitation of 32MB size for kernel size including .text, .data and
>>>> .bss sections. With PROVE_LOCKING feature, the kernel size could grow
>>>> beyond this limit and causing system boot-up issues. With this option,
>>>> kernel limits the size of the entries of lock_chains, stack_trace
>>>> etc.,
>>>> so that kernel fits in required size limit. This is not visible to
>>>> user
>>>> and only used for sparc.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>>> You forgot to Cc Dave, and since you're touching sparc I need an Ack
>>> from him before I can queue this.
>> Dave, Can you please take a look at the patch. Please ack it if it
>> looks good.
> I am travelling and will look at it when I get a chance.

