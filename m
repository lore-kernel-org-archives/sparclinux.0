From: David Miller <davem@davemloft.net>
Date: Thu, 14 Apr 2016 16:02:17 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160414.120217.221678401914365646.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 11:00:41 +0200

> Sigh, I shouldn't do such things in the middle of the night, sorry:
> 
> root@deb4g:/sys/devices/channel-devices# cat v*/mod*
> vio:Tvdc-portS
> vio:Tvdc-portS
> vio:Tvdc-portS
> vio:Tvdc-portS
> vio:Tvdc-portS
> vio:Tvlds-portS
> vio:Tvnet-portS
> vio:Tvnet-portS
> vio:Tvnet-portS
> vio:Tvnet-portS
> vio:Tvnet-portS
> vio:Tvnet-portS
> root@deb4g:/sys/devices/channel-devices#

That looks a lot better.
