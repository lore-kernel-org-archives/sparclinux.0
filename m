From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 20 Jan 2016 23:40:04 +0000
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <CAGRGNgX2XMroAnrmH2s1pk-Rgg_jD=YfuYK_R3H5vGscBjCs2w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1453321844-27615-1-git-send-email-wim.coekaerts@oracle.com>
 <CAGRGNgX+bKYEvc8toZEf+F9fwTm+TedEu7gtd5YhqNb6LP4eGQ@mail.gmail.com> <56A01612.9040901@oracle.com>
In-Reply-To: <56A01612.9040901@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

Hi Wim,

On Thu, Jan 21, 2016 at 10:19 AM, Wim Coekaerts
<wim.coekaerts@oracle.com> wrote:
> On 01/20/2016 02:43 PM, Julian Calaby wrote:
>>
>> Hi Wim Coekaerts,
>>
>> On Thu, Jan 21, 2016 at 7:30 AM,  <wim.coekaerts@oracle.com> wrote:
>>>
>>> From: Wim Coekaerts <wim.coekaerts@oracle.com>
>>>
>>> This adds a simple watchdog timer for the SPARC sunv4 architecture.
>>> Export the sun4v_mach_set_watchdog() hv call, and add the target.
>>>
>>> The driver is implemented using the new watchdog api framework.
>>>
>>> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
>>
>> This all looks _much_ better.
>
> thanks! :)
>>
>> There's nothing glaringly wrong with the code like the last version,
>> so I've only got a couple of general questions:
>>
>> 1. Is the platform device and driver necessary? Can't you just
>> register the watchdog device directly from sun4v_wdt_init_module()?
>>
>> 2. If the platform device is unnecessary, do you still need a struct
>> watchdog_device in struct sun4v_wdt? I.e. does the watchdog core stop
>> watchdogs when you call watchdog_unregister_device()? (Or could you
>> refactor to not require it?)
>
> I like to be able to implement support for suspend/resume for ldoms
> as we add more support for that in the future, and support for migrating
> domains and such. So having a platform driver is useful to here as a
> framework.

So I'm guessing the watchdog core doesn't handle suspend/resume and
the hypervisor doesn't detect / account for this when running it's end
of the watchdog.

I'm sure that suspend / resume support could be hacked together, but
at that point it's probably going to be cleaner to just use a platform
device and driver as you've done.

As for migrating domains, does anything need to happen other than
fixing the parameters to account for new resolutions and maximums and
restarting the watchdog if needed?

(Also, I'm guessing that the resolution is the number of watchdog
units per second, so surely using it would be as easy as replacing the
"1000"s in _start(), _ping() and _init_module() with that parameter?
I'm also guessing that it not being 1000 is exceptionally rare.)

>> 3. Is it possible to get the data for sun4v_wdt_get_timeleft() by
>> calling some other sun4v_mach_*() function?
>
> No there is only one hv call for watchdog and that's this one.
>
> time_remaining is the time that was left until the timer was going
> to expire when making the call so it's not useful for the future time.

I'm guessing that time_remaining is always less than or equal to the
timeout set, therefore instead of calculating expires from the
timeout, you could potentially calculate it from time_remaining. This
would account for the case where the hypervisor takes ages to set the
timeout. That said, I'd be shocked if this actually improved things in
any meaningful way as I'm sure there's some slop built in elsewhere to
account for exactly this problem.

> And you can't just make a call to get time_remaining except to reset
> the timer or disable it along with it. quantum physics timer :)

To be honest, I'm not at all surprised by this. =)

> I am not quite sure what the point was of that return value to be
> honest but it's not really used, as far as I know also not used on Solaris.
>
>> 4. You still don't use the result returned through the second
>> parameter of sun4v_mach_set_watchdog(). Does this number have any
>> meaning and would it make sense to store it in ->expires instead of
>> calculating it from the timeout?
>
> see above. not terribly pretty but it does work and seems pretty benign
> with the latest patch, I hope

Fair enough!

> thanks again for the review!

No problem!

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
