From: Igor Kovalenko <igor.v.kovalenko@gmail.com>
Date: Thu, 28 May 2009 19:10:12 +0000
Subject: Re: silo on qemu-system-sparc64
Message-Id: <b2fa41d60905281210p4c666234t1998e778df7a4892@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b2fa41d60905271347g252290b1s2809233b081c95af@mail.gmail.com>
In-Reply-To: <b2fa41d60905271347g252290b1s2809233b081c95af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, May 28, 2009 at 1:02 AM, David Miller <davem@davemloft.net> wrote:
> From: Igor Kovalenko <igor.v.kovalenko@gmail.com>
> Date: Thu, 28 May 2009 00:47:14 +0400
>
>> The problem is with code in first-isofs/crt0.S where it tries to
>> clear BSS, it is using %i3 register value to compute address.
>> It occurs that openbios image does not really care about
>> contents of %i3 before calling loaded silo code. So %i3 can
>> have odd value and subsequent store is faulting with
>> unaligned access.
>>
>> Any hints on what does silo expect in %i3 are appreciated,
>> so we could amend openbios code to provide good initial
>> state to silo.
>
> It looks like a bug, %i3 isn't initialized to anything.
>
> It works, as you found, because openfirmware always clears
> this register upon jumping to client code. =A0And therefore
> openbios should do so as well.
>

Thanks!

By the way, currently we cannot use unoptimized openbios
builds with linux kernel because there is not enough space
for unoptimized code to store arguments. Kernel stores
arguments array in 128 bytes below stack frame whereas
at least 192 bytes are needed.

Do you think it makes sense to increase that 128 to 192 ?

--=20
Kind regards,
Igor V. Kovalenko
