From: John Stultz <john.stultz@linaro.org>
Date: Mon, 13 Jun 2011 20:52:48 +0000
Subject: Re: RTC problem on Netra X1?
Message-Id: <1307998368.2893.5.camel@work-vm>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sat, 2011-06-11 at 19:51 +0300, Meelis Roos wrote:
> > > > # hwclock --systohc
> > > > Timed out waiting for time change.
> >=20
> > The hwclock problem seems to have apperaed between 2.6.37 and 2.6.38 an=
d=20
> > I will bisect it later.
>=20
> Done bisecting. Found the following patch. Reverting this patch in=20
> 3.0.0-rc2 fixes hwclock --systohc on my Sun Fire V100 (sparc64).

I believe the following recently upstreamed fix should resolve this:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=E17fd4ba2a81f1d29875b20464e4899185a3c946;hp=1Fa7b6a29c61358cc2ca6f=
64cef4aa0e1a7ca74c

Please let me know if Linus' current -git tree doesn't work.

thanks
-john


