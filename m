From: Alexandre Chartre <alexandre.chartre@oracle.com>
Date: Thu, 22 Dec 2016 08:26:27 +0000
Subject: Re: [PATCH] sparc64: shut down to OBP correctly
Message-Id: <01ff422a-5e7a-30d3-510a-bdea90788c67@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1482340333-65764-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1482340333-65764-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On 12/21/2016 09:15 PM, David Miller wrote:
> From: Larry Bassel <larry.bassel@oracle.com>
> Date: Wed, 21 Dec 2016 11:44:07 -0800
>
>> On 21 Dec 16 14:06, David Miller wrote:
>>> From: Larry Bassel <larry.bassel@oracle.com>
>>> Date: Wed, 21 Dec 2016 10:51:33 -0800
>>>
>>>> On 21 Dec 16 13:07, David Miller wrote:
>>>>> From: Larry Bassel <larry.bassel@oracle.com>
>>>>> Date: Wed, 21 Dec 2016 09:12:13 -0800
>>>>>
>>>>>> Orabug: 24789774
>>>>>>
>>>>>> The command "shutdown -h -H now" should shut down the system to
>>>>>> OBP, however the machine was incorrectly being powered off instead
>>>>>> (on both LDOM and bare metal).
>>>>>>
>>>>>> The "exit" command to the OBP must be run and then a hard
>>>>>> loop to prevent return to the kernel.
>>>>>>
>>>>>> Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
>>>>>
>>>>> On LDOM, once you boot past the early stages of the kernel, OBP is
>>>>> considered volatile and thus unusable.
>>>>
>>>> My code does work on an 4.9.0 LDOM (we get to the ok prompt). So you're saying
>>>> this was a "lucky accident" and there is no "clean" way of getting back to
>>>> the OBP when we are in a LDOM (i.e. all we can do is power off which is
>>>> what the current code does)?
>>>
>>> Yes, for a very long time the firmware/hypervisor engineers told me
>>> exactly this.
>>>
>>>> Unfortunately, the variable "ldom_domaining_enabled" is 1 even when
>>>> we are not in an LDOM (I just double checked this by printing
>>>> the value out as we shut down) and so the current code will power off in
>>>> the bare metal case as well. Is there is a good way of determining that
>>>> we are running on bare metal?
>>>
>>> Even for bare metal the condition holds.  As long as we use the interfaces
>>> guarded by ldom_domaining_enabled, the OBP is not reliably available after
>>> early boot.
>>
>> I'm not sure I understand this comment -- are you saying that if we are
>> bare metal (and somehow can know this), one still cannot call into the OBP?
>> There are other calls to the OBP (p1275_cmd_direct) in prom/misc_64.c, some
>> of which are not conditional on ldom_domaining_enabled (which means they
>> would be called even in the LDOM case).
>
> We have to unconditionally allow p1275_cmd_direct() for certain earlier
> boot calls.
>
> The problem, I was told, is that when you boot cpus into the machine using
> the LDOM cpu start hypercall, you can't use OBP.
>
> This is why we pull the entire device tree from OBP into the kernel on
> the boot processer very early in the boot.  That way we don't need to
> make OBP calls once we start booting up the non-boot cpus.


That's correct. The problem is that the OBP won't be aware of any configuration
change in the domain (like adding/removing cpu, memory or devices) and the OBP
won't update its device tree. So if you return to the OBP, the behavior is
unpredictable because the OBP might have outdated information.

For example, on Solaris, a shutdown/halt command won't directly return to the
OBP. Instead, it will reset the domain and stop at the OBP ok prompt after the
domain has been reset. This is done by setting the OBP reboot-command to "noop"
(to prevent an auto-boot after the reset) and then resetting the domain with
HV_MACH_SIR.


alex.
