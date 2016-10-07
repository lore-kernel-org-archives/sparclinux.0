From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 07 Oct 2016 14:54:16 +0000
Subject: Re: [PATCH 1/2] watchdog: Introduce update_arch_nmi_watchdog
Message-Id: <8ea9198e-1407-12ba-2909-ded6e8ec5eb0@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475792203-230942-1-git-send-email-babu.moger@oracle.com>
 <1475792203-230942-2-git-send-email-babu.moger@oracle.com>
 <20161007043423.GA7263@ravnborg.org>
In-Reply-To: <20161007043423.GA7263@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


On 10/6/2016 11:34 PM, Sam Ravnborg wrote:
> On Thu, Oct 06, 2016 at 03:16:42PM -0700, Babu Moger wrote:
>> Currently we do not have a way to enable/disable arch specific
>> watchdog handlers if it was implemented by any of the architectures.
>>
>> This patch introduces new function update_arch_nmi_watchdog
>> which can be used to enable/disable architecture specific NMI
>> watchdog handlers. Also exposes watchdog_enabled variable outside
>> so that arch specific nmi watchdogs can use it to implement
>> enalbe/disable behavour.
>>
>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>> ---
>>   include/linux/nmi.h |    1 +
>>   kernel/watchdog.c   |   16 +++++++++++++---
>>   2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
>> index 4630eea..01b4830 100644
>> --- a/include/linux/nmi.h
>> +++ b/include/linux/nmi.h
>> @@ -66,6 +66,7 @@ static inline bool trigger_allbutself_cpu_backtrace(void)
>>   
>>   #ifdef CONFIG_LOCKUP_DETECTOR
>>   u64 hw_nmi_get_sample_period(int watchdog_thresh);
>> +extern unsigned long watchdog_enabled;
> The extern is within an #ifdef, but the definition later is
> valid alway.
> So extern definition should be outside the #ifdef to match the
> actual implementation.

      Ok. Sure.

>
> To manipulate / read watchdog_enabled two constants are used:
> NMI_WATCHDOG_ENABLED, SOFT_WATCHDOG_ENABLED

     Sure. I will bring these definitions to nmi.h from watchdog.c

> They should be visible too, so uses do not fall into the trap
> and uses constants (like in patch 2).

     Will re-post v2 version with these changes. Thanks for the comments.

>
> 	Sam

