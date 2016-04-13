From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 13 Apr 2016 22:35:58 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570EC9CE.7050700@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/14/2016 12:23 AM, David Miller wrote:
> The missing bit is probably having the individual sparc64 VIO drivers
> define proper module aliases.

I'm actually currently working on a patch. The aliases are already
working, now it's just the actual hotplug handler which is missing.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
