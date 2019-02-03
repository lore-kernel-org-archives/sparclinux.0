From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sun, 03 Feb 2019 02:47:20 +0000
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Message-Id: <CABeXuvrf_s_LzwYy5p_gqw+PU70OnFAntdtyazN+CBAbyS07TA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-13-deepa.kernel@gmail.com>
 <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
In-Reply-To: <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Network Devel Mailing List <netdev@vger.kernel.org>, Helge Deller <deller@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org, cluster-devel <cluster-devel@redhat.com>, ccaulfie@redhat.com, Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>

On Sat, Feb 2, 2019 at 9:15 AM Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
>
> Hi all,
>
> On 02.02.19 16:34, Deepa Dinamani wrote:
> > Add new socket timeout options that are y2038 safe.
> (..)
> >
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/=
uapi/asm/socket.h
> > index 9826d1db71d0..0d0fddb7e738 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -119,19 +119,25 @@
> >   #define SO_TIMESTAMPNS_NEW      64
> >   #define SO_TIMESTAMPING_NEW     65
> >
> > -#if !defined(__KERNEL__)
> > +#define SO_RCVTIMEO_NEW         66
> > +#define SO_SNDTIMEO_NEW         67
> >
> > -#define      SO_RCVTIMEO SO_RCVTIMEO_OLD
> > -#define      SO_SNDTIMEO SO_SNDTIMEO_OLD
> > +#if !defined(__KERNEL__)
> >
> >   #if __BITS_PER_LONG =3D=3D 64
> >   #define SO_TIMESTAMP                SO_TIMESTAMP_OLD
> >   #define SO_TIMESTAMPNS              SO_TIMESTAMPNS_OLD
> >   #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> > +
> > +#define SO_RCVTIMEO          SO_RCVTIMEO_OLD
> > +#define SO_SNDTIMEO          SO_SNDTIMEO_OLD
>
> Maybe I'm a bit late in this discussion as you are already in v5 ...
>
> I can see patches making the transition in different steps where it
> might be helpful to name them *_OLD and *_NEW to understand the patches.
>
> But in the end the naming stays in the kernel for a very long time and I
> remember myself (in early years) to name things 'new', 'new2', 'new3'.
>
> In fact SO_TIMESTAMP_OLD should be named SO_TIMESTAMP32 and
> SO_TIMESTAMP_NEW should be named SO_TIMESTAMP64.

Hmm. SO_TIMESTAMP_OLD uses 64-bit time_t on a 64 bit machine. In fact,
there is no difference between the two options on a 64 bit machine. So
using  SO_TIMESTAMP_32 is just wrong.

Likewise, SO_TIMESTAMP_64 naming somehow indicates that the existing
one was not, and that is also not true on a 64-bit machine.

Further, userspace will still continue to use SO_TIMESTAMP and the
macros take care of which option to select internally.

Moreover, these macros have been there for more than ten years
(introduced before 2.4) and there has been no change. I doubt you will
ever have NEW2.
I think this argument is similar to saying don=E2=80=99t name these macros
SO_TIMESTAMP because there might be SO_TIMESTAMP1 some day. There is
never a perfect name. SO_TIMESTAMPING is also not really descriptive.

> Especially as it tells you what is 'inside', the naming of these new intr=
oduced constants should be replaced with *32 and *64 names.
> The documentation and the other comments still fit perfectly then.

I would prefer not to do this, for reasons mentioned above. Since you
point out that it is easier to use this naming for intermediate steps,
I suggest that we leave the series as it is.
If you feel strongly to post a follow-on renaming patch, you could
discuss it with the subsystem maintainers, if you think there is a
correct but more descriptive naming.

-Deepa

> Regards,
> Oliver
