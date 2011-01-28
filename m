From: David Miller <davem@davemloft.net>
Date: Fri, 28 Jan 2011 23:03:34 +0000
Subject: Re: [PATCH v3] SPARC: added U-Boot build target: uImage
Message-Id: <20110128.150334.245395629.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059795-22807-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059795-22807-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: daniel@gaisler.com
Date: Wed, 26 Jan 2011 15:37:22 -0500

>=20
>=20
> On Wed, 26 Jan 2011 21:10:37  0100, Sam Ravnborg  wrote:
> On Wed, Jan 26, 2011 at 05:36:35PM  0100, Daniel Hellstrom wrote:
>  > > This is only for LEON as u-boot for SPARC only supports LEON.   > >
>  > > Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>  >
>  > Looks good.   > Acked-by: Sam Ravnborg <sam@ravnborg.org>
>  >
>  > A general note about patch subjects.   >
>  > I have started to use the following conventions for
>  > patch subjects:
>  >
>  > sparc: bla         <=3D stuff that is relevant for sparc32 and sparc64
>  > sparc32: bla       <=3D sparc32 specific stuff
>  > sparc64: bla       <=3D sparc64 specific stuff
>  > sparc32,leon: bla  <=3D leon specific stuff (on sparc32)
>  > sparc32,sun4m: bla <=3D sun4m specific stuff (on sparc32)
>  >
>  > I try to find something useful as "bla" - this is sometimes
>  > defficult..  >
>  > If I could convince you to use same syntax we could get
>  > a bit more consistency in the patch subjects.   =A0
>  =A0
>  Sounds reasonable, will adopt to that.. hopefully others will do
>  too... :)

I've applied this patch to sparc-next-2.6, and to get the ball rolling
I changed your subject line to read "sparc32: " instead of "SPARC: "

Thanks.
