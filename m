From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 22:25:45 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <9f01d731-fc40-169e-4c24-9b365e9374ec@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/20/2017 12:15 AM, David Miller wrote:
> At least it has the packages that should be there by default.

I don't think you really understand why sparc-utils is no longer part
of Debian unstable. And, as already mentioned, Gentoo has effectively
killed off sparc support.

Users currently have only three options:

 * Linux for SPARC
 * Oracle Linux for SPARC
 * Debian unstable sparc64

All of these are pure 64-bit builds. There are no more 32-bit SPARC
distributions left. You can, if you really want to, bootstrap your
own Debian sparc (32-bit) using rebootstrap [1].

Adrian

> [1] https://wiki.debian.org/HelmutGrohne/rebootstrap

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
