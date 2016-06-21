From: chase rayfield <cusbrar1@gmail.com>
Date: Tue, 21 Jun 2016 23:20:59 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <CACwypyNEQNf_cMO3Ki+xTWcnwPQ=_f2A6JsjfLx6FWXsrfL4Yg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

How well maintained is the Debian Sparc port these days and what is
the reason for forcing upgrades to 64bit userland?

Sparcv8+ 32bit code is faster as far as I know in most cases even on
new Sparcs due to memory overhead for 64bit instructions.... telling
people to go pure 64bit is nonsense and certainly isn't what
Gentoo/Sparc does or suggests.

I think sun4u machines had a 2 or 4GB limit on the boot partition
still no idea after that though. I think some/most sun4m could do 2Gb
boot partition and sun4c was 1GB. Not sure about sun4d or e though I
suspect it is similar to sun4m.

Chase
