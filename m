From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Sep 2013 07:27:37 +0000
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains for CPUs?
Message-Id: <CANqRtoQF8-W=EFcV+LEPGbJf=h_yfyjVg=+0F5Sif15jB8XjBg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
 <CANqRtoTSO2yyP35naDe4y6a7rL99=cSs4-bJAWOxR5HL2gbpuw@mail.gmail.com>
 <CAKohpom06N4DNZxrQcey-73o1jpQkNpCce2=-Wn+mDHLG9r-3g@mail.gmail.com>
In-Reply-To: <CAKohpom06N4DNZxrQcey-73o1jpQkNpCce2=-Wn+mDHLG9r-3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Viresh,

On Fri, Aug 30, 2013 at 4:33 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 30 August 2013 12:18, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Hi Viresh,
>>
>> On Thu, Aug 29, 2013 at 7:15 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> Hi,
>>>
>>> I have been doing some CPUFreq cleanup work and
>>> wanted to know if the below mentioned machines have separate
>>> clock domains for their CPUs or all share the same domain?
>>>
>>> So, that we can use some generic routines for these drivers which
>>> would eventually do:
>>>
>>> cpumask_setall(policy->cpus);
>>>
>>> And I wanted to make sure that this doesn't break them.. :)
>>>
>>> ......
>>>
>>> The drivers are:
>> ...
>>> drivers/cpufreq/sh-cpufreq.c
>> ...
>>
>> The above SH cpufreq driver seems to be written with SMP in mind, but
>> I would say SMP is a very rare case for SH. So I believe it can be
>> considered as UP-only at this point. If Paul disagrees I'm quite sure
>> he will tell us.
>
> Okay.. The problem isn't really SMP but different clock domains for CPUs
> in a SMP system..
>
> So, even if we have a SMP SH machine, will it have same clock line for
> all CPUs?

Yeah, I understand your question but I'm afraid that I don't know the
answer myself.

> I will go with the change anyway..

Good plan. Thanks for cleaning up the cpufreq bits.

Cheers,

/ magnus
