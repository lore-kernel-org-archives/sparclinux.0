From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 13 Apr 2016 23:04:17 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570ED071.60804@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/14/2016 01:01 AM, David Miller wrote:
> Ok those are the block devices, where are the networking interfaces?

Whoops, sorry:

root@deb4g:/sys/devices/channel-devices# cat vdc*/mod*
vio:Tvdc-portSunknown
vio:Tvdc-portSunknown
vio:Tvdc-portSunknown
vio:Tvdc-portSunknown
vio:Tvdc-portSunknown
root@deb4g:/sys/devices/channel-devices#

Testing a much simpler version now. Second.

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
