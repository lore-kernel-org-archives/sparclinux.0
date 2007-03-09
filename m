From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 09 Mar 2007 21:49:32 +0000
Subject: Re: Dead lock with 2.6.20
Message-Id: <45F1D66C.6030703@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <45F1C172.60103@systella.fr>
In-Reply-To: <45F1C172.60103@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl napsal(a):
> Daniel Smolik a =E9crit :
>=20
>> BERTRAND Jo=EBl napsal(a):
>>
>>>     Hello,
>>>
>>>     I have seen a very strange deadlock on a UltraSPARC 2 workstation=20
>>> (2 UltraSPARC-II/296 MHz, 2048 MB, framebuffer Creator3D on UPA slot,=20
>>> 2 73 GB SCA disks that form a raid1 array).
>>>
>>>     Hardware sounds good and I have tested it with SUNvts during two=20
>>> days without any failure.
>>>
>>>     This workstation is a mail server and runs with Debian/testing,=20
>>> kernel 2.6.20. It's a NIS and NFSv3/TCP clients. Its uptime was more=20
>>> than 9 days and it hangs without any message in the log, without=20
>>> panic and without oops. When it hangs, the queue of sendmail was=20
>>> about 3 GB due to a failure of a internet peering. I have rebooted=20
>>> the workstation (power button :-( ). You can find my .config at
>>>
>>> http://rayleigh.systella.fr/~bertrand/config-sun4u-2.6.20.gz
>>>
>>>     I don't know how debug this bug...
>>
>> Hi,
>> do you have attached console ?
>=20
>=20
>     No... I don't have any console.
>=20
>> Do you try STOP-A ?
>=20
>=20
>     Stop+A doesn't help. I have tried, of course ;-)
>=20
>> I have similar problem on E450 tomorrow. After each second reboot=20
>> system hang and I can't STOP-A. Only power-off helps. System hang=20
>> after udev insert sg module. I disable udev  and this solve my problem.
>=20
>=20
>     Do you think that /etc/init.d/udev stop can solve this trouble ?
I turn off udev now and it helps.  Test if have or not inserted sg module.

				Dan






