From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 16 Apr 2012 20:25:03 +0000
Subject: Re: Question about hibernation on sparc64
Message-Id: <20120416202503.GA19744@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <80041334231315@web149.yandex.ru>
In-Reply-To: <80041334231315@web149.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, Apr 16, 2012 at 04:11:58PM -0400, Tom Callaway wrote:
> On 04/12/2012 03:26 PM, Sam Ravnborg wrote:
> > On Thu, Apr 12, 2012 at 07:59:57PM +0100, Alex Buell wrote:
> >> On Thu, 2012-04-12 at 12:32 -0400, David Miller wrote:
> >>> From: Kirill Tkhai <tkhai@yandex.ru>
> >>> Date: Thu, 12 Apr 2012 15:48:35 +0400
> >>>
> >>>> So I want to ask people who know sparc64 deeply. Are there any
> >>>> architecture limits which make hibernation on v9 impossible? May be
> >>>> anybody has researched this question.
> >>>
> >>> I can't think of any sparc64 hardware which would support hibernation
> >>> in any reasonable way, so I'm quite surprised that you plan on
> >>> implementing support for it.  Perhaps you can elaborate your plans :-)
> >>
> >> http://www.rugged-systems.com/p/mobilesunsolaris/0075.htm is a sparc64
> >> laptop :)
> >=20
> > I'm actually tempeted by this:
> > http://www.ebay.de/itm/Tadpole-SparcBook-s3-GX-32-mb-no-HD-or-Battery-3=
GX-free-shipping-/390406182711?pt=DE_Technik_Computer_Peripherieger%C3%A4te=
_PC_Systeme&hash=3Ditem5ae6059737#ht_3226wt_1064
> >=20
> > But I could also wait until someone donate me a not-so-power hungry spa=
rc64 box.
>=20
> I actually have one of those Tadpoles. Not sparc64. Worked last time I
> poked it, except for the video chipset and the PCMCIA.
Whenever you have some time I would be glad if you could test
a sparc32 kernel.
sparc32 (for obvious reasons) does not see much test-coverage - so a little
more would be a great help to keep the sparc32 port alive.

	Sam
