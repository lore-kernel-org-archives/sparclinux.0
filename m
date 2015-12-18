From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 18 Dec 2015 17:00:16 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <56743BA0.1030409@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
 <5673DD60.7080302@linaro.org> <20151218145207.GK3729@pathway.suse.cz>
In-Reply-To: <20151218145207.GK3729@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 18/12/15 14:52, Petr Mladek wrote:
> On Fri 2015-12-18 10:18:08, Daniel Thompson wrote:
>> On 11/12/15 23:26, Jiri Kosina wrote:
>>> On Fri, 11 Dec 2015, Russell King - ARM Linux wrote:
>>>
>>>> I'm personally happy with the existing code, and I've been wondering why
>>>> there's this effort to apply further cleanups - to me, the changelogs
>>>> don't seem to make that much sense, unless we want to start using
>>>> printk() extensively in NMI functions - using the generic nmi backtrace
>>>> code surely gets us something that works across all architectures...
>>>
>>> It is already being used extensively, and not only for all-CPU backtraces.
>>> For starters, please consider
>>>
>>> - WARN_ON(in_nmi())
>>> - BUG_ON(in_nmi())
>>
>> Sorry to join in so late but...
>>
>> Today we risk deadlock when we try to issue these diagnostic errors
>> directly from NMI context.
>>
>> After this change we will still risk deadlock, because that's what
>> the diagnostic code is trying to tell us, *and* we delay actually
>> reporting the error until, and only if, the NMI handler completes.
>
> I think that NMI messages about a possible deadlock are the ones
> from
>
>      kernel/locking/rtmutex.c
>      kernel/irq_work.c
>      include/linux/hardirq.h
>
> You are right that if the deadlock happens, this patch set lowers the
> chance to see the message.
>
> On the other hand, all the other printk's in NMI seems to be non-fatal
> warnings. In this case, this patch set increases the chance to see
> them.

Maybe for a WARN_ON() the trade off is worth it but I don't think a 
BUG_ON() trace would ever make it out.


> A compromise might be to explicitly call printk_nmi_flush() in the few
> fatal cases. Alternatively we could force the messages on the
> early_console when available.
>
>
>>> - anything being printed out from MCE handlers
>>
>> The MCE handlers should only call printk() when they decide to panic
>> and *after* busting the spinlocks. At this point deferring printk()
>> until it is safe is not very helpful.
>>
>> When we bust the spinlocks we should probably restore the normal
>> printk() function to give best chance of the failure messages making
>> it out.
>
> The problem is that we do not know what locks need to be busted. There
> are too many consoles and too many locks involved. Also busting locks
> open another can of worms.

Yes, I agree that busting the spinlocks doesn't avoid all risk of deadlock.

Probably I've been placing too much weight on the importance of getting 
messages out when dying. You're right that surviving far enough through 
a panic to trigger kdump or reset is equally (or more) important in many 
scenarios than getting a failure message out.

However on a system with nothing but "while(1) {}" hooked up to panic() 
then its worth risking a lock up. In this case restoring normal printk() 
behavior and dumping the NMI buffers would be worthwhile.


Daniel.
