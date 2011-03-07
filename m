From: Marcel van Nies <morcles@gmail.com>
Date: Mon, 07 Mar 2011 07:07:38 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq support]
Message-Id: <AANLkTim8AFRwDWUF4Q6osgj9j=+Ai7w9kD53=HMsexyZ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

> You shouldn't have to go back that far...  I was last running 2.6.22 on
> hyperSPARC successfully.  Ok, maybe that's not so helpful as it looks
> like it's been a while since I've built a sparc kernel.  Probably time
> for me to also try out a new kernel.

2.6.32 is fine too:
Linux ross 2.6.32.27-up #2 Sun Mar 6 23:05:25 CET 2011 sparc sun4m
ROSS HyperSparc RT625 or RT626 GNU/Linux

Today, I'll try to find out which commit causes the problems.

Marcel


On Sun, Mar 6, 2011 at 10:11 PM, Bob Breuer <breuerr@mc.net> wrote:
> Josip Rodin wrote:
>> On Sun, Mar 06, 2011 at 10:13:56AM +0100, Marcel van Nies wrote:
>>> The hyperSPARC gives the same error without the final genirq patch.
>>>
>>> On Sun, Mar 6, 2011 at 8:23 AM, Marcel van Nies <morcles@gmail.com> wro=
te:
>>>> The hyperSPARC boots, but fails when starting init. It runs fine on 2.=
6.17.
>>
>> I realize that it may be a difficult proposition, but you could try to
>> git bisect it.
>>
>> Did you try it on anything after 2.6.17, maybe that narrows it down furt=
her?
>>
>
> You shouldn't have to go back that far... =A0I was last running 2.6.22 on
> hyperSPARC successfully. =A0Ok, maybe that's not so helpful as it looks
> like it's been a while since I've built a sparc kernel. =A0Probably time
> for me to also try out a new kernel.
>
> Bob
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
