From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sat, 13 Sep 2008 10:33:14 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20080913123314.bc13f0bf.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 11 Sep 2008 14:04:12 +0400
"Alexander Beregalov" <a.beregalov@gmail.com> wrote:

> Hi
> 
> Is that a different problem?
> 
> 2.6.27-rc6
> 

What kernel version have you used?
If it was plain 2.6.27-rc6 there was no rtc layer support yet. Please try the linux-next.

> $ date
> Sat Sep 11 13:55:09 MSK 1976  <<<--
> 
> $ dmesg|cut -c 16-|egrep -i "clock|rtc"
> clocksource: mult[245d1] shift[16]
> clockevent: mult[70a3d70a] shift[32]
> device class 'rtc': registering
> bus: 'of': add driver clock
> bus: 'of': driver_probe_device: matched device f0066438 with driver clock
> bus: 'of': really_probe: probing driver clock with device f0066438
> /pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
> driver: 'f0066438': driver_bound: bound to device 'clock'
> bus: 'of': really_probe: bound device f0066438 to driver clock
> Mini RTC Driver

^^^ MiniRTC should be gone (or at least disabled) if you try to use the rtc layer (if you applied patches).

> device: 'rtc': device_add
> Registering sysdev class 'clocksource'
> Registering sys device of class 'clocksource'
> Registering sys device 'clocksource0'
> bus: 'platform': add driver rtc-m48t59
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> 
> There is a topic in LKML http://lkml.org/lkml/2008/9/10/189
> Probably it is related to that topic.
> 

Regards,
Krzysztof

----------------------------------------------------------------------
Wygraj SUZUKI GRAND VITARA 4x4 - TYSIACE CENNYCH NAGROD czekaja 
wejdz na www.variant.pl 
GRAJ i WYGRYWAJ - Codziennie 100 nagrod !!!


