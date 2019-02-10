From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sun, 10 Feb 2019 15:44:32 +0000
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5 minute delay during boot on Su
Message-Id: <1549813472.4142.3.camel@HansenPartnership.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
         <1549736341.2971.7.camel@HansenPartnership.com>
         <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
In-Reply-To: <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpelinux@gmail.com>
Cc: Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
> On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > I think the reason for this is that the block mq path doesn't feed
> > the kernel entropy pool correctly, hence the need to install an
> > entropy gatherer for systems that don't have other good random
> > number sources.
> 
> That does sound plausible, I admit I didn't even consider the
> possibility that the old block I/O path also was an entropy source.

In theory, the new one should be as well since the rotational entropy
collector is on the SCSI completion path.   I'd seen the same problem
but had assumed it was something someone had done to our internal
entropy pool and thus hadn't bisected it.

James
