From: "Eric Brower" <ebrower@gmail.com>
Date: Fri, 17 Mar 2006 21:08:09 +0000
Subject: Re: bbc, envctrl and sun blade 2000
Message-Id: <ec7cefb0603171308k5c293c5fpbed8a6f19a43cd65@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87k6auqm68.fsf@thorr.asgardr.info>
In-Reply-To: <87k6auqm68.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 3/17/06, Daniel 'NebuchadnezzaR' Dehennin <sparc@asgardr.info> wrote:
> Le 4580 Septembre 1993, Eric Brower a tapot=E9:
> > The envctrl module is not suitable for your SB2000 system-- the
> > version currently in 2.6.x supports only the
> > CP1400/CP1500/Netra-T1/105 plaform.  I -think- you want bbc only.
>
> Ok, thanks a lot. is there a way to get infos about temperature and
> fans speed ?

The current bbc driver does not export this information to userspace.=20
It should be straightforward to implement, though.

E

>
> Regards.
> --
> Daniel 'NebuchadnezzaR' Dehennin
> R=E9cup=E9rer ma clef GPG:
> gpg --keyserver pgp.mit.edu --recv-keys 0x2A408F69
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
E
