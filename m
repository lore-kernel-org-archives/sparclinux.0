From: Meelis Roos <mroos@linux.ee>
Date: Fri, 02 Apr 2004 09:27:51 +0000
Subject: Re: ioctl32 translations for clock
Message-Id: <Pine.GSO.4.44.0404021211310.23192-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0404010904270.8073-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404010904270.8073-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I've seen this too, and upgrading to current debian fixed all of that.

hwclock --debug --hctosys --utc
hwclock from util-linux-2.12
hwclock: Open of /dev/rtc failed, errno=2: No such file or directory.
No usable clock interface found.
Cannot access the Hardware Clock via any known method.

I am using udev and a custom 2.6.5-rc3 kernel. There is no /dev/rtc node
after udev has just started. I have compiled rtc modular for some
strange reason. Loading the module by hand creates /dev/rtc so udev is
working correctly. There just isn't any hook for autoloading rtc
automatically at that point so the best should be compiling rtc into
kernel, not modular - at least when using udev. Considering I had
similar problems some time ago (without udev), it's probably good to
compile rtc statically anyway.

Compiling rtc statically solved it, I just tested. /dev/rtc node was
created on udev startup and everything was OK.

So the solution is to compile rtc statically as the help tells.

-- 
Meelis Roos (mroos@linux.ee)

