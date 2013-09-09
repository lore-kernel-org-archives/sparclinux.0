From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 09 Sep 2013 14:50:00 +0000
Subject: Re: [RFC] sparc64: Duplicate kernel text on every NUMA node
Message-Id: <67101378738200@web27j.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <8311377178790@web14g.yandex.ru>
In-Reply-To: <8311377178790@web14g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

23.08.2013, 22:08, "David Miller" <davem@davemloft.net>:

> =9A=9AFrom: Kirill Tkhai <tkhai@yandex.ru>
> =9A=9ADate: Fri, 23 Aug 2013 19:43:56 +0400
>> =9A=9A=9AIt looks like nobody supports this. I saw an old patch for x86
>> =9A=9A=9A(https://lkml.org/lkml/2003/6/16/226) and several others, but t=
hey
>> =9A=9A=9Awere not integrated. So, sparc64 can be the first.
> =9A=9AExciting, sparc64 is becomming such a groundbreaking platform :-)
>
>> =9A=9A=9AOther architectures have no as cheap replication as sparc64 has=
. They must
>> =9A=9A=9Amodify page table top every switch_to(), while sparc64 is free =
from this thing.
>> =9A=9A=9AAnd it looks like they have to flush all instruction cache ever=
y context switch.
>>
>> =9A=9A=9AI'll work on the patch a little bit more and test it in differe=
nt boundary cases,
>> =9A=9A=9Abefore submit it as a ready patch.
> =9A=9AI'd be interested in any performance improvement you can show becau=
se that's
> =9A=9Athe reason to do this right?
>
> =9A=9AA parallel kernel build utilizing all nodes ought to show at least =
something.

I used 16 CPU system with a clock rate of 820 MHz. Test "time make image -j=
64"
gives the following:

Before:

real =9A=9A=9A=9A7m58.466s
user =9A60m49.660s
sys =9A=9A=9A47m40.030s

After:

real =9A=9A=9A=9A7m55.562s
user =9A60m20.900s
sys =9A=9A=9A46m36.040s

So, the real profit (system time) is whole 2.2%. I thought, it would be mor=
e :)
It seems, it's not big enough to really implement this feature. Practice ch=
ecks
a hypothesis.

Thanks for the discussion, David!

Regards,
Kirill.
