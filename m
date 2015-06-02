From: pang.xunlei@zte.com.cn
Date: Tue, 02 Jun 2015 03:18:09 +0000
Subject: Re: [PATCH v2 1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP synchronization
Message-Id: <OFA83CEB22.B9F4BDE6-ON48257E58.0011E159-48257E58.00122289@zte.com.cn>
List-Id: <sparclinux.vger.kernel.org>
References: <1432910778-314-1-git-send-email-xlpang@126.com> <1433147260.2361.25.camel@x220>
In-Reply-To: <1433147260.2361.25.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Jesper Nilsson <jesper.nilsson@axis.com>, John Stultz <john.stultz@linaro.org>, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>, rtc-linux@googlegroups.com, sparclinux@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Xunlei Pang <xlpang@126.com>

Hi Paul,

Paul Bolle <pebolle@tiscali.nl> wrote 2015-06-01 PM 04:27:40:
> 
> Re: [PATCH v2 1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP 
> synchronization
> 
> On Fri, 2015-05-29 at 22:46 +0800, Xunlei Pang wrote:
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> 
> >  config RTC_HCTOSYS_DEVICE
> >     string "RTC used to set the system time"
> > -   depends on RTC_HCTOSYS = y || RTC_SYSTOHC = y
> > +   depends on RTC_HCTOSYS = y
> 
> RTC_HCTOSYS and RTC_SYSTOHC are bool symbols. The "= y" test is not
> needed and the common idiom is to use only
>    depends on RTC_HCTOSYS
> 
> Since you're touching this you might as well switch to that idiom.
> 
> >     default "rtc0"
> >     help
> >       The RTC device that will be used to (re)initialize the system
> >      minutes if userspace reports synchronized NTP status.
> 
> > +config RTC_SYSTOHC_DEVICE
> > +   string "RTC used to synchronize NTP adjustment"
> > +   depends on RTC_SYSTOHC = y
> 
> Likewise.

Yea, thanks for pointing this out.

-Xunlei

> 
> > +   default "rtc0"
> > +   help
> > +     The RTC device used for NTP synchronization. The main difference
> > +     between RTC_HCTOSYS_DEVICE and RTC_SYSTOHC_DEVICE is that this
> > +     one can sleep when setting time, because it runs in the 
workqueue
> > +     context.
> 
> 
> Paul Bolle
> 

--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (and any attachment transmitted herewith) is privileged and confidential and is intended for the exclusive use of the addressee(s).  If you are not an intended recipient, any disclosure, reproduction, distribution or other dissemination or use of the information contained is strictly prohibited.  If you have received this mail in error, please delete it and notify us immediately.
