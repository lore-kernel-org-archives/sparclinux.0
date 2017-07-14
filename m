From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 14 Jul 2017 12:16:52 +0000
Subject: Re: Trying out debian sparc64
Message-Id: <20170714121652.GD26530@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, Jul 14, 2017 at 03:10:22PM +0300, Meelis Roos wrote:
> Unrelated - git seems to be not installable at the moment because of=20
> version conflict with git-man?

This is a known bug:

> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=866011

Fetch the matching version for git-man from here:

> http://snapshot.debian.org/package/git/1%3A2.11.0-4/#git-man_1:3a:2.11.0-4

Debian Ports unfortunately immediately purges "all" packages from the
archive the moment a new version is uploaded to unstable, independent
whether any of the architectures still needs the older version for
whatever reasons.

> sparc-utils seems to be missing from sparc64 - no eeprom and prtconf=20
> programs? Sending prtconf output was my first task after getting system=20
> installed, since there is no t5140 in the prtconfs repo.

You need to add "unreleased" to your sources.list [1]:

deb http://ftp.ports.debian.org/debian-ports/ unreleased main

sparc64-only packages cannot be in unstable until sparc64 has become a
release architecture.

Adrian

> [1] https://people.debian.org/~glaubitz/sources.list

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
