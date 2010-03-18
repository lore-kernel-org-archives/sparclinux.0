From: Matthew Wilcox <matthew@wil.cx>
Date: Thu, 18 Mar 2010 18:49:52 +0000
Subject: An fc4 user appears
Message-Id: <20100318184952.GB3875@parisc-linux.org>
List-Id: <sparclinux.vger.kernel.org>
References: <17772.86388.qm@web52601.mail.re2.yahoo.com> <876254.4671.qm@web52601.mail.re2.yahoo.com> <20100317095222.GA16828@orion.carnet.hr>
In-Reply-To: <20100317095222.GA16828@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josip Rodin <joy@entuzijast.net>
Cc: Mr Ian Primus <ian_primus@yahoo.com>, debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

On Wed, Mar 17, 2010 at 10:52:22AM +0100, Josip Rodin wrote:
> On Tue, Mar 16, 2010 at 06:16:05PM -0700, Mr Ian Primus wrote:
> > So, now I have Linux installed. Next task: getting the fibre channel
> > working. I'm currently digging through the configuration options on the
> > kernel. (Downloaded 2.6.33.1 from kernel.org) I can't for the life of me
> > find the Sun fibre channel driver. I could have sworn it was SOC or
> > something like that...
> 
> On Tue, Mar 16, 2010 at 06:46:56PM -0700, Mr Ian Primus wrote:
> > Doing some more digging, it seems that the Sun fibre channel driver is
> > missing from recent versions of the kernel, the newest one I've been able
> > to find that contains it is 2.6.23. On this kernel, it's in drivers/fc4,
> > and Fibre Channel support is a menu option right in the main menu after
> > make menuconfig. I can't find this driver in the newer kernels. Does
> > anyone know what happened to it? Did it get merged in with another driver?
> > 
> > I really want to get this A5000 working :)
> 
> fc4 was removed in October 2007 with this commit:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;hcd3902c6e16c2445165b872c49e73770b72da7

Yep, I removed it.  Resurrecting it will be quite a task.  Best of luck.
I'm willing to answer questions (please cc linux-scsi), but not do
the work.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
