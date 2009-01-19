From: Meelis Roos <mroos@linux.ee>
Date: Mon, 19 Jan 2009 07:49:54 +0000
Subject: Re: fhc led registration warnings
Message-Id: <Pine.SOC.4.64.0901190947320.25132@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Does this patch fix the problem?
> 
> sparc64: Initialize FHC/CLOCK LED platform_device 'id' field correctly.

Yes, than you very much!

[  135.931836] fhc: Board #1, Version[1] PartID[fa0] Manuf[3e] (Central)
[  135.932612] fhc: Board #3, Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
[  135.933390] fhc: Board #1, Version[1] PartID[fa0] Manuf[3e]
[  135.934172] fhc: Board #7, Version[1] PartID[fa0] Manuf[3e]
[  135.935570] clock_board: Detected 5 slot Enterprise system.

$ ls -l /sys/bus/platform/devices/
total 0
lrwxrwxrwx 1 root root 0 2009-01-19 09:04 rtc-m48t59.0 -> ../../../devices/platform/rtc-m48t59.0
lrwxrwxrwx 1 root root 0 2009-01-19 09:04 sunfire-clockboard- -> ../../../devices/root/f005da70/f005db8c/f005e05c/sunfire-clockboard-
lrwxrwxrwx 1 root root 0 2009-01-19 09:04 sunfire-fhc-leds.1 -> ../../../devices/root/f0071c1c/sunfire-fhc-leds.1
lrwxrwxrwx 1 root root 0 2009-01-19 09:04 sunfire-fhc-leds.3 -> ../../../devices/root/f00df7bc/sunfire-fhc-leds.3
lrwxrwxrwx 1 root root 0 2009-01-19 09:04 sunfire-fhc-leds.7 -> ../../../devices/root/f01c923c/sunfire-fhc-leds.7


With Sams 2 patches and this path, my E3500 seems to work fine again.

-- 
Meelis Roos (mroos@linux.ee)
