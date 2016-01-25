From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 25 Jan 2016 21:15:08 +0000
Subject: Re: [PATCH v3] Add sun4v_wdt watchdog driver
Message-Id: <56A6905C.4070106@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1453754288-30997-1-git-send-email-wim.coekaerts@oracle.com>
 <56A68D5F.40406@roeck-us.net> <56A68F1B.80605@oracle.com>
In-Reply-To: <56A68F1B.80605@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Coekaerts <wim.coekaerts@oracle.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

On 01/25/2016 01:09 PM, Wim Coekaerts wrote:
> On 01/25/2016 01:02 PM, Guenter Roeck wrote:
>> On 01/25/2016 12:38 PM, Wim Coekaerts wrote:
>>> This driver adds sparc hypervisor watchdog support. Timeout is set in
>>> milliseconds since that is the granularity supported and it honors
>>> the settings of both the watchdog-resolution and watchdog-max-timeout
>>> MD properties.
>>>
>>> Default timeout is set at 60 seconds or 60000ms. The range is between
>>> 1 second and 180 seconds. The default resolution is 1000ms.
>>>
>>> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
>>> ---
>>> Changes in v3:
>>>    - Modify sun4v_mach_set_watchdog to allow for NULL and remove
>>>     time_remaining
>>>    - Cleanup includes
>>>    - Consolidate _start and _ping into _ping since they were the same
>>>    - Fix checkpatch warnings
>>>    - Remove pr_info()s
>>>    - Clean up return codes to be standard kernel return values
>>>    - Consolidate _init and _probe into _init
>>>     Don't use platform_device anymore because this is really
>>>     just a driver that depends on a hv call. This now looks more
>>>     like softdog.
>>>    - Cleanly check for sun4v architecture and remove extra tests
>>>    - Convert to ms timer support and honor resolution
>>>     since most drivers use seconds I added _ms to make it clear
>>
>> You can not redefine the watchdog ABI to mean milli-seconds instead of seconds.
>
> ugh ok. Then it makes honoring resolutions a bit useless (comment on
> previous patch about having a fixed 1s resolution)
>

Why ? You can still round the resolution to seconds, and use the milli-second
resolution internally while keeping the ABI stable. Many other drivers have a
hardware watchdog resolution which differs from 1 second.

Guenter

