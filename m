From: Igor Kovalenko <igor.v.kovalenko@gmail.com>
Date: Sun, 06 Dec 2009 17:37:03 +0000
Subject: Re: sparc64 mcount misaligned stack
Message-Id: <b2fa41d60912060937u6e7011d5if491d89e711e11@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b2fa41d60912051427y546958a4q729877dd7a970a79@mail.gmail.com>
In-Reply-To: <b2fa41d60912051427y546958a4q729877dd7a970a79@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sun, Dec 6, 2009 at 7:18 AM, David Miller <davem@davemloft.net> wrote:
> From: Igor Kovalenko <igor.v.kovalenko@gmail.com>
> Date: Sun, 6 Dec 2009 01:27:08 +0300
>
>> I wonder if mcount ever works on sparc64, if it does work indeed I'd
>> like to know what I'm missing there.
>
> Yep, two distinct bugs there. =A0Please try this patch, thanks
> for the report.

Works here, thanks!

- does not trap too early
- prints "Stack overflow" and exits to prom without fault (I tried
removing STACK_BIAS adjustment to make it trap)

--=20
Kind regards,
Igor V. Kovalenko
