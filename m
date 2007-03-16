From: David Miller <davem@davemloft.net>
Date: Fri, 16 Mar 2007 20:52:13 +0000
Subject: Re: sparc32 esp connected CDROM failures
Message-Id: <20070316.135213.74563078.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1173976389.16911.13.camel@dhcp-32-109.ord.redhat.com>
In-Reply-To: <1173976389.16911.13.camel@dhcp-32-109.ord.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 16 Mar 2007 14:47:00 -0500

> The ioctl error repeats once more in the sequence...but the CDROM seems
> to work ok, as compared to sparc32, where it refuses to work.

Unfortunately that puts the ball in your or someone else's court,
since I don't have any sparc32 systems and therefore any way to work
on sparc32 bugs.

Sorry.

Really, you should drop sparc32 support in Aurora if you want my
opinion.  Then you can build glibc sparcv9 by default and make other
significant improvements to the userspace.  I probably won't ever use
Aurora until you make this switch, the performance just from being
able to -mcpu=v8 -mtune=ultrasparc all of userspace is very noticable.

Making a distribution for a kernel platform that has no active
maintainer is beyond foolish, you'll always have bugs that nobody
is going to fix other than yourself and that doesn't scale and
will continually hold up the release.
