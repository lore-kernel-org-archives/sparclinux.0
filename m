From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 09 Mar 2007 21:53:46 +0000
Subject: Re: Dead lock with 2.6.20
Message-Id: <45F1D76A.1070307@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <45F1C172.60103@systella.fr>
In-Reply-To: <45F1C172.60103@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Daniel Smolik a =E9crit :
>>> I have similar problem on E450 tomorrow. After each second reboot=20
>>> system hang and I can't STOP-A. Only power-off helps. System hang=20
>>> after udev insert sg module. I disable udev  and this solve my problem.
>>
>>
>>     Do you think that /etc/init.d/udev stop can solve this trouble ?
> I turn off udev now and it helps.  Test if have or not inserted sg module.

fermat:[~] > lsmod | grep sg
sg                     42224  0

	I have turned off udev to test.

	JKB
