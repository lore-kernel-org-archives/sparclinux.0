From: David Miller <davem@davemloft.net>
Date: Wed, 13 Apr 2016 23:01:03 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160413.190103.128291414070242741.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 00:44:19 +0200

> Yeah, I modified Ben's patch and it works:
> 
> root@deb4g:/sys/devices/channel-devices# cat vdc*/mod*
> vio:Tvdc-portSunknown
> vio:Tvdc-portSunknown
> vio:Tvdc-portSunknown
> vio:Tvdc-portSunknown
> vio:Tvdc-portSunknown

Ok those are the block devices, where are the networking interfaces?
