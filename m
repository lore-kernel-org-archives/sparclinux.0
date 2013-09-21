From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 21 Sep 2013 15:34:49 +0000
Subject: Re: [PATCH 0/6] Make PAGE_OFFSET variable.
Message-Id: <4861379777689@web9j.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20130921.011546.399976981566163964.davem@davemloft.net>
In-Reply-To: <20130921.011546.399976981566163964.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

21.09.2013, 09:16, "David Miller" <davem@davemloft.net>:
> Basically the first 5 patches deconstruct the whole situation,
> then the final patch throws the switch and makes PAGE_OFFSET
> variable based upon cpu type.
>
> I tested this patch series lightly on a T4. =9AThis obviously
> isn't enough to fully support 47-bit physical addresses yet,
> and I'll be looking into the page table issues next to take
> care of that.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> --

Boot tested on Sun Ultra 60 UPA/PCI (2 X UltraSPARC-II 296MHz)
