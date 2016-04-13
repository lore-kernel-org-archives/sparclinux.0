From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 13 Apr 2016 22:44:19 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570ECBC3.3040200@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/14/2016 12:37 AM, David Miller wrote:
> Are you sure?  See my other email, VIO devices don't come from the
> Openfirmware device tree at all.

Yeah, I modified Ben's patch and it works:

root@deb4g:/sys/devices/channel-devices# cat vdc*/mod*
vio:Tvdc-portSunknown
vio:Tvdc-portSunknown
vio:Tvdc-portSunknown
vio:Tvdc-portSunknown
vio:Tvdc-portSunknown
root@deb4g:/sys/devices/channel-devices#

But I need to do some more clean up. Then I'll send you a patch.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
