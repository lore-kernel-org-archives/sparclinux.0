From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 12 Mar 2007 09:33:54 +0000
Subject: Re: Dead lock with 2.6.20
Message-Id: <45F51E82.2000403@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <45F1C172.60103@systella.fr>
In-Reply-To: <45F1C172.60103@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Daniel Smolik a =E9crit :
> BERTRAND Jo=EBl napsal(a):
>> Daniel Smolik a =E9crit :
>>
>>> BERTRAND Jo=EBl napsal(a):
>>>
>>>>     Hello,
>>>>
>>>>     I have seen a very strange deadlock on a UltraSPARC 2=20
>>>> workstation (2 UltraSPARC-II/296 MHz, 2048 MB, framebuffer Creator3D=20
>>>> on UPA slot, 2 73 GB SCA disks that form a raid1 array).
>>>>
>>>>     Hardware sounds good and I have tested it with SUNvts during two=20
>>>> days without any failure.
>>>>
>>>>     This workstation is a mail server and runs with Debian/testing,=20
>>>> kernel 2.6.20. It's a NIS and NFSv3/TCP clients. Its uptime was more=20
>>>> than 9 days and it hangs without any message in the log, without=20
>>>> panic and without oops. When it hangs, the queue of sendmail was=20
>>>> about 3 GB due to a failure of a internet peering. I have rebooted=20
>>>> the workstation (power button :-( ). You can find my .config at
>>>>
>>>> http://rayleigh.systella.fr/~bertrand/config-sun4u-2.6.20.gz
>>>>
>>>>     I don't know how debug this bug...
>>>
>>> Hi,
>>> do you have attached console ?
>>
>>
>>     No... I don't have any console.
>>
>>> Do you try STOP-A ?
>>
>>
>>     Stop+A doesn't help. I have tried, of course ;-)
>>
>>> I have similar problem on E450 tomorrow. After each second reboot=20
>>> system hang and I can't STOP-A. Only power-off helps. System hang=20
>>> after udev insert sg module. I disable udev  and this solve my problem.
>>
>>
>>     Do you think that /etc/init.d/udev stop can solve this trouble ?
> I turn off udev now and it helps.  Test if have or not inserted sg module.

	Some news.

1/ I have built a monolithic 2.4.34.1 kernel. With this kernel, I only=20
see a "kernel unaligned trap" but not any dead lock. After this trap,=20
kernel hangs but the U2 can be restarted with stop+A ;
2/ I have tested hardware with SUNvts and it sounds good ;
3/ I'm building a 2.6.20.2 with all debug options to debug ;
4/ I have tried without udev, sg, and success.

	Regards,

	JKB
