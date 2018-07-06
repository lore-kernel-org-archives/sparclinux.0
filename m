From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 06 Jul 2018 01:04:51 +0000
Subject: Re: [PATCH] kbuild: update ARCH alias info for sparc
Message-Id: <CAK7LNASqFLGVJ56dXBgj9P=S5UGCWMtJDtxVZb5t-tvTH3vckQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <03cfef31-5308-7b17-9e0d-3a0dc680e750@infradead.org> <20180706.093103.1547249026984330034.davem@davemloft.net>
In-Reply-To: <20180706.093103.1547249026984330034.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, David Miller <davem@davemloft.net>

2018-07-06 9:31 GMT+09:00 David Miller <davem@davemloft.net>:
> From: Randy Dunlap <rdunlap@infradead.org>
> Date: Thu, 5 Jul 2018 12:12:03 -0700
>
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> The supported alias for building sparc 32-bit is "sparc32",
>> not "sparc", so update the alias documentation for that.
>> Just using "sparc" produces a 64-bit config file.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>
> Acked-by: David S. Miller <davem@davemloft.net>
> --

Applied to linux-kbuild. Thanks!



-- 
Best Regards
Masahiro Yamada
