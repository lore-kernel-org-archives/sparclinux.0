From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 21 Oct 2016 21:50:21 +0000
Subject: Re: [PATCH v2 1/2] watchdog: Introduce arch_watchdog_nmi_enable and arch_watchdog_nmi_disable
Message-Id: <8898d56a-3344-f37f-2697-ce327323042c@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1476391082-77928-1-git-send-email-babu.moger@oracle.com>
 <1476391082-77928-2-git-send-email-babu.moger@oracle.com>
 <20161019170012.6006d06d9326e62a8059fd08@linux-foundation.org>
 <20161020161414.GE35881@redhat.com>
 <20161020202527.b01839356c6d34ed0cba3569@linux-foundation.org>
 <20161021151114.GC35881@redhat.com>
 <20161021121914.b7e541782dc18868c87de068@linux-foundation.org>
In-Reply-To: <20161021121914.b7e541782dc18868c87de068@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Don Zickus <dzickus@redhat.com>
Cc: mingo@kernel.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

Don,

On 10/21/2016 2:19 PM, Andrew Morton wrote:
> On Fri, 21 Oct 2016 11:11:14 -0400 Don Zickus <dzickus@redhat.com> wrote:
>
>> On Thu, Oct 20, 2016 at 08:25:27PM -0700, Andrew Morton wrote:
>>> On Thu, 20 Oct 2016 12:14:14 -0400 Don Zickus <dzickus@redhat.com> wrote:
>>>
>>>>>> -static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
>>>>>> -static void watchdog_nmi_disable(unsigned int cpu) { return; }
>>>>>> +/*
>>>>>> + * These two functions are mostly architecture specific
>>>>>> + * defining them as weak here.
>>>>>> + */
>>>>>> +int __weak arch_watchdog_nmi_enable(unsigned int cpu) { return 0; }
>>>>>> +void __weak arch_watchdog_nmi_disable(unsigned int cpu) { return; }
>>>>>> +
>>>>>>   #endif /* CONFIG_HARDLOCKUP_DETECTOR */
>>>>> This is a strange way of using __weak.
>>>>>
>>>>> Take a look at (one of many examples) kernel/module.c:module_alloc().
>>>>> We simply provide a default implementation and some other compilation
>>>>> unit can override (actually replace) that at link time.  No strange
>>>>> ifdeffing needed.
>>>> Yeah, this is mostly because of how we enable the hardlockup detector.
>>>>
>>>> Some arches use the perf hw and enable CONFIG_HARDLOCKUP_DETECTOR.  Other
>>>> arches just use their own variant of nmi and set CONFIG_HAVE_NMI_WATCHDOG and
>>>> the rest of the arches do not use this.
>>>>
>>>> So the thought was if CONFIG_HARDLOCKUP_DETECTOR use that implementation,
>>>> everyone else use the __weak version.  Then the arches like sparc can override
>>>> the weak version with their own nmi enablement.
>>>>
>>>> I don't know how to represent those 3 states correctly and the above is what
>>>> we end up with.
>>> <head spins>
>>>
>>> Is there a suitable site where we could capture these considerations in
>>> a code comment?
>> Hi Andrew,
>>
>> I am not sure I understand your question.  When you say 'site', are you
>> referring to the kernel/watchdog.c file?
> Yes, somewhere in there I guess.
>
> The problem with this sort of thing is that the implementation is
> splattered over multiple places in one file or in several files so
> there's no clear place to document what's happening.  But I think this
> situation *should* be documented somewhere.  Or maybe that just isn't
> worthwhile - feel free to disagree!
>
>> The other approach that might help de-clutter this file, is to pull out the
>> HARDLOCKUP_DETECTOR changes (as they are arch specific) and move it to say
>> kernel/watchdog_hw_ld.c.  Then all the nmi hooks in kernel/watchdog.c can be
>> __weak and overridden by the kernel_watchdog_hw_ld.c file or the sparc
>> files.
>>
>> This would leave kernel/watchdog.c with just a framework and the
>> arch-agnostic softlockup detector.  Probably easier to read and digest.

Don, Yes. I am fine with your idea.  Let me know if you need any help 
here.  If you want I can
start working this cleanup myself. I might take sometime as I need to 
spend sometime
understanding the whole watchdog stuff first. If you have already 
started working on this
then I will let you continue.

> Well, it depends how the code ends up looking.  It's best to separate
> functional changes from cleanups.  Generally I think it's best to do
> "cleanup comes first", because it's then simpler to revert the
> functional change if it has problems.  Plus people are more
> *interested* in the functional change so it's best to have that at
> top-of-tree.
>

