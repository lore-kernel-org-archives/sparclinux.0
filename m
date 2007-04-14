From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sat, 14 Apr 2007 17:08:19 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.98 (Beta 1 for 3.0)
Message-Id: <f43fc5580704141008h3d710415t8df68721d7b4d730@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1175577171.3531.131.camel@localhost.localdomain>
In-Reply-To: <1175577171.3531.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > I'm testing the Aurora CDROM on Qemu (current CVS version). The
> > install seems to run fine, but at start Qemu gives the following error
> > messages a few times:
> > scsi-disk: Inquiry buffer too small (4)
> >
> > Maybe this message is related to esp errors?
>
> I don't think so, my Ultra60 installed perfectly fine and that
> uses scsi too.
>
> What kind of scsi device does qemu emulate?

ESP (NCR53C90) controller, basic scsi disks and cdrom. The machine is
close to a Sparcstation 5.
