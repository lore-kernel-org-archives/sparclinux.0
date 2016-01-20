From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Jan 2016 23:45:54 +0000
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <20160120234554.GA21708@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1453321844-27615-1-git-send-email-wim.coekaerts@oracle.com>
 <CAGRGNgX+bKYEvc8toZEf+F9fwTm+TedEu7gtd5YhqNb6LP4eGQ@mail.gmail.com>
 <56A01612.9040901@oracle.com>
In-Reply-To: <56A01612.9040901@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: Julian Calaby <julian.calaby@gmail.com>, wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

On Wed, Jan 20, 2016 at 03:19:46PM -0800, Wim Coekaerts wrote:
> On 01/20/2016 02:43 PM, Julian Calaby wrote:
> >Hi Wim Coekaerts,
> >
> >On Thu, Jan 21, 2016 at 7:30 AM,  <wim.coekaerts@oracle.com> wrote:
> >>From: Wim Coekaerts <wim.coekaerts@oracle.com>
> >>
> >>This adds a simple watchdog timer for the SPARC sunv4 architecture.
> >>Export the sun4v_mach_set_watchdog() hv call, and add the target.
> >>
> >>The driver is implemented using the new watchdog api framework.
> >>
> >>Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
> >This all looks _much_ better.
> thanks! :)
> >There's nothing glaringly wrong with the code like the last version,
> >so I've only got a couple of general questions:
> >
> >1. Is the platform device and driver necessary? Can't you just
> >register the watchdog device directly from sun4v_wdt_init_module()?
> >
> >2. If the platform device is unnecessary, do you still need a struct
> >watchdog_device in struct sun4v_wdt? I.e. does the watchdog core stop
> >watchdogs when you call watchdog_unregister_device()? (Or could you
> >refactor to not require it?)
> I like to be able to implement support for suspend/resume for ldoms
> as we add more support for that in the future, and support for migrating
> domains and such. So having a platform driver is useful to here as a
> framework.
> 
> >3. Is it possible to get the data for sun4v_wdt_get_timeleft() by
> >calling some other sun4v_mach_*() function?
> No there is only one hv call for watchdog and that's this one.
> 
> time_remaining is the time that was left until the timer was going
> to expire when making the call so it's not useful for the future time.
> 
> And you can't just make a call to get time_remaining except to reset
> the timer or disable it along with it. quantum physics timer :)
> 

I'll comment on the rest of the driver separately. However, since get_timeleft()
was brought up - the idea here is to report the time left as reported from the
hardware, not the time left calculated by software. If we want to calculate
the time left until expiry in software, it should be done in the watchdog core.
It should not be done in drivers.

Thanks,
Guenter
