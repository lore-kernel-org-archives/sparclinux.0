From: Steve Pacenka <s.pacenka@verizon.net>
Date: Wed, 11 May 2005 19:34:02 +0000
Subject: Re: Which distribution to use?
Message-Id: <1115840042.27751.252.camel@dendra>
List-Id: <sparclinux.vger.kernel.org>
References: <20050511145638.B3281C00173@mail.conkret.de>
In-Reply-To: <20050511145638.B3281C00173@mail.conkret.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2005-05-11 at 16:56 +0200, herbert@wengatz.de wrote:

> I just got an Ultra-30 and an Ultra-10 for myself at home. I want to
> install Linux on at least on of the two machines.
> 
> All I did find on the web about Linux on Sparc seems to be about 2-3
> years old, which makes me somewhat sad...
> 
> Which is the distribution that supports currently those boxes best?

The Debian Sparc port, Sarge distribution as snapshotted in the current
"testing" release, serves me very well.  I run it on U2, U5, U10, and
U60 boxes in office, home, and volunteer computer rehab contexts.  The
U10 has been tracking Debian Sarge for around three years with almost no
problems from incremental upgrades.  A second U10 will join it soon to
replace an x86 samba+nfs+httpd+imapd server.

There are probably not be enough Sparc Linux users to merit having
better organized and more frequently updated WWW sites specialized to
this platform and OS.  Too bad.

The Debian Sparc mailing list archives are a very good resource.


> I'd like to have (due to very little spare time) an almost hassle-free
> installation. I'm used to SuSE, Knoppix, Slackware and RedHat
> (experience decreases in that order) and of course lots of Solaris
> (any).

If you haven't tried installing from Sarge/testing in the last six
months, you will be pleasantly surprised with progress in the installer.

Starting from a "businesscard" or "net install" bootable ISO of Sarge,
it takes a few minutes of initial interaction to get the install going,
then a wait of an hour or hours (depending on one's internet connection
speed) while the base install downloads and configures.  Interaction
resumes to reboot using the kernel just installed on the hard drive,
then interaction completes after a few minutes of selection of packages
or package groups to install beyond the base.  Then go to bed while it
installs the selected packages.

With recent installers, it takes me about three hours with a DSL @
190K/sec download connection to get a minimal GNOME desktop running on a
U5 or U10's bare hardware.  Most of this time is spent waiting for the
download/unpack/install.

Time savings come when updating.  "apt-get update", "apt-get
dist-upgrade" refreshes every installed package with security and other
updates, which can be voluminous if you track testing=Sarge and have a
lot of packages installed, or if it is a couple of months since the last
mass update.

> I'd like to try Gentoo (is there a port to Sparc?), but have had some
> troubles in installing Debian on x86, so I shy a little away from
> that...

Debian has been so flexible and robust for me that I haven't felt a need
to try Gentoo's port to UltraSparc.


> By the way, they both have a Creator 3D card and I'd like to use that,
> too...

My U60 and U2 have Creator 3D's, suppored by the kernel for console use
and by XFree86 via the "ffb" driver.  Dual-headed X between the Creator
3D and motherboard video should be possible; I did Elite 3D +
motherboard concurrently on the U10.


> And, last but not least: Anything special about the compilers?

If special means "can compile several thousand packages of the Debian
Sparc collection successfully," then gcc 3.3 on Sparc is darned special.
gcc-3.4, 2.95, and 4.0 are also packaged.

-- SP


