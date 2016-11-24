From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 21:51:14 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <ff23bfc0-689f-436a-6814-5c69299fe679@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/24/2016 10:23 PM, Aaro Koskinen wrote:
> This breaks the native build on my Sun Ultra 5 with 32-bit userspace and GCC
> defaulting to ultrasparc:

Well, you can just change this part back to "elf32_sparc" and it will work. Might
even be possible to omit the "-m" option altogether to it will default to -m native.

> Also you broke the tilo build...

Not here. Just tried it again and it builds fine. Can you be more specific?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
