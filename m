From: "David S. Miller" <davem@redhat.com>
Date: Thu, 01 Apr 2004 19:10:44 +0000
Subject: Re: ioctl32 translations for clock
Message-Id: <20040401111044.01eb5732.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0404010904270.8073-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404010904270.8073-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 1 Apr 2004 09:06:50 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> ioctl32(hwclock:451): Unknown cmd fd(3) cmd(00004b50){00} arg(effffc58) on /dev/tty1
> ioctl32(hwclock:454): Unknown cmd fd(3) cmd(00004b50){00} arg(effffc48) on /dev/tty1
> ioctl32(hwclock:455): Unknown cmd fd(3) cmd(00004b50){00} arg(effffc58) on /dev/tty1

It's always going to spit these out, this is hwclock trying to figure out
the access method and one thing it tries are the old M68K platform specific
ioctls which the translation layer doesn't handle of course.

> Cannot access the Hardware Clock via any known method.

I've seen this too, and upgrading to current debian fixed all of that.

The kernel has had the correct translations for this clock stuff for
years.  It's something on the userlevel side.

