From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 22:02:20 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <7c98305c-eefe-b65e-cffe-bacd57ca8e7b@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/19/2017 10:29 PM, David Miller wrote:
> You are showing that you do not even know what packages exist
> in Debian.

No, you're the one who is not up the current status quo.

> 'prtconf' has been in the sparc-utils package for probably like
> two decades.

No, it isn't. Debian on sparc does no longer exist and "sparc-utils"
is a package with the architectures "sparc" and "sparc64". The former
is no longer part of Debian, the latter is part of Debian Ports.

Any package which is not building on the release architectures cannot
exist anywhere but in Debian *unreleased* and any package there is
not part of Debian and completely unsupported. It merely exists
there because *I* put it there.

> I fail to see how having the proper tool in the distribution makes
> things harder for users.

Because the proper tool is *not* part of the distribution.

> And, by the way, my opinions and my preferences do matter.  That's
> part of what being the maintainer is all about.  Being the last choke
> valve of taste and decision making for changes that go into the sparc
> port.

No, I wholeheartedly disagree. This is how projects are forked and
this is how projects like XFree86, OSS, cdrecord and so on went
down the drain. Because one or single maintainers thought their
opinion is all that counts.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
