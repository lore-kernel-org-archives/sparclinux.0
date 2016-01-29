From: Wim Coekaerts <wim.coekaerts@oracle.com>
Date: Fri, 29 Jan 2016 17:39:23 +0000
Subject: Re: [PATCH v6] Add sun4v_wdt watchdog driver
Message-Id: <56ABA3CB.4070904@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com> <56AB816B.6030900@oracle.com> <56AB83DA.1020505@roeck-us.net>
In-Reply-To: <56AB83DA.1020505@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

On 01/29/2016 07:23 AM, Guenter Roeck wrote:
> On 01/29/2016 07:12 AM, Stanislav Kholmanskikh wrote:
>>
>>
>> On 01/29/2016 12:46 AM, Wim Coekaerts wrote:
>> <cut>
>>> +static const struct watchdog_info sun4v_wdt_ident = {
>>> +    .options =    WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
>>> +    .identity =    "sun4v hypervisor watchdog",
>>> +    .firmware_version = 0,
>>> +};
>>
>> In accordance to watchdog_ioctl() in drivers/watchdog/watchdog_dev.c 
>> WDIOF_KEEPALIVEPING may be needed here as to enable the support of 
>> WDIOC_KEEPALIVE ioctl.
>>
>> Correct? So maybe add it then?
>>
> Yes. Not having the flag means that the ioctl is not supported,
> and that keepalives have to be implemented using file i/o.
>
> Wim, oversight or on purpose ?
good catch, oversight from moving from the implementation of the old 
_ioctl() in the driver and I didn't have a test for it in my testprogram 
so missed it. Added in and tested it.
