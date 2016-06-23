From: David Miller <davem@davemloft.net>
Date: Thu, 23 Jun 2016 15:06:44 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <20160623.110644.2293700782247142918.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jun 2016 10:30:14 +0200

> Thus, I don't think any of the objections brought up against the
> sparc64 port are valid. Neither is sparc64 64-bit only nor does
> anyone anyhow prevent you in Debian to mix packages from different
> architectures. In fact, Debian has by far the most flexible approach
> to resolve the 32-bit/64-bit problem by providing a generic approach
> for mixing libraries of different architectures.

I think what irks people the most about what happened, is that the
choosen a path is not the most optimal situation for the target
platform.

The most desirable would have been to build the bulk of userland
binaries as 32-bit with v8+ extensions (perhaps even with -mcpu=xxx
for some v9 cpu), and then for the specific packages that need it,
build 64-bit.

And I would assume that would be perhaps binutils and perhaps gcc
and GIT.

Yes, the 64-bit packages for everything should exist in the repository
and be built, but the default install should not have everything
64-bit.
