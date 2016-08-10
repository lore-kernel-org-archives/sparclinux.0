From: David Long <dave.long@linaro.org>
Date: Wed, 10 Aug 2016 20:41:58 +0000
Subject: Re: [PATCH v15 04/10] arm64: Kprobes with single stepping support
Message-Id: <57AB9196.1080005@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <57969234.1070201@linaro.org>
 <22b277ba-6812-a0dd-9e8e-c29bdb3aa672@linaro.org>
 <57993211.1040600@linaro.org>
 <20160728144053.GA26510@e104818-lin.cambridge.arm.com>
 <360d582b-5401-7126-ef40-bd78369c0a34@linaro.org>
 <57A2C8DF.7050401@linaro.org>
 <74b8c503-b6df-dcb1-c278-d49850fe3715@linaro.org> <57A89731.20709@linaro.org>
 <20160809172308.GD15447@e104818-lin.cambridge.arm.com>
In-Reply-To: <20160809172308.GD15447@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/09/2016 01:23 PM, Catalin Marinas wrote:
> On Mon, Aug 08, 2016 at 10:29:05AM -0400, David Long wrote:
>> On 08/08/2016 07:13 AM, Daniel Thompson wrote:
>>> On 04/08/16 05:47, David Long wrote:
>>> >From b451caa1adaf1d03e08a44b5dad3fca31cebd97a Mon Sep 17 00:00:00 2001
>>>> From: "David A. Long" <dave.long@linaro.org>
>>>> Date: Thu, 4 Aug 2016 00:35:33 -0400
>>>> Subject: [PATCH] arm64: Remove stack duplicating code from jprobes
>>>>
>>>> Because the arm64 calling standard allows stacked function arguments
>>>> to be
>>>> anywhere in the stack frame, do not attempt to duplicate the stack
>>>> frame for
>>>> jprobes handler functions.
>>>>
>>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>>> ---
>>>> Documentation/kprobes.txt          |  7 +++++++
>>>> arch/arm64/include/asm/kprobes.h   |  2 --
>>>> arch/arm64/kernel/probes/kprobes.c | 31 +++++--------------------------
>>>> 3 files changed, 12 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
>>>> index 1f9b3e2..bd01839 100644
>>>> --- a/Documentation/kprobes.txt
>>>> +++ b/Documentation/kprobes.txt
>>>> @@ -103,6 +103,13 @@ Note that the probed function's args may be
>>>> passed on the stack
>>>> or in registers.  The jprobe will work in either case, so long as the
>>>> handler's prototype matches that of the probed function.
>>>>
>>>> +Note that in some architectures (e.g.: arm64) the stack copy is not
>>>
>>> Could sparc64 be added to this list?
>>>
>>>    For the sparc folks who are new to the thread, we've previously
>>>    established that the sparc64 ABI passes large structures by
>>>    allocating them from the caller's stack frame and passing a pointer
>>>    to the stack frame (i.e. arguments may not be at top of the stack).
>>>    We also noticed that sparc code does not save/restore anything from
>>>    the stack.
>>
>> I was reluctant to do that in the context of late changes to v4.8 for arm64
>> but now that any changes for this are going in as a new patch it would
>> indeed be useful to get involvement from sparc maintainers.
>
> I'm happy to take the arm64 patch for 4.8 as it's mainly a clean-up.
> Whether you can mention sparc64 as well, it depends on the sparc
> maintainers. You can either cc them or send the series as two patches,
> one for documentation and the other for arm64.
>

I didn't think that was going to be possible after v4.8-rc1.  I have 
separated the documentation and code changes.  I will send out the new 
code-only patch (otherwise unchanged in content) momentarily.

Thanks,
-dl

