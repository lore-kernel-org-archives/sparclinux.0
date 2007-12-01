From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 01 Dec 2007 13:29:42 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.99 (Beta 2 for 3.0)
Message-Id: <1196515782.3432.38.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1196454535.3432.18.camel@localhost.localdomain>
In-Reply-To: <1196454535.3432.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Sat, 2007-12-01 at 04:12 -0800, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Fri, 30 Nov 2007 15:28:55 -0500
> 
> > - Smartd seems to make systems using the esp.ko SCSI driver very very
> > unhappy. If your system is esp based, we highly recommend that you
> > disable the smartd service in single-user before fully booting after
> > install.
> 
> Didn't we spend half of last year fixing this via my
> completely rewritten new driver? :-)

Yes, and we think it is fixed, but we were still getting erratic failure
reports, so I noted it. I think most of those failure reports were
PEBKAC, though.

> > - Systems that boot off qlogic attached disks are not supported, because 
> > there is no working firmware loader in anaconda, and the qlogic driver 
> > needs firmware.
> 
> That's very unfortunate, how are qlogic device handled on other
> platforms?

To be fair, its a Fedora/Red Hat problem. They never implemented a
firmware loader in anaconda because they thought that the only drivers
which needed userspace firmware were wireless devices (and they didn't
support wireless devices as installation mechanisms).

It works fine in after installation, but if you're trying to install to
qlogic-attached disks, the installer won't be able to get to them at
all.

Fedora is now very aware of the problem, and plans on fixing it for
Fedora 9 (which shows how very very few people were installing to qlogic
attached disks as a sole storage option).

~spot

