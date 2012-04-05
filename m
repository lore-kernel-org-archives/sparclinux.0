From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 05 Apr 2012 15:12:52 +0000
Subject: Re: sparc - generic clock event support
Message-Id: <20120405151251.GA18404@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404200704.GA16958@merkur.ravnborg.org>
In-Reply-To: <20120404200704.GA16958@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 05, 2012 at 04:23:08PM +0200, Konrad Eisele wrote:
> Sam Ravnborg wrote:
>> On Thu, Apr 05, 2012 at 08:55:21AM +0200, Konrad Eisele wrote:
>>> Sam Ravnborg wrote:
>>>> I have now finised revising the patch to
>>>> provide support for generic clock event support
>>>> on sparc32.
>>>>
>>>> The main focus has been to extend the core functionality
>>>> (within sparc32) to allow us to share a lot of code between
>>>> leon and the other platfroms.
>>>>
>>>> I have in this process updated a few bits here and there.
>>>> The patch set is build tested for leon, and
>>>> runtime tested on my ss5 (sun4m).
>>>
>>> I'll test it today on Leon.
>>
>> Thanks Konrad!
>> I hope I did not broke it beyond repair :-)
>>
>> 	Sam
>>
>>
>
> I runtime tested your patch. For single-CPU the patch works
> fine. For SMP I cannot test because Leon-SMP for 3.x doesnt
> work right now, also without your patch. The last version
> that I could verify LEON-SMP was 2.6.36, 3.0 should also work,
> however there your patches dont apply. I'll have to make
> Leon-SMP work with 3.4 first , then I can test the SMP part
> of the patch. However I'll write this on my todo list for
> after easter. As for Leon-SMP is broken right now I would
> vote for that your patches are applied now and after that to
> try to fix Leon-SMP.
> -- Konrad
>
> ------ single cpu -------------
> # cd /proc
> # cat cpuinfo
> cpu             : LEON
> fpu             : GRFPU-Lite
> promlib         : Version 0 Revision 0
> prom            : 0.0
> type            : leon
> ncpus probed    : 1
> ncpus active    : 1
> CPU0Bogo        : 201.11
> CPU0ClkTck      : 202000
> MMU type        : LEON
> contexts        : 256
> nocache total   : 3145728
> nocache used    : 114432
> # cat timer_list
> Timer List Version: v0.6
> HRTIMER_MAX_CLOCK_BASES: 3
> now at 21370769625 nsecs
>
> cpu: 0
>  clock 0:
>   .base:       f03c1750
>   .index:      0
>   .resolution: 10000000 nsecs
>   .get_time:   ktime_get
> active timers:
>  clock 1:
>   .base:       f03c1788
>   .index:      1
>   .resolution: 10000000 nsecs
>   .get_time:   ktime_get_real
> active timers:
>  clock 2:
>   .base:       f03c17c0
>   .index:      2
>   .resolution: 10000000 nsecs
>   .get_time:   ktime_get_boottime
> active timers:
>
>
> Tick Device: mode:     0
> Per CPU device: 0
> Clock Event Device: timer_ce
>  max_delta_ns:   0
>  min_delta_ns:   0
>  mult:           4294967
>  shift:          32
>  mode:           2
>  next_event:     2147483646999999999 nsecs
>  set_next_event: <00000000>
>  set_mode:       timer_ce_set_mode
>  event_handler:  tick_handle_periodic
>  retries:        0

Thanks for testing!
I will update the changelog and resend tomorrow (bearing no other comments).

	Sam
