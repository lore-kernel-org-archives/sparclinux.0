From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 27 May 2016 13:34:32 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <33bce6ca-696c-9ec4-2567-83fed24323c3@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <87fut34unx.fsf@esperi.org.uk> <87twhj3ag0.fsf@esperi.org.uk>
In-Reply-To: <87twhj3ag0.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Alcock <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>

Hi Nick!

On 05/27/2016 03:19 PM, Nick Alcock wrote:
> So I've been working on a patch series (see below) that applies GCC's
> -fstack-protector{-all,-strong} to almost all of glibc bar the dynamic
> linker. In trying to upstream it, one review commenter queried one
> SPARC-specific patch in the series; the absence of this patch triggers a
> BUG in the SPARC kernel when glibc is tested as an unprivileged user, on
> all versions tested from Oracle UEK 4.1 right up to 4.6.0, at least on
> the ldoms I have access to and presumably on bare hardware too.

I apologize for hijacking this thread but since you are mentioning glibc,
there are actually a couple of tests in the glibc testsuite [1].

Jose Marchesi has started looking at them and most of them seem to be
related to unaligned accesses. Would be great if those could be resolved
in the near future, too.

We're working towards getting Debian's sparc64 port into a releasable
state, but there are some packages like glibc or util-linux that need
work since their testsuites fail.

Cheers,
Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=glibc&arch=sparc64&ver=2.22-9&stamp64023539

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
