From: Wim Coekaerts <wim.coekaerts@oracle.com>
Date: Wed, 20 Jan 2016 23:37:16 +0000
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <56A01A2C.3020805@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1453321844-27615-1-git-send-email-wim.coekaerts@oracle.com>
 <CAGRGNgX+bKYEvc8toZEf+F9fwTm+TedEu7gtd5YhqNb6LP4eGQ@mail.gmail.com>
In-Reply-To: <CAGRGNgX+bKYEvc8toZEf+F9fwTm+TedEu7gtd5YhqNb6LP4eGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>, davem@davemloft.net
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>



On 1/20/16 2:43 PM, Julian Calaby wrote:
> Hi Wim Coekaerts,
>
> On Thu, Jan 21, 2016 at 7:30 AM,  <wim.coekaerts@oracle.com> wrote:
>> From: Wim Coekaerts <wim.coekaerts@oracle.com>
>>
>> This adds a simple watchdog timer for the SPARC sunv4 architecture.
>> Export the sun4v_mach_set_watchdog() hv call, and add the target.
>>
>> The driver is implemented using the new watchdog api framework.
>>
>> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
> This all looks _much_ better.
>
> There's nothing glaringly wrong with the code like the last version,
> so I've only got a couple of general questions:
>
> 1. Is the platform device and driver necessary? Can't you just
> register the watchdog device directly from sun4v_wdt_init_module()?
>
> 2. If the platform device is unnecessary, do you still need a struct
> watchdog_device in struct sun4v_wdt? I.e. does the watchdog core stop
> watchdogs when you call watchdog_unregister_device()? (Or could you
> refactor to not require it?)
>
> 3. Is it possible to get the data for sun4v_wdt_get_timeleft() by
> calling some other sun4v_mach_*() function?
>
> 4. You still don't use the result returned through the second
> parameter of sun4v_mach_set_watchdog(). Does this number have any
> meaning and would it make sense to store it in ->expires instead of
> calculating it from the timeout?
>
actually one thing we could do:

we could change the sun4v_mach_set_watchdog hv call like below (thanks 
Greg Onufer for this tweak)

diff --git a/arch/sparc/kernel/hvcalls.S b/arch/sparc/kernel/hvcalls.S
index caedf83..b7122a2 100644
--- a/arch/sparc/kernel/hvcalls.S
+++ b/arch/sparc/kernel/hvcalls.S
@@ -338,8 +338,9 @@ ENTRY(sun4v_mach_set_watchdog)
     mov     %o1, %o4
     mov     HV_FAST_MACH_SET_WATCHDOG, %o5
     ta      HV_FAST_TRAP
-    stx     %o1, [%o4]
-    retl
+    brnz,a,pn %o4, 0f
+    stx    %o1, [%o4]
+0:    retl
     nop
  ENDPROC(sun4v_mach_set_watchdog)

and then do  sun4v_mach_set_watchdog(timeout, NULL) instead.

I'd be fine with that if that's preferred.

Dave?




