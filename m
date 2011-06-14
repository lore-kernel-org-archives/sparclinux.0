From: John Stultz <john.stultz@linaro.org>
Date: Tue, 14 Jun 2011 16:14:35 +0000
Subject: Re: RTC problem on Netra X1?
Message-Id: <1308068075.2893.26.camel@work-vm>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, 2011-06-14 at 07:55 +0300, Meelis Roos wrote:
> > On Sat, 2011-06-11 at 19:51 +0300, Meelis Roos wrote:
> > > > > > # hwclock --systohc
> > > > > > Timed out waiting for time change.
> > > >=20
> > > > The hwclock problem seems to have apperaed between 2.6.37 and 2.6.3=
8 and=20
> > > > I will bisect it later.
> > >=20
> > > Done bisecting. Found the following patch. Reverting this patch in=20
> > > 3.0.0-rc2 fixes hwclock --systohc on my Sun Fire V100 (sparc64).
> >=20
> > I believe the following recently upstreamed fix should resolve this:
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=E17fd4ba2a81f1d29875b20464e4899185a3c946;hp=1Fa7b6a29c61358cc2=
ca6f64cef4aa0e1a7ca74c
>=20
> Yes, current git has it fixed, thanks.
>=20
> However, another RTC problem I found on Netra X1 and Fire V100 is still=20
> there:
>=20
> No RTC device found, ALARM timers will not wake from suspend

This is on a system that does have an RTC with alarm functionality?

thanks
-john





