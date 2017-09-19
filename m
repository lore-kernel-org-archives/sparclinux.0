From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 17:42:25 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <b6f4cba5-f86a-922f-e42d-7b742cc01a72@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/19/2017 07:33 PM, David Miller wrote:
> The kernel has no business having all of the details of how to
> interpret binary property values, what they mean, what the
> most reasonable way is to format them, etc.

So, you basically disagree with all the other subsystem maintainers?

> That's userspace.
> 
> Sparc users already make use of special tools such as 'prtconf'
> and 'mdlint' already exists and works just fine.

Tools that probably haven't been touched for ages. Like with SILO,
the world has moved on to more modern tools.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
