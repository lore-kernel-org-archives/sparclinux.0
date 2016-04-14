From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 09:00:41 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570F5C39.7030202@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/14/2016 03:52 AM, David Miller wrote:
>> root@deb4g:/sys/devices/channel-devices# cat vdc*/mod*
>> vio:Tvdc-portSunknown
>> vio:Tvdc-portSunknown
>> vio:Tvdc-portSunknown
>> vio:Tvdc-portSunknown
>> vio:Tvdc-portSunknown
>> root@deb4g:/sys/devices/channel-devices#
>>
>> Testing a much simpler version now. Second.
> 
> Those all say "vdc-port", which again is the block device.
> 
> Where are the networking devices?

Sigh, I shouldn't do such things in the middle of the night, sorry:

root@deb4g:/sys/devices/channel-devices# cat v*/mod*
vio:Tvdc-portS
vio:Tvdc-portS
vio:Tvdc-portS
vio:Tvdc-portS
vio:Tvdc-portS
vio:Tvlds-portS
vio:Tvnet-portS
vio:Tvnet-portS
vio:Tvnet-portS
vio:Tvnet-portS
vio:Tvnet-portS
vio:Tvnet-portS
root@deb4g:/sys/devices/channel-devices#

And, thanks for the comments on the patches. Will fix those, too.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
