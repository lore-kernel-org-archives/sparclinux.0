From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 27 Dec 2010 08:40:57 +0000
Subject: Bleeding edge kernel booted on SPARC Classic
Message-Id: <20101227084057.GA31211@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Some time ago I brought a SPARC Classic on ebay and
this holiday I found some time to play around with it.

I got the bleeding edge kernel booting on the box
and no hicups in the process.
[Lots of smaller issues getting netboot working etc.
but thats another story].

For now it is net booted and runs Linux only in a small
RAM disk. I want to keep Solaris around until I have
captued relevant info (prtconf etc).

I have used buildroot as the base and userspace is
only busybox for now - as it fits in my RAM disk.

I will try with regular intervals to boot bleeding edge
kernels on this box to catch any regressions.
I can assist in minimal testing of SPARC32 stuff,
so just let me know if there is anything to look at.

	Sam
