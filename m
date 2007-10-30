From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 30 Oct 2007 00:47:33 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47267F25.2090501@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> 	mount -t devpts none /dev/pts

mount --bind /dev /thechroot/dev
is what I use here, running udev in a chroot is no fun.

> So, it's a lot more than just running the appropriate debootstrap
> command.

I'm almost done with a howto which is cut&paste for 95% to debootstrap
and boot a debian system, unfortunately it doesn't boot as the klibc
(which is used in the initramfs) is broken on sparc again...
So I'll modify it to setup a proper chroot only, it should also allow to
boot into it if you use the Kernel/initrd form Ubuntu.
This should allow Josip and you to setup a complete chroot.

> I have done a GCC package build and am now running a libc6 build under
> this lenny chroot and haven't hit any problems yet.

The following things also like to crash here (on Etch, not in a chroot):
- running aptitude -u several times (at least with libnss-db installed)
- since I've installed 2.6.24-rc1: vgdisplay (with and without active
libnss-db)


> BTW, in your buildroot, can you do something like:
> 
> 	strace -o x.log dpkg-query -S libc.so.6

there're some comparisons of the strace of aptitude -u in
http://bugs.debian.org/cgi-bin/bugreport.cgi?bugC3187#102
Probably interesting as there're futexes in the game.

The interesting thing is that it didn't crash the machine while running
under strace.

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
