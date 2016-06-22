From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 22 Jun 2016 19:57:09 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <99628036-a19b-8bd1-cb12-5acba4ad7925@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/22/2016 09:46 PM, David Miller wrote:
> Frankly, I'm leaving all of my sparc64 machines, yes all of
> them, running the unsupported 32-bit userland and will simply
> live without upgrades and support.
> 
> That's how important this is to me.

I'm not arguing with you that 32-bit code is faster than comparable 64-bit
code, it absolutely is. Heck, even Intel realized that a few years ago and
they created the x32 ABI [1]. It didn't help though as x32 is rather unpopular
among users and developers. We have a handful of users of the port in Debian
which I also help to maintain, by the way.

And it's not like that people have not run into memory issues when using a 32-bit
process address space. 4 GiB can be easily eaten up when building something
like Firefox with link-time optimization enabled, so I don't think we have
a viable alternative to sparc64 in the long term.

Thanks,
Adrian

> [1] https://en.wikipedia.org/wiki/X32_ABI

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
