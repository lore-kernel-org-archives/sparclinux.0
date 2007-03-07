From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Wed, 07 Mar 2007 14:35:11 +0000
Subject: Re: Sunfire v880
Message-Id: <a728f9f90703070635t3dcaa829v48e375bbe6d546f9@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 3/6/07, David Miller <davem@davemloft.net> wrote:
> From: "Alex Deucher" <alexdeucher@gmail.com>
> Date: Tue, 6 Mar 2007 19:49:11 -0500
>
> > Had anyone had any success booting Linux on a v880?  We've been trying
> > to get various Debian/Ubuntu/Gentoo images up and running on it for
> > the last few days, but so far no luck.  Both CD-ROM and netboot
> > produce the same results.  We updated the OBP to the lasted version.
> > We've tried the video=3Datyfb:off trick but to no avail.  All we ever
> > get is "Booting Linux..." and then nothing else.  We tried removing
> > the video card and keyboard and mouse, no difference.  Has anyone had
> > any success on the v880?  Any other things we could try?
>
> If you boot with "-p" what further messages do you get?
>

"boot net:dhcp =96p":

Error: Cheetah error trap taken afsr[ ]
Error: TPC[ ] TNPC[ ] TSTATE[ ]
Error: M_SYND(0), E_SYND(0), Privileged
Error: Highest Priority Error() "Unmapped error from system"

Then a bunch of D-cache, I-cache, and E-cache errors.

And finally,

Kernel Panic =96 not syncing: Irrecoverable deferred error trap

BTW, my co-worker eventually got a gentoo CD working (2006.1 minimal IIRC).

Alex
