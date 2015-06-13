From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Sat, 13 Jun 2015 12:23:01 +0000
Subject: Re: [PATCH v3 1/3] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP synchronization
Message-Id: <20150613122301.GI3890@piout.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1434078618-16373-1-git-send-email-xlpang@126.com>
In-Reply-To: <1434078618-16373-1-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>, Paul Bolle <pebolle@tiscali.nl>

Hi,

On 12/06/2015 at 11:10:16 +0800, Xunlei Pang wrote :
> +config RTC_SYSTOHC_DEVICE
> +	string "RTC used to synchronize NTP adjustment"
> +	depends on RTC_SYSTOHC
> +	default RTC_HCTOSYS_DEVICE

Actually, I forgot one case so I changed it to:
+       default RTC_HCTOSYS_DEVICE if RTC_HCTOSYS
+       default "rtc0"

I applied both series, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
