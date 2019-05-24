From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 24 May 2019 11:09:52 +0000
Subject: Re: Making MAX_PHYS_ADDRESS_BITS configurable
Message-Id: <b03ce514-5b35-1cfe-0a1d-ed69805a2aec@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <2be3335c-1870-9867-0f25-01cf798ca84b@physik.fu-berlin.de>
In-Reply-To: <2be3335c-1870-9867-0f25-01cf798ca84b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 5/24/19 12:24 PM, John Paul Adrian Glaubitz wrote:
> On sparc64, MAX_PHYS_ADDRESS_BITS is currently defined as 53 meaning that
> a lot of JITs crash on a sparc64 userspace [1].

Correction, it shouldn't be MAX_PHYS_ADDRESS_BITS but sparc64_va_hole_top as
defined in mm/init_64.c.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
