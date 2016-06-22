From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 22 Jun 2016 19:23:40 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <e70b35c7-7e7a-7cae-3eaf-83a0e37d3447@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/22/2016 09:13 PM, David Miller wrote:
> From: chase rayfield <cusbrar1@gmail.com>
> Date: Tue, 21 Jun 2016 19:20:59 -0400
> 
>> How well maintained is the Debian Sparc port these days and what is
>> the reason for forcing upgrades to 64bit userland?
>>
>> Sparcv8+ 32bit code is faster as far as I know in most cases even on
>> new Sparcs due to memory overhead for 64bit instructions....
> 
> +10000000

That won't change the fact that the majority of work is now happening on
sparc64. I don't think there is a realistic chance of getting most projects
spending much work on the 32-bit code since the focus is on new hardware.

Either way, Debian sparc (32-bit) is completely unsupported these days
and no longer receiving any security updates. So, anyone should either
use Gentoo or switch over to Debian sparc64.

So far I haven't seen any issues with the sparc64 port, even on my old
Sun Blade 100. Alas, I haven't done any detailed benchmarking yet.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
