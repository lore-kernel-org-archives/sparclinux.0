From: Paul Bolle <pebolle@tiscali.nl>
Date: Mon, 01 Jun 2015 08:27:40 +0000
Subject: Re: [PATCH v2 1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP synchronization
Message-Id: <1433147260.2361.25.camel@x220>
List-Id: <sparclinux.vger.kernel.org>
References: <1432910778-314-1-git-send-email-xlpang@126.com>
In-Reply-To: <1432910778-314-1-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-cris-kernel@axis.com, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Xunlei Pang <pang.xunlei@linaro.org>

On Fri, 2015-05-29 at 22:46 +0800, Xunlei Pang wrote:
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig

>  config RTC_HCTOSYS_DEVICE
>  	string "RTC used to set the system time"
> -	depends on RTC_HCTOSYS = y || RTC_SYSTOHC = y
> +	depends on RTC_HCTOSYS = y

RTC_HCTOSYS and RTC_SYSTOHC are bool symbols. The "= y" test is not
needed and the common idiom is to use only
	depends on RTC_HCTOSYS

Since you're touching this you might as well switch to that idiom.

>  	default "rtc0"
>  	help
>  	  The RTC device that will be used to (re)initialize the system
> 	  minutes if userspace reports synchronized NTP status.

> +config RTC_SYSTOHC_DEVICE
> +	string "RTC used to synchronize NTP adjustment"
> +	depends on RTC_SYSTOHC = y

Likewise.

> +	default "rtc0"
> +	help
> +	  The RTC device used for NTP synchronization. The main difference
> +	  between RTC_HCTOSYS_DEVICE and RTC_SYSTOHC_DEVICE is that this
> +	  one can sleep when setting time, because it runs in the workqueue
> +	  context.


Paul Bolle

