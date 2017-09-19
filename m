From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 18:39:02 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <a9b74b3e-978b-b183-ec48-27368d697827@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/19/2017 08:12 PM, David Miller wrote:
> If /dev/mdesc didn't exist, we could further delve into the details
> of this situation.
> 
> But it's there, for years, and it already provides the information
> that userspace needs.

Yes, and most people probably don't even know it exists. I'm one of
Debian's sparc64 porters and I haven't heard of it before.

>> Tools that probably haven't been touched for ages. Like with SILO,
>> the world has moved on to more modern tools.
> 
> Tools that work only need so many bug fixes and feature additions.

And which are not present in any common Linux distribution that I know of.

> What bug in prtconf are you aware of that I haven't fixed?
> 
> What patch submitted to me for SILO or prtconf have I ignored and
> not given feedback to or applied straight away?

SILO is still a 32-bit application, doesn't properly support GPT partition
tables, requires a special partition layout with a small boot partition,
has a very crude and user-unfriendly boot and configuration interface
and so on.

The world has moved on from bootloaders like LILO, SILO and PALO. The
same applies for the sysfs hardware information.

And you really shouldn't take your usecase and experience as the
reference. You're a very experienced and long time user and know all
the quirks and details of the platform. Of course, you don't need
something that is user-friendly. But the majority of Linux users do.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
