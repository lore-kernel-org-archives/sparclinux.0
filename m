From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 04 Mar 2016 20:47:13 +0000
Subject: Re: Kernels 4.+ are breaking rsync?
Message-Id: <56D9F451.8080603@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <56C11585.3060503@triadic.us>
In-Reply-To: <56C11585.3060503@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/05/2016 05:24 AM, alexmcwhirter@triadic.us wrote:
> I do find it odd that the Debian port seems to be working fine. I'm
> going to give the latest kernel on a try on this box. Previously i had
> only tried up to the latest rendition of 4.1. If it's still broken I
> will boot up Debian and see what's going on. Hopefully it isn't hardware
> specific "This is a cheetah box IIRC"

It might be a toolchain issue.

Are you using the default compiler options or did you tune anything?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
