From: Morey Roof <moreyroof@gmail.com>
Date: Sun, 10 Jul 2005 02:35:20 +0000
Subject: Re: Flashing of an Ultra2?
Message-Id: <91a37e8905070919357fc96b42@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200507091845.j69IjwBL027851@arbas.nms.ulrich-teichert.org>
In-Reply-To: <200507091845.j69IjwBL027851@arbas.nms.ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I had the same problem and tried about everything I could think of to
work around it, but I couldn't get it to work over the network.  So,
the only way to do it was off of a ufs partition.  I have no idea why
it seems to only work there.

On 7/9/05, Ulrich Teichert <krypton@ulrich-teichert.org> wrote:
> Hi Baurzhan,
>=20
> [del]
> >> Now, more questions: would it be possible to use the PROM flashing mod=
ule
> >> from Linux?
> >
> >I would try creating a partition with a ufs filesystem, copying the
> >binary to that filesystem and booting from that partition.
> [del]
>=20
> Why should the outcome differ from booting the same file from the network?
> Anyway, I'll try it out tomorrow,
>=20
> CU,
> Uli
> --
> Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
> Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
> 24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Op=E9rati=
on S)
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
