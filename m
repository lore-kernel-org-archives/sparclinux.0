From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 21 Jan 2016 02:23:10 +0000
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <CAGRGNgXPfeSpwk3jS1m55qFDzjfHu=tZb7LsEbgCyKw9W-UmNQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1453321844-27615-1-git-send-email-wim.coekaerts@oracle.com>
 <CAGRGNgX+bKYEvc8toZEf+F9fwTm+TedEu7gtd5YhqNb6LP4eGQ@mail.gmail.com>
 <56A01612.9040901@oracle.com> <20160120234554.GA21708@roeck-us.net> <56A035D7.5030406@oracle.com>
In-Reply-To: <56A035D7.5030406@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

Hi Wim,

On Thu, Jan 21, 2016 at 12:35 PM, Wim Coekaerts
<wim.coekaerts@oracle.com> wrote:
>
>
> On 1/20/16 3:45 PM, Guenter Roeck wrote:
>>
>> On Wed, Jan 20, 2016 at 03:19:46PM -0800, Wim Coekaerts wrote:
>>>
>>> On 01/20/2016 02:43 PM, Julian Calaby wrote:
>>>>
>>>> Hi Wim Coekaerts,
>>>>
>>>> On Thu, Jan 21, 2016 at 7:30 AM,  <wim.coekaerts@oracle.com> wrote:
>>>>>
>>>>> From: Wim Coekaerts <wim.coekaerts@oracle.com>
>>>>>
>>>>> This adds a simple watchdog timer for the SPARC sunv4 architecture.
>>>>> Export the sun4v_mach_set_watchdog() hv call, and add the target.
>>>>>
>>>>> The driver is implemented using the new watchdog api framework.
>>>>>
>>>>> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
>>>>
>>>> This all looks _much_ better.
>>>
>>> thanks! :)
>>>>
>>>> There's nothing glaringly wrong with the code like the last version,
>>>> so I've only got a couple of general questions:
>>>>
>>>> 1. Is the platform device and driver necessary? Can't you just
>>>> register the watchdog device directly from sun4v_wdt_init_module()?
>>>>
>>>> 2. If the platform device is unnecessary, do you still need a struct
>>>> watchdog_device in struct sun4v_wdt? I.e. does the watchdog core stop
>>>> watchdogs when you call watchdog_unregister_device()? (Or could you
>>>> refactor to not require it?)
>>>
>>> I like to be able to implement support for suspend/resume for ldoms
>>> as we add more support for that in the future, and support for migrating
>>> domains and such. So having a platform driver is useful to here as a
>>> framework.
>>>
>>>> 3. Is it possible to get the data for sun4v_wdt_get_timeleft() by
>>>> calling some other sun4v_mach_*() function?
>>>
>>> No there is only one hv call for watchdog and that's this one.
>>>
>>> time_remaining is the time that was left until the timer was going
>>> to expire when making the call so it's not useful for the future time.
>>>
>>> And you can't just make a call to get time_remaining except to reset
>>> the timer or disable it along with it. quantum physics timer :)
>>>
>> I'll comment on the rest of the driver separately. However, since
>> get_timeleft()
>> was brought up - the idea here is to report the time left as reported from
>> the
>> hardware, not the time left calculated by software. If we want to
>> calculate
>> the time left until expiry in software, it should be done in the watchdog
>> core.
>> It should not be done in drivers.
>>
> I guess you could add a soft_get_timeleft() so that it's clear that if a
> driver doesn't
> implement the call, you get a best effort response.
>
> Happy to remove the op from the driver and maybe we can implement it
> separately in core in a separate patch if that's of interest.
>
> However, this makes me ponder what could be done with the "time_remaining"
> behavior on sun4v. It could be useful for a piece of software to use that
> value
> to see the drift. "I pinged 30 seconds ago, per my assumption of time but
> the
> timer says it was 50 seconds ago, something is wrong".
>
> What if I would report back time_remaining like that,  but of course now
> that it's
> pinged again it reset the timer. Not sure whether you can see any use of
> such
> behavior. It wouldn't be get_timeleft() but more  get_timewasleft() ;) or
> it could be a positive return from _ping...  just noodling

How about _start() and _ping() set wdt->expires like this:

err = sun4v_mach_set_watchdog(wdd->timeout * 1000, &time_remaining);
wdt->expires = ktime_to_timespec(ktime_get()).tv_sec + time_remaining / 1000;

Then _timeleft() could be something like:

return wdt->expires - ktime_to_timespec(ktime_get()).tv_sec;

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
