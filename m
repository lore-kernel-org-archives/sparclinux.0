From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 23 Aug 2013 15:43:56 +0000
Subject: Re: [RFC] sparc64: Duplicate kernel text on every NUMA node
Message-Id: <12781377272636@web6h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <8311377178790@web14g.yandex.ru>
In-Reply-To: <8311377178790@web14g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

23.08.2013, 09:23, "David Miller" <davem@davemloft.net>:
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Thu, 22 Aug 2013 17:39:50 +0400
>
>> =9AThere is an idea to duplicate kernel text on every NUMA node. Node
>> =9Aaccess is the fastest, so this should help to execute kernel text a
>> =9Alittle faster.
>
> Interesting change.
>
> What other major architectures do this?

It looks like nobody supports this. I saw an old patch for x86 (https://lkm=
l.org/lkml/2003/6/16/226)
and several others, but they were not integrated. So, sparc64 can be the fi=
rst.

Other architectures have no as cheap replication as sparc64 has. They must
modify page table top every switch_to(), while sparc64 is free from this th=
ing.
And it looks like they have to flush all instruction cache every context sw=
itch.

I'll work on the patch a little bit more and test it in different boundary =
cases,
before submit it as a ready patch.

Thanks,
Kirill
