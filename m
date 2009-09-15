From: =?ISO-8859-15?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
Date: Tue, 15 Sep 2009 10:05:30 +0000
Subject: Re: Sparc release requalification
Message-Id: <4AAF66EA.9010409@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: Josip Rodin <joy@entuzijast.net>
> Date: Mon, 14 Sep 2009 14:40:22 +0200
>
>  =20
>> On Mon, Sep 14, 2009 at 02:36:48PM +0200, Josip Rodin wrote:
>>    =20
>>>>> 2) Try a UP kernel build, does it work even with all of the NMI
>>>>>    bits enabled on this machine?
>>>>>          =20
>>>> Will try and report shortly.
>>>>        =20
>>> It seems to work just fine without SMP.
>>>      =20
>> Just in case it might matter:
>>    =20
>
> I was able to reproduce the hang with your originally posted config.
>
> It only triggers when CONFIG_PROM_CONSOLE is enabled, I keep telling
> people to turn it off.  Nobody should be using it, it either breaks
> things or it slows the console down considerably.
>
> That's it, I'm completely removing that driver from the tree this
> merge window, so you guys can't mess it up any more even if you want
> to :-)
>
>
>  =20
Very good news.
I had a lot of trouble because of this.
I had to disable it for initcall_debug to work, but then, any kernel=20
patched or not was working.
I thought I messed up between patches and built kernels.
I realize now that I had the explanation under my nose.
Duh....

    Seb

