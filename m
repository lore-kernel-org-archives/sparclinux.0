From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 30 Oct 2007 01:54:14 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47268EC6.4030201@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>>> 	mount -t devpts none /dev/pts
>> mount --bind /dev /thechroot/dev
>> is what I use here, running udev in a chroot is no fun.
> 
> Ok.

AFaik the buildds only have a minimal /dev. though. But to bootstrap a
system that's usually not enough.

> Let's stick to 2.6.23 testing for pinpointing these bugs.

Ok. Do you have a .deb with a kernel for me? If not - would you like to
have any specific options enabled - I have to build one then.


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
