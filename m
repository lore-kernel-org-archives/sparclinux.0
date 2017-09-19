From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 22:05:58 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <164a5840-0bff-e311-9c6e-8f6d0c489b0b@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/20/2017 12:03 AM, Kjetil Oftedal wrote:
> Actually, sparc-utils was a part of wheezy/stable before Debian decided
> to drop the official SPARC port.

Yes, I retrieved it from there and made it available for sparc64. I also had
to patch it because it wouldn't work on sparc64 [1].

But we're not talking about history, we're talking about current software.

Adrian

> [1] http://ftp.ports.debian.org/debian-ports/pool-sparc64/main/s/sparc-utils/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
