From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jun 2016 18:42:31 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <f746ccdc-7be2-b8a7-21f1-1be4134887d0@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/23/2016 05:06 PM, David Miller wrote:
> I think what irks people the most about what happened, is that the
> choosen a path is not the most optimal situation for the target
> platform.

Why should it be any different for sparc64 than for ppc64el, amd64,
arm64, mips64el and so on? Is SPARC so extremely inefficient with
64-bit pointers? I don't think so.

> The most desirable would have been to build the bulk of userland
> binaries as 32-bit with v8+ extensions (perhaps even with -mcpu=xxx
> for some v9 cpu), and then for the specific packages that need it,
> build 64-bit.

I don't think it makes sense to compile things like dateutils with
32-bit pointers for performance reasons. Also, I would assume that
modern compilers are able to optimize the code well enough that the
difference between 32-bit and 64-bit pointers isn't too big that
it justifies the effort. Some compilers like Intel's C/C++ compiler
are actually already automatically generating 32-bit code when possible,
the feature is called auto-ilp32 [1]. gcc could possibly adopt a similar
feature in the future.

> And I would assume that would be perhaps binutils and perhaps gcc
> and GIT.
> 
> Yes, the 64-bit packages for everything should exist in the repository
> and be built, but the default install should not have everything
> 64-bit.

I disagree. I think it makes way more sense to use such speed optimizations
for code where it's really needed. That's also the most commonly used approach.

For example, packages like ATLAS hugely profit from per-machine optimization
which is why upstream doesn't recommend using pre-compiled binaries but
build the packages from source. However, no one is going to see huge
differences when building coreutils, dateutils and so on with 32-bit
pointers. You won't see a notable difference when calling "date" unless
you are going to run this command 10.000 per second - but then you are
doing something wrong anyway.

This discussion very much reminds me to the misbelief that some Gentoo
users have that building every package from source with -mnative will
have a huge impact on performance. gcc is already generating code which
is fast enough on all targets for a given -m value that there is virtually
no gain over pre-compiled packages - except for packages like the
aforementioned ATLAS.

Adrian

> [1] https://software.intel.com/en-us/node/523141

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
