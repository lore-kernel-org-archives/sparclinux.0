From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 23 Nov 2016 15:47:46 +0000
Subject: Re: 4.9.0-rc6-00086-g3b404a5 seems good on my sparc64 machines
Message-Id: <fe80274e-9ac4-8f95-4ff1-9aed0b47b06a@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1611231248340.6788@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1611231248340.6788@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/23/2016 06:14 PM, Meelis Roos wrote:
> There is no current version for debian sparc port AFAIK.

I wasn't talking about Debian sparc and I was not aware you were
since you mentioned "sparc64".

> deb http://snapshot.debian.org/archive/debian/20150725T121538Z/ unstable main contrib non-free
> 
> minus udev-related packages (downgraded to 218-8) is what I have running 
> on most of them.
> 
> Debian-ports has sparc64 but so far I have understood that I can not 
> just "upgrade" a 32-bit userland sparc port to sparc64 port, but rather 
> do a clean install on another HDD for test.

Can you please upgrade to sparc64? There is virtually no development taking
place on sparc 32-bit anymore and we need more people testing things. You
are also missing out on a lot of new and updated packages. There has been
tons of work and there is even more coming up like golang which will enables
Docker, Kubernetes and all that jazz. Installation is also possible from
"sparc" using debootstrap/multistrap [1].

Please stop running Debian sparc. It's also lacking security updates.

Adrian

> [1] https://wiki.debian.org/Sparc64#Bootstrapping_sparc64

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
