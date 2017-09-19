From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 06:58:06 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <a917b765-bc3b-3942-a5a1-6959faa8ebd3@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/19/2017 08:43 AM, Eric Saint Etienne wrote:
> I am sorry for every Sparc users because it was a chance for them to
> easily explore and use machine description without having to install
> an external tool and a scripting language plus dependencies (potentially
> a lot of dependency). Users may also not know about /dev/mdesc whereas
> a mere "grep -ri cache /sys" would be fruitful.

I agree and I found your argumentation very reasonable and convincing.

Users are looking for hardware information below /sysfs, not somewhere
in /dev. /dev would actually be the last location I'd ever expect to
provide hardware information.

It also shouldn't be necessary to install a special tool to be able
to parse hardware information. /dev/mdesc sounds like a relict from
the old Linux days to me which should be superceded by sysfs.

Wasn't it a goal to eventually move all system information to sysfs
and even removing the remains from /proc in the distant future as
/proc is actually the process filesystem and not for system information?

> Also mdesc is root accessible only. Exposing all or even just a selection
> of machine description nodes to users via sysfs provides them with the
> visibility of for instance TLBs and Caches (number, size, and more
> importantly how they are organized in the processor).

That's even worse. Users should be able to retrieve system information
without being the root user.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
