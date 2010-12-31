From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 31 Dec 2010 11:27:17 +0000
Subject: Re: [PATCH 0/5] sparc: piggyback update
Message-Id: <AANLkTikX1JPV=PdH2G-1G3PWs2077nuzEx6-xW3Mm+u=@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20101231093628.GA19496@merkur.ravnborg.org>
In-Reply-To: <20101231093628.GA19496@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, Dec 31, 2010 at 22:18, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> My idea was to create a unified piggyback that took $BITS as an
>> argument - then did sensible things based upon that. It never got off
>> the ground here.
>
> Rather then doing code-chrunch in piggyback_64 we should add this
> extra argumant and then let piggyback_32 handle both the 32 and 64 bit
> case.
>
> The few things that differs is:
> 1) Check lookup of _start, _end
> 2) Start address of added image is on different addrees alignemnts (4096 =
/ 8192)

I've got a patch to factor this out.

> 3) sparc64 uses host endian when it stores data in the image (looks lige =
a bug)

It is, I have a patch to fix this. - I'll post it soon.

> 4) sparc64 updates a_text, a_data and a_bss in the a.out header - sparc32=
 does not.
> =A0 And I could not figure out the expression used to calculate a_text va=
lue..

hehehe I never got that far - I essentially abandoned my attempt when
I saw that _64 was doing stuff that _32 wasn't.

> All in all simple differences.
> But as my sparc64 box is not yet alive I postponed it until
> I could actually test it.

I have a live sparc64 box, however it's currently in a pile of dead
sparc32 and 64 boxen, and hasn't been booted for a long time. So it's
not exactly accessible - that and I've lost my last real serial port
so I can't actually talk to it anymore. (and the expresscard one I
obtained for my laptop doesn't work properly for some reason -
fricking cheap serial chipsets)

I'll have a go at making it work soon, and see if I can get this going.

In the mean time, I'll send that patch and anything else I've got that
looks promising.

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
