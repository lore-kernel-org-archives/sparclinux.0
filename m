From: David Miller <davem@davemloft.net>
Date: Thu, 14 Apr 2016 01:52:18 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160413.215218.625559151716593400.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 01:04:17 +0200

> On 04/14/2016 01:01 AM, David Miller wrote:
>> Ok those are the block devices, where are the networking interfaces?
> 
> Whoops, sorry:
> 
> root@deb4g:/sys/devices/channel-devices# cat vdc*/mod*
> vio:Tvdc-portSunknown
> vio:Tvdc-portSunknown
> vio:Tvdc-portSunknown
> vio:Tvdc-portSunknown
> vio:Tvdc-portSunknown
> root@deb4g:/sys/devices/channel-devices#
> 
> Testing a much simpler version now. Second.

Those all say "vdc-port", which again is the block device.

Where are the networking devices?

