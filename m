From: Friedrich Oslage <bluebird@porno-bullen.de>
Date: Thu, 19 Jun 2008 07:58:45 +0000
Subject: Re: [BUG] Kernel panic on heavy disk activity with esp_scsi
Message-Id: <20080619075845.GA29906@v32062.1blu.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1210367903.21472.14.camel@lya.porno-bullen.de>
In-Reply-To: <1210367903.21472.14.camel@lya.porno-bullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> What's your approximate test case, is it some script that
> performs the big directory operations you described in your
> original report?

I run "emerge --sync && emerge --metadata", but these commands are
Gentoo-specific. Both of them read/modify/parse the portage tree(a
directory containing 26264 sub-directories and 113530 files).

> Can I have a copy?  I'd like to trigger this here and debug
> it locally if possible.

One of these should help you to trigger the bug:

Option 1 (works sometimes)
$ wget ftp://distro.ibiblio.org/pub/linux/distributions/gentoo/snapshots/portage-latest.tar.lzma
$ unlzma portage-latest.tar.lzma
$ while [ true ]
$ do
$	tar -xf portage-latest.tar
$	rm -r portage
$ done

Option 2 (works always)
$ wget ftp://ftp.ucsb.edu/pub/mirrors/linux/gentoo/releases/sparc/2008.0_beta2/stages/stage3-sparc64-2008.0_beta2.tar.bz2
$ mkdir gentoo-chroot
$ cd gentoo-chroot
$ tar -xjpf ../stage3-sparc64-2008.0_beta2.tar.bz2
$ cp /etc/resolv.conf etc/
$ mount -t proc proc proc/
$ chroot . /bin/bash
$ env-update
$ source /etc/profile
$ emerge --sync
$ # if your system is still alive, one of these commands will kill it for sure
$ while [ true ]
$ do
$	rm -r /var/cache/edb/dep
$	emerge --metadata
$ done

Regards,
Friedrich
