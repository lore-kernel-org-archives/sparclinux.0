From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 07 Feb 2018 16:18:17 +0000
Subject: Re: [PATCH net-next] sun: Add SPDX license tags to Sun network drivers
Message-Id: <79874511-6601-fdfe-d11d-b1a2d0d14180@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1517945663-3214-1-git-send-email-shannon.nelson@oracle.com>
 <CAGRGNgXc+GLXmTBVcj-PiZ2MRtUF3HvaZ7a4zgQux0yzEqpLdw@mail.gmail.com>
In-Reply-To: <CAGRGNgXc+GLXmTBVcj-PiZ2MRtUF3HvaZ7a4zgQux0yzEqpLdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>

On 2/7/2018 3:59 AM, Julian Calaby wrote:
> Hi Shannon,
> 
> On Wed, Feb 7, 2018 at 6:34 AM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> Add the appropriate SPDX license tags to the Sun network drivers
>> as outlined in Documentation/process/license-rules.rst.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>> ---
>>   drivers/net/ethernet/sun/Kconfig          | 1 +
>>   drivers/net/ethernet/sun/cassini.c        | 1 +
>>   drivers/net/ethernet/sun/cassini.h        | 1 +
>>   drivers/net/ethernet/sun/ldmvsw.c         | 1 +
>>   drivers/net/ethernet/sun/niu.c            | 1 +
>>   drivers/net/ethernet/sun/sunbmac.c        | 1 +
>>   drivers/net/ethernet/sun/sungem.c         | 1 +
>>   drivers/net/ethernet/sun/sunhme.c         | 1 +
>>   drivers/net/ethernet/sun/sunqe.c          | 1 +
>>   drivers/net/ethernet/sun/sunvnet.c        | 1 +
>>   drivers/net/ethernet/sun/sunvnet_common.c | 1 +
>>   11 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sun/Kconfig b/drivers/net/ethernet/sun/Kconfig
>> index b2caf51..7b982e0 100644
>> --- a/drivers/net/ethernet/sun/Kconfig
>> +++ b/drivers/net/ethernet/sun/Kconfig
>> @@ -1,3 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0
>>   #
>>   # Sun network device configuration
>>   #
> 
> I'm not sure that Kconfig files count as source, right?

My read of license-rules.rst and the existing examples such as 
./Kconfig, ./drivers/Kconfig, and many others, suggest this is a correct 
patch.

> 
>> diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
>> index 113bd57..9020b08 100644
>> --- a/drivers/net/ethernet/sun/cassini.c
>> +++ b/drivers/net/ethernet/sun/cassini.c
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>   /* cassini.c: Sun Microsystems Cassini(+) ethernet driver.
>>    *
>>    * Copyright (C) 2004 Sun Microsystems Inc.
> 
> I understand that this is the specified way to do this, but it's
> exceptionally ugly.
> 
> Also, shouldn't the SPDX line _replace_ the usual "this program is
> free software" license paragraphs? My understanding is that the SPDX
> line is functionally equivalent to having the terms spelled out.

Yes, the SPDX line is intended to suffice as the licensing in those 
files where there is no other licensing statement.  Where there already 
is a statement of some sort, I'm following the wisdom and example of 
those who've been working on this before me: if GregKH and others are 
happy with adding one line and leaving the rest, I'm happy with it.

sln

> 
> Thanks,
> 
