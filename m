From: David Miller <davem@davemloft.net>
Date: Thu, 12 Apr 2007 21:36:00 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.98 (Beta 1 for 3.0)
Message-Id: <20070412.143600.07042701.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1175577171.3531.131.camel@localhost.localdomain>
In-Reply-To: <1175577171.3531.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 03 Apr 2007 00:12:51 -0500

> - CDROM installs on sparc32 hardware don't work. If you're installing to
> a sparc32 system, netboot.

On a dual cpu Ultra2, 512MB ram, with creator3d frame buffer,
the installer always exits abnormally right after loading the
ESP driver.  It says:

Running anaconda, the Aurora Linux system installer - please wait...
install exited abnormally [1/1]
sending termination signals...done
...
etc.

The same thing happens even if I give "linux text" explicitly
on the CDROM boot command line.

I guess I have a set of 6 small frisbees now :-)
