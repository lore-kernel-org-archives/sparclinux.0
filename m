From: David Miller <davem@davemloft.net>
Date: Mon, 29 Oct 2007 23:45:39 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071029.164539.38797667.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Tue, 30 Oct 2007 00:37:13 +0100

> I'd try doing a debootstrap of lenny (that's Debian "testing"),
> and then inside it, run one or more of those 'dpkg-query -S libc.so.6'.

Thanks for the info.

While waiting for you to reply I created a lenny buildd
build root on my SunFire 280R using:

	debootstrap --variant=buildd lenny /org/buildd/chroots/lenny \
		http://mirrors.kernel.org/debian

basically following roughly the instructions at:

	http://www.debian.org/devel/buildd/setting-up

And then once chroot'ed into the lenny build root you have
to setup a few manual things like /proc, /sys/, and /dev/pts
mounts for anything to work:

	chroot /org/buildd/chroots/lenny
	mount -t proc none /proc
	mount -t sysfs none /sys
	mount -t devpts none /dev/pts

So, it's a lot more than just running the appropriate debootstrap
command.

I have done a GCC package build and am now running a libc6 build under
this lenny chroot and haven't hit any problems yet.

This is with a stock 2.6.23.1 kernel.

BTW, in your buildroot, can you do something like:

	strace -o x.log dpkg-query -S libc.so.6

and send me that "x.log" file?

That might give some important clues.

Thanks.
