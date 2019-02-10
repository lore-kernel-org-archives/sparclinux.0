From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Sun, 10 Feb 2019 09:17:42 +0000
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5 minute delay during boot on Su
Message-Id: <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
In-Reply-To: <1549736341.2971.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sat, 2019-02-09 at 18:04 +0100, Mikael Pettersson wrote:
> > 4.20 and earlier kernels boot fine on my Sun Blade 2500 (UltraSPARC
> > IIIi), but the 5.0-rc kernels consistently experience a 5 minute
> > delay
> > late during boot, after enabling networking but before allowing user
> > logins.  E.g. 5.0-rc5 dmesg has:
> >
> > [Fri Feb  8 17:13:17 2019] random: dbus-daemon: uninitialized urandom
> > read (12 bytes read)
> > [Fri Feb  8 17:18:14 2019] random: crng init done
>
> I've had the same problem on several of my test systems.  Are you sure
> it's not this bug report:
>
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=912087
>
> ?
>
> The solution for me was to install the haveged package which does
> active entropy gathering during boot and can make /dev/urandom
> available much earlier.

Thanks for the hint, I'll look into using haveged on this machine.

>
> > During this interval the machine answers pings but won't allow user
> > logins either on the console or over the network.
> >
> > A git bisect identified commit
> > f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Thu Nov 1 16:36:27 2018 -0600
> >
> >     scsi: kill off the legacy IO path
> >
> > as the point where this 5m delay was introduced.
>
> I think the reason for this is that the block mq path doesn't feed the
> kernel entropy pool correctly, hence the need to install an entropy
> gatherer for systems that don't have other good random number sources.

That does sound plausible, I admit I didn't even consider the possibility t=
hat
the old block I/O path also was an entropy source.

/Mikael
