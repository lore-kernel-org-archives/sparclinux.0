From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 29 May 2020 10:48:05 +0000
Subject: Re: sparc vs sparc64: O_NDELAY and O_NONBLOCK mismatch in kernel and in glibc
Message-Id: <dbf139ca-9914-8d16-7a8d-7a8e84646a77@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20200529104019.72983ef9@sf>
In-Reply-To: <20200529104019.72983ef9@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 5/29/20 11:40 AM, Sergei Trofimovich wrote:
> On most targets glibc defines O_NDELAY as O_NONBLOCK.
> (...)
>   I think '#define O_NDELAY O_NONBLOCK' would be most
>   consistent.
> 
> What do you think?

Would this, by any chance, also fix some of the glibc testsuite failures
we are seeing on SPARC? [1]

Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=glibc&arch=sparc64&ver=2.30-8&stamp89400224&raw=0

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
