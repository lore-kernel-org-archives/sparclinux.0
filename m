From: Robert Reif <reif@earthlink.net>
Date: Mon, 08 Sep 2008 03:50:19 +0000
Subject: Re: [PATHC 0/2] sparc32: convert to RTC subsystem
Message-Id: <48C4A0FB.8000600@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
In-Reply-To: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Robert Reif wrote:
> Krzysztof Helt wrote:
>> Robert, please test it on as many machine as you can.
>>
>>   
> With latest sparc-next, my ss20 boots now but the clock is suspect.
I also get this error:

Dec 31 19:01:25 ss20-1 kernel: rtc-m48t59 rtc-m48t59.0: rtc core: 
registered m48t08 as rtc0
Dec 31 19:01:25 ss20-1 kernel: TCP bic registered
Dec 31 19:01:25 ss20-1 kernel: NET: Registered protocol family 17
Dec 31 19:01:25 ss20-1 kernel: drivers/rtc/hctosys.c: unable to open rtc 
device (y)

