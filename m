From: krzysztof.h1@poczta.fm
Date: Sat, 04 Oct 2008 10:27:07 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02 rtcs
Message-Id: <20081004102707.5E5BF141A440@f15.poczta.interia.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 2008/9/13 Krzysztof Helt <krzysztof.h1@poczta.fm>:
> > On Thu, 11 Sep 2008 14:04:12 +0400
> > "Alexander Beregalov" <a.beregalov@gmail.com> wrote:
> >
> >> Hi
> >>
> >> Is that a different problem?
> >>
> >> 2.6.27-rc6
> >>
> >
> > What kernel version have you used?
> > If it was plain 2.6.27-rc6 there was no rtc layer support yet. Please
> try the linux-next.
> Yes, it was mainline kernel.
> 
> I have the same issue from time to time on mainline kernel and on
> `davem/sparc-next-2.6.git master`.
> Clock appears to be in the future or in the past (I suppose it is
> actually far in the future)
> after boot from time to time.
> I set it properly by NTP, save hw clock, but after several reboots
> story happens again.
> 
> bus: 'platform': add driver rtc-m48t59
> bus: 'platform': driver_probe_device: matched device rtc-m48t59.0 with
> driver rtc-m48t59
> bus: 'platform': really_probe: probing driver rtc-m48t59 with device
> rtc-m48t59.0
> device: 'rtc0': device_add
> rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
> driver: 'rtc-m48t59.0': driver_bound: bound to device 'rtc-m48t59'
> bus: 'platform': really_probe: bound device rtc-m48t59.0 to driver
> rtc-m48t59
> bus: 'platform': add driver rtc-bq4802
> bus: 'platform': add driver rtc-sun4v
> bus: 'platform': add driver rtc-starfire
> ...
> rtc-m48t59 rtc-m48t59.0: setting system clock to 2108-10-03 23:46:02
> UTC (83783866)
> 
> At the moment I write it system time is Sun Aug 27 18:04:42 UTC 1972
> (83786677).
> 
> The hardware is Ultra 10.
> 
> How can I help?
> 
> 

Do you reboot your system with different kernel versions (-next and mainline) or other systems? 

I am away from my Sun box so I'll retest this on Monday.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Dzwon taniej na zagraniczne komorki!
Sprawdz >> http://link.interia.pl/f1f26 

