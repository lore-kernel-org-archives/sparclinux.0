From: David Miller <davem@davemloft.net>
Date: Mon, 08 Sep 2008 19:38:09 +0000
Subject: Re: rtc-m48t59 on an Ultra 5
Message-Id: <20080908.123809.07343851.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080906014432.GA21910@orion.carnet.hr>
In-Reply-To: <20080906014432.GA21910@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 8 Sep 2008 17:13:13 +0200

> There are few things which can improve your situation:
> 
> 1. Rebuild the kernel with  CONFIG_RTC_HCTOSYS option set.
> It is named "Set system time from RTC on startup and resume"
> This make system use the rtc0 (you can set it up in configuration
> as well) to get initial time and date.
> 
> 2. Add "ln -s /dev/rtc0 /dev/rtc" to your booting scripts before
> the hwclock (or ntp) is used for the first time.
> 
> 3. Define udev rule (if you use udev) to create /dev/rtc link to 
> the /dev/rtc0.

These all work, but I really think there should be at least a kernel
config controlled way for an automatic alias to show up.

Even something as simple as just creating a /sys/class/misc/rtc/dev
file that outputs the major and minor device numbers of /dev/rtc0,
udev would just "do the right thing" and create that alias /dev/rtc
node for the user.

This whole /dev/rtc0 business is just unnecessary pain, it makes
transition of a platform to the RTC subsystem harder rather than
easier.


