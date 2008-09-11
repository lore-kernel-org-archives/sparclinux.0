From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Thu, 11 Sep 2008 10:04:12 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02 rtcs
Message-Id: <a4423d670809110304k392eba9cuc9a6c48410ed6f5d@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

Is that a different problem?

2.6.27-rc6

$ date
Sat Sep 11 13:55:09 MSK 1976  <<<--

$ dmesg|cut -c 16-|egrep -i "clock|rtc"
clocksource: mult[245d1] shift[16]
clockevent: mult[70a3d70a] shift[32]
device class 'rtc': registering
bus: 'of': add driver clock
bus: 'of': driver_probe_device: matched device f0066438 with driver clock
bus: 'of': really_probe: probing driver clock with device f0066438
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
driver: 'f0066438': driver_bound: bound to device 'clock'
bus: 'of': really_probe: bound device f0066438 to driver clock
Mini RTC Driver
device: 'rtc': device_add
Registering sysdev class 'clocksource'
Registering sys device of class 'clocksource'
Registering sys device 'clocksource0'
bus: 'platform': add driver rtc-m48t59
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

There is a topic in LKML http://lkml.org/lkml/2008/9/10/189
Probably it is related to that topic.
