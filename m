From: David Miller <davem@davemloft.net>
Date: Mon, 28 Nov 2016 20:43:32 +0000
Subject: Re: Build regressions/improvements in v4.9-rc7
Message-Id: <20161128.154332.1749021881268024855.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1480343257-26723-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdXQ1--skMHOW1HLtCeeeGR4PqkYLHh8rVukPU=V8u4fQg@mail.gmail.com>
        <CADxRZqzUnJr-FavZkc6RypHk+A6yO2BLxqJHRtdKhBCbWBDYWw@mail.gmail.com>
In-Reply-To: <CADxRZqzUnJr-FavZkc6RypHk+A6yO2BLxqJHRtdKhBCbWBDYWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 28 Nov 2016 23:40:34 +0300

> On Mon, Nov 28, 2016 at 5:29 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, Nov 28, 2016 at 3:27 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> JFYI, when comparing v4.9-rc7[1] to v4.9-rc6[3], the summaries are:
>>>   - build errors: +10/-4
>>
>>   + /home/kisskb/slave/src/drivers/scsi/qlogicpti.c: error: passing
>> argument 3 of 'dma_alloc_coherent' from incompatible pointer type
>> [-Werror=incompatible-pointer-types]:  => 813:9, 822:9
>>   + /home/kisskb/slave/src/sound/sparc/dbri.c: error: passing argument
>> 3 of 'dma_zalloc_coherent' from incompatible pointer type
>> [-Werror=incompatible-pointer-types]:  => 2538:6
>>
>> sparc64-allmodconfig
>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/head/e5517c2a5a49ed5e99047008629f1cd60246ea0e/ (all 267 configs)
>>> [3] http://kisskb.ellerman.id.au/kisskb/head/9c763584b7c8911106bb77af7e648bef09af9d80/ (all 267 configs)
> 
> I'm unable to compile kernel as well, bisected in between 4.9-rc7
> (bad) and 4.9-rc6 (good):

We know about these problems and are working on it.

Thanks.
