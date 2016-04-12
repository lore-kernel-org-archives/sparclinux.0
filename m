From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 12 Apr 2016 09:29:59 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570CC017.7040805@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

On 04/11/2016 09:04 PM, David Miller wrote:
> Thanks for bringing this up.
> 
> Although I wonder, I was able to successfully install debian just fine
> a couple years ago in LDOM guest nodes without any special changes
> whatsoever.  Were there autoload hacks placed in /etc or similar
> before?

I'm not sure actually but back then you were definitely installing
Debian's sparc port (32-bit userland / 64-bit kernel) which is no
longer part of Debian.

We are now working on a new, full 64-bit SPARC port called "sparc64",
so many things are actually built from scratch. It's therefore not
unlikely that the old installer images contained some work-around
to address the problem, at least initramfs-tools contains one [1]
which is not used in the installer image, however, and people therefore
have to load the modules manually for the installation.

> Either way, I'll look at this patch, thanks.

Great, thanks a lot!

Adrian

> [1]
http://sources.debian.net/src/initramfs-tools/0.123/hook-functions/?hlG8#L478

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
