From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 23 Sep 2017 06:14:41 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <476d58dd-2bf5-0b3e-dc4e-83cc8b1a188f@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/23/2017 03:35 AM, David Miller wrote:
> It was part of the opensolaris sources, I ported it locally myself
> so that it would build and work on Linux.
> 
> I do not know where you can download it, and I'm probably not allowed
> to redistribute my modified version of the sources.

So, you are eagerly defending the use of /dev/mdesc and claim there is
no need for anyone to have a sysfs interface because people can use tools
like mdlint only to disclose later that mdlint not available anywhere
because it is effectively proprietary.

OK.

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
