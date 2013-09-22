From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sun, 22 Sep 2013 12:36:49 +0000
Subject: Re: [PATCH 0/6] Make PAGE_OFFSET variable.
Message-Id: <201691379853409@web10g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20130921.011546.399976981566163964.davem@davemloft.net>
In-Reply-To: <20130921.011546.399976981566163964.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

21.09.2013, 22:45, "Kirill Tkhai" <tkhai@yandex.ru>:
> 21.09.2013, 21:58, "David Miller" <davem@davemloft.net>:
>
>> =9AFrom: Kirill Tkhai <tkhai@yandex.ru>
>> =9ADate: Sat, 21 Sep 2013 19:34:49 +0400
>>> =9A=9ABoot tested on Sun Ultra 60 UPA/PCI (2 X UltraSPARC-II 296MHz)
>> =9AThanks a lot, can you tell me what it said early in bootup?
>>
>> =9ASpecifically this part:
>>
>> =9A[ =9A=9A=9A0.000000] PAGE_OFFSET is 0xffff800000000000 (max_phys_bits=
 =3D 47)
>>
>> =9AThanks again!
>
> I sent you email and ran away from my sparc right after that.
>
> I'll send everything tomorrow!

$ dmesg | grep PAGE
[    0.000000] PAGE_OFFSET is 0xffffff0000000000 (max_phys_bits =3D 40)

$cat /proc/cpuinfo=20
cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
pmu             : ultra12
prom            : OBP 3.11.25 1998/01/16 12:22
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
D$ parity tl1   : 0
I$ parity tl1   : 0
cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
Cpu0ClkTck      : 0000000011a4663e
Cpu2ClkTck      : 0000000011a4663e
MMU Type        : Spitfire
MMU PGSZs       : 8K,64K,512K,4MB
State:
CPU0:           online
CPU2:           online
