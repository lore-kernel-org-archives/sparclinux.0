From: Dennis Jenkins <dennis.jenkins@sbcglobal.net>
Date: Wed, 16 Mar 2005 02:27:57 +0000
Subject: Re: fc-al and A5000
Message-Id: <20050316022757.83509.qmail@web81303.mail.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050315123416.GA3857@internal>
In-Reply-To: <20050315123416.GA3857@internal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


--- Ben Collins <bcollins@debian.org> wrote:
> If anyone has information they want to dump on me
> about their experience
> in this driver and trying to get this working,
> please do so. I'm going
> into it blind, without any docs, and no reference
> point for a working
> system.

You will become my new hero. :)

I don't really have anything to offer you directly,
but I will help you test, if I can.

I have an 8 processor e3500 with 8 18.2G disks in the
built in fiber array.  It is definately a SOCAL and
not a SOC.  I am unable to access the array using any
version of Linux.  I am clueless on Solaris and can't
figure out how to download the formware to flash the
FC-AL.  I do have Solaris 10 installed on the first
fiber drive (/dev/dsk/c3t0s0d0 for me).

I run Gentoo Linux, kernel 2.4.29 (but I'll try
anything that I can get to compile), and I have GCC
3.3.5 (which can't compile a 2.2 or 2.6 kernel...). 
ps- I run Linux of a SCSI drive connected to the
non-fiber scsi chain that also has the CDROM drive on
it.

So, if you need any sort of testing or just general
info from my box let me know.  I can give you openprom
settings, part #s, diagnostics info, an account on the
box with root.  Unfortunately, I am clueless about sun
hardware.  I wish I knew how to fix the driver myself.

Good Luck!  I'll keep my figers crossed for you.


Dennis Jenkins
