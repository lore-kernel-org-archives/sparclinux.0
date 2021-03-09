From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 09 Mar 2021 00:19:05 +0000
Subject: Re: [GIT] SPARC
Message-Id: <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20210308.154619.729170517586257571.davem@davemloft.net>
In-Reply-To: <20210308.154619.729170517586257571.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dave!

On 3/9/21 12:46 AM, David Miller wrote:
> Just some more random bits from Al,  including a conversion over to generic exytables.

Is there a chance we could include this important fix by Rob Gardner for 5.12 as well?

> https://marc.info/?l=linux-sparc&m1457847223456&w=2

It fixes a hard kernel crash under certain loads which we have seen in Debian quite frequently.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
