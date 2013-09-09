From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 09 Sep 2013 21:44:40 +0000
Subject: Re: [RFC] sparc64: Duplicate kernel text on every NUMA node
Message-Id: <7901378763080@web17g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <8311377178790@web14g.yandex.ru>
In-Reply-To: <8311377178790@web14g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



09.09.2013, 21:31, "David Miller" <davem@davemloft.net>:
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Mon, 09 Sep 2013 18:50:00 +0400
>
>> =9ABefore:
>>
>> =9Areal =9A=9A=9A=9A7m58.466s
>> =9Auser =9A60m49.660s
>> =9Asys =9A=9A=9A47m40.030s
>>
>> =9AAfter:
>>
>> =9Areal =9A=9A=9A=9A7m55.562s
>> =9Auser =9A60m20.900s
>> =9Asys =9A=9A=9A46m36.040s
>>
>> =9ASo, the real profit (system time) is whole 2.2%. I thought, it would =
be more :)
>> =9AIt seems, it's not big enough to really implement this feature. Pract=
ice checks
>> =9Aa hypothesis.
>
> You are juding the suitability of your optimization using one
> statistical sample of a benchmark involving trillions of memory
> accesses?
> Please at least run it 3 or 4 times so you can see how much variation
> occurs between runs in the same configuration. :-)

Yes, I compiled kernel 3 times for every case. Two above are middle results.
Another cases are a little different, but tendency is like above.=20
The low bound of difference is 2.0+%

I did every test after cold start (and even took ethernet cable out). So, t=
he result
is honest :)

(For comparison: Plain memory access time ratio between own node and its
neighbour is about 1.4 on the tested machine. It looks like instruction cac=
he
has the influence on above result. I don't know what is its influence on ma=
chines
of another type, maybe anywhere it is smaller).

Kirill
