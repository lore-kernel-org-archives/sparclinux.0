From: Frans van Berckel <fberckel@xs4all.nl>
Date: Wed, 17 Mar 2010 02:31:58 +0000
Subject: Re: Debian Sparc 5.4 on Sun blade 2500
Message-Id: <b68cf125aa4c0bf86e0db2bb16c5173f@xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
In-Reply-To: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Petr, thanks for your input. Wanna go into it the next ... day.

On Wed, 17 Mar 2010 00:00:18 +0100, Petr Vyslouzil <petrv@ipe.muni.cz>
wrote:
> [ Debian mail lists don't like images in attachments? Try #2 with
.tar.gz]
>=20
>=20
> Hello Frans & all,
>=20
> Just to fast forward the bug tracking a tiny bit, here are some
references:
>=20
> * (incorrect) card detection should not be the problem[1]
> * Jo=C3=ABl Bertrand's attempt to get XVR-500 work on SB 2000[2]
> * the problem with black strips on screen described below (it was a
private
> discussion, but I hope and believe Guillaume wouldn't mind to post it
here
> as it
> doesn't contain anything confidential or personal)
> * there could be a working XVR-[56]00 driver for X11 in OpenBSD 4.5[3],
but
>   I cannot confirm or deny it. Could anybody try it out and report if it
>   works?
>   ATM I don't have a free sparc to test it on.
>   Sadly, Opensolaris can't help us much as only XVR-100 is going to be
>   opensourced, while XVR-[56]00 will stay closed due to Wildcat's IP.
>=20
>=20
> Regards,
> 	Petr
>=20
> [1] http://lists.debian.org/debian-sparc/2008/12/msg00002.html
> [2] http://lists.debian.org/debian-sparc/2009/05/msg00090.html
> [3] http://opensolaris.org/jive/thread.jspa?messageID64919
>=20
>=20
>=20
>=20
>> From: [ UNDISCLOSED SENDER ]
>> To: ptrv@email.cz
>> Subject: Debian and XVR 500
>> Date: Wed, 21 Oct 2009 00:31:21 +0200 (CEST)
>>
>> Hi Petr,
>>
>> I'm carefully reading this thread where you try to make your XVR-500
>> video
>> card work with Debian.
>>
>> Today I'm experiencing the same issue, that prevent me to install
Debian
>> Lenny on my Blade 2000 with 2 XVR-500 Video Card.
>>
>> Would you be kind enough to tell if you achieved this installation ?
Was
>> it
>> necessary to use dedicated kernel for this purpose ? As of today, do
you
>> know if XVR 500 support is included in the compiled kernel ?
>>
>> Thank you very much in advance, your reply will help a lot.
>>
>> Guillaume
>>
>>
>>
>>> Hello Guillaume,
>>>
>>> first of all, please note that I've had Blade 2500 (with OBP version
>>> 4.16.4), not 2000. Maybe it doesn't matter, but you can never know -
>>> Linux
>>> SPARC drivers aren't tested as well as their x86 counterparts.
>>>
>>> Lenny 5.0.2 works for me out of the box (=3D without any boot parameters
>>> it
>>> switches into nice high-resolution graphics mode) so yes, the XVR-500
>>> driver is compiled in.
>>>
>>> If you're out of luck even with the recent *stable* Debian release,
try
>>> boot
>>> with parameter DEBIAN_FRONTEND=3Dnoninteractive. This switch Debian
>>> installer
>>> into "numbered lines mode" menus so you'll be able to navigate simply
by
>>> entering a number of an appropriate line you're gonna choose.
>>>
>>> Hope it helps.
>>>
>>> Regards,
>>> Petr
>>>
>>> ps.: just a side note, as I've also needed working X11, I quite
cheaply
>>> bought a XVR-100 (a.k.a ATI Radeon with SUN firmware) and it works
nice.
>>> Speed is not stellar, but for most common (graphics) programs it's
good
>>> enough.
>>>
>>>
>>>
>>>> Hi Petr,
>>>>
>>>> Thanks for your quick reply. Following this message, I tried the
Debian
>>>> (5.0.3) installation this week end. After an issue with the non
>>>> recognized
>>>> FC-AL hard drive, I finally went through.
>>>>
>>>> The graphic display works, but is completely unusable, because of
black
>>>> lines in the middle of the screen. I think the 2 XVR-500 card are a
>>>> possible reason for this, so I still need to investigate.
>>>>
>>>> I also wonder if your were successful to change the resolution (Only
>>>> the
>>>> default 1280 * 1024 is available as of now) ?
>>>>
>>>> Best Regards,
>>>> Guillaume
>>>>
>>>>
>>>>> Hi again,
>>>>>
>>>>> Just for information. I attached a copy of my screen after debian
>>>>> install.
>>>>>
>>>>> Guillaume
>>>>>
>>>>>
>>>>>
>>>>>> Hi Guillaume,
>>>>>>
>>>>>> I didn't try hard running X11 (with xvr500). I guess you use fb
>>>>>> driver
>>>>>> or has Xorg released a XVR compatible driver I'm not aware of?
>>>>>> Looking into guts of the driver[1] I suppose the resolution is
>>>>>> hardwired
>>>>>> for now. Do those strange black lines happen even if your xorg
>>>>>> config has
>>>>>> the same resolution as kernel driver? Have you already tried to use
>>>>>> only
>>>>>> one XVR500 card? Try to contact David on Debian-sparc or kernel
mail
>>>>>> list,
>>>>>> maybe he could help.
>>>>>>
>>>>>> Regards,
>>>>>> Petr
>>>>>>
>>>>>> [1] http://lxr.linux.no/#linux+v2.6.31/drivers/video/sunxvr500.c
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Indeed I understood it lately. The driver is the default fbdev
>>>>>>> provided
>>>>>>> with Debian.
>>>>>>>
>>>>>>> I cannot change the resolution (from xorg.cong), so all tests used
>>>>>>> native 1280*1024. I also supposed that the probleme may come from
>>>>>>> an inappropriate sync frequency for the monitor,but it wasn't
>>>>>>> succesfull.
>>>>>>> I also removed the second XVR-500 to avoid any conflict between
>>>>>>> cards,
>>>>>>> without any result.
>>>>>>>
>>>>>>> X is mandatory for me. I can administrate the workstation from the
>>>>>>> command line but browsing the web is a bit more tricky.
>>>>>>>
>>>>>>> I will forward this conversation to David to get his opinion on
>>>>>>> this,
>>>>>>> I think he's clearly aware of this issue.
>>>>>>>
>>>>>>> Guillaume,
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> From: davem@davemloft.net
>>>>>>>> Well:
>>>>>>>>
>>>>>>>> 1) Never email me privately, we have a mailing list for users
>>>>>>>>    to ask questions on, sparclinux@vger.kernel.org
>>>>>>>>
>>>>>>>>    And if you post there, then other developers and users
>>>>>>>>    can answer your question when I am very busy with other
>>>>>>>>    tasks like I am now.
>>>>>>>>
>>>>>>>> 2) XVR-500 is not supported with X at the moment, sorry.
>>>>>>>>    The Linux console driver itself was completely reverse
>>>>>>>>    engineered, so you should be happy even that works.
>>>>>>>>
>>>>>>>>    Use a Radeon or ATI mach64 based card in your machine if
>>>>>>>>    you want X.
>>>>>>>>
