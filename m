From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 12 Apr 2012 23:04:53 +0000
Subject: Re: Question about hibernation on sparc64
Message-Id: <CAGRGNgUBNVFQgWOvOeUO0xQ32cT2qrB0B9oWY1VFP7kkGgxLcA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <80041334231315@web149.yandex.ru>
In-Reply-To: <80041334231315@web149.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Sam,

On Fri, Apr 13, 2012 at 05:26, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Thu, Apr 12, 2012 at 07:59:57PM +0100, Alex Buell wrote:
>> On Thu, 2012-04-12 at 12:32 -0400, David Miller wrote:
>> > From: Kirill Tkhai <tkhai@yandex.ru>
>> > Date: Thu, 12 Apr 2012 15:48:35 +0400
>> >
>> > > So I want to ask people who know sparc64 deeply. Are there any
>> > > architecture limits which make hibernation on v9 impossible? May be
>> > > anybody has researched this question.
>> >
>> > I can't think of any sparc64 hardware which would support hibernation
>> > in any reasonable way, so I'm quite surprised that you plan on
>> > implementing support for it. =A0Perhaps you can elaborate your plans :=
-)

I would guess that it would be possible to implement it 100% in
software - it is essentially just dumping ram to disk and powering
off. That said, I'm not sure what role the hardware, say, on x86 has
to play in facilitating that.

>> http://www.rugged-systems.com/p/mobilesunsolaris/0075.htm is a sparc64
>> laptop :)
>
> I'm actually tempeted by this:
> http://www.ebay.de/itm/Tadpole-SparcBook-s3-GX-32-mb-no-HD-or-Battery-3GX=
-free-shipping-/390406182711?pt=DE_Technik_Computer_Peripherieger%C3%A4te_P=
C_Systeme&hash=3Ditem5ae6059737#ht_3226wt_1064

The legendary tadpole! I'd be tempted too =3D)

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
