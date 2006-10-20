From: Riccardo Tortorici <riccardo.tortorici@gmail.com>
Date: Fri, 20 Oct 2006 00:36:01 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <92DBBEED-562B-4BDA-BD46-DE1E6AAF3524@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On Oct 20, 2006, at 1:43 AM, Jim Watson wrote:

>
> On 20/10/2006, at 9:21 AM, Riccardo Tortorici wrote:
>
>>
>> Guys,
>> I installed the new image, this time the error does not appear,  
>> however it freezes on "Booting Linux".
>> How can I help to trace this error?
>> Regs,
>> Ric
>>
> I see the same with Jurij's new image, but it boots this way:
>
> boot:Linux video=atyfb:off
>
> same thing is seen in my own builds of 2.6.16 and 2.6.18 but not  
> seen in debian 2.6.16

Turning off FB works for me also, but only extend the agony.. :)
this time freezes on:

hda: cache flushes not supported
hda: hda1 hda2 hda3 hda4
hdc: max request size: 128KiB

Before running Jurij's image I ran 2.6.8 and everything was ok...
By the way...I get this behavior also with 2.6.16.
Regs,
Ric


- - Riccardo Tortorici -
Linux Registered User #365170
Count yourself @ http://counter.li.org/ !
- --
Encrypted Mails Welcome
GPG key: 0xF3FCE306 available on  wwwkeys.pgp.net
GPG key fingerprint = C1C4 CA17 5135 8F5C 94C2  3347 4A22 67DB F3FC E306


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Darwin)

iD8DBQFFOBnzSiJn2/P84wYRAmNeAJ9beYdGeJ4yR3CcsD3T8S7+grjH+wCgmb66
5RHqLlU7JDfUQN1Vy6Zu8WU=yphL
-----END PGP SIGNATURE-----
