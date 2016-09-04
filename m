From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 04 Sep 2016 06:28:13 +0000
Subject: Re: sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <193016ad-1b0d-50f1-44b8-ee34dbc2924b@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
 <2179bf7c-9878-adf7-da97-2746d5aa3d34@users.sourceforge.net>
 <CAGRGNgWXdzvfL4wdM2uQr7DRbJgCuY0O-jRmSGhqfbPBZGS2Aw@mail.gmail.com>
 <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
 <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
 <ec58924c-25d6-e525-fb8a-35bdbf6a8f12@users.sourceforge.net>
 <CAGRGNgWAx69N81e_9Ay3N2m03ZAa14ckW+62tHZSJ+4oky6VPA@mail.gmail.com>
 <1af7e987-0233-f972-6c00-6d5e00898188@users.sourceforge.net>
 <CAGRGNgWgf--hWusUadBQWeC64Rt3srwGqxLLdLzDv1dMXC_kxw@mail.gmail.com>
In-Reply-To: <CAGRGNgWgf--hWusUadBQWeC64Rt3srwGqxLLdLzDv1dMXC_kxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Julian Calaby <julian.calaby@gmail.com>
Cc: sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

>> Which test environments would you find acceptable for further clarificat=
ion?
>=20
> Compiling it on GCC for Sparc, obviously.

Are there any more configuration details to consider?


>>> I must also point out that these sorts of optimisations are things the
>>> compiler does automatically when compiling this code.
>>
>> Do you take this detail for granted?
>=20
> I trust that the GCC developers have done their work well.

Will any more compiler implementations matter here?

Do you like software which can run better by default also without applicati=
on
of special compilation parameters?


> I'm looking for some glimmer of usefullness in this patch. I'm not seeing=
 any.

Thanks for your honest feedback.


>> Should we avoid to compare software things similar to "apples" and "oran=
ges"
>> (while these fruits can make more fun)?   ;-)
>=20
> Write a benchmark that exercises this function. Measure the time it
> took without this change, measure the time it took with this change,
> is there a difference.

Is an accepted test system already available for the purpose that every com=
mit
would be checked in the way automatically you expect here?


> You cannot expect people to take you seriously if you're proposing
> performance changes without any actual ability or interest in
> producing performance related data to go along with them.

I suggested small changes which I found "logical".


> You're essentially saying "I think doing things this way is better"

Yes =E2=80=A6


> and providing _nothing_ else.

You might be looking for more information than I can practically give you
at the moment.


> I think that things are perfectly fine the way they are.

I have got an other impression for "perfection" in this software module.
I found an implementation detail for further considerations.


> Convince me with data or something else.

I imagine that the "else" can become harder than you find reasonable.


> Did someone do this to some other driver and you're applying the same fix=
 elsewhere?

Is a similar software development discussion still running for other module=
s?


> You are the only person proposing changes like these ones as you are

I am picking special software improvement opportunities up.


> (as far as I know) the only person who thinks they have any value.

I can accept that the value of specific changes will usually be categorised
as lower than updates that you prefer so far.

Regards,
Markus
