From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 27 Sep 2013 23:58:30 +0000
Subject: Re: [PATCH 0/3] Fully support 47-bit physical addresses.
Message-Id: <66621380326310@web19j.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20130926.165242.1048533011152185981.davem@redhat.com>
In-Reply-To: <20130926.165242.1048533011152185981.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

27.09.2013, 23:21, "Kirill Tkhai" <tkhai@yandex.ru>:
> 27.09.2013, 00:52, "David Miller" <davem@redhat.com>:
>
>> =9AOk, this patch set builds on top of the variable PAGE_OFFSET
>> =9Apatches.
>>
>> =9AFirst we move to 8MB huge pages. =9AThe chips don't really have
>> =9A8MB page support, but we fabricate such a thing using 4MB
>> =9APTEs.
>>
>> =9ANext we move to 64-bit pmd_t and pgd_t entries, which is the
>> =9Amost trivial of the changes here.
>>
>> =9AFinally, we encode huge PMDs using the plain PTE encoding of
>> =9Ahuge pages. =9A=9AAll of the ugly huge PMD --> PTE translation
>> =9Acode disappears, and the TLB miss path is smaller and faster.
>>
>> =9AI just got this stuff fully working so caveat emptor :-)
>>
>> =9ASigned-off-by: David S. Miller <davem@davemloft.net>
>
> Hi, David,
>
> I've tryed the series on UltraSparc II with Spitfire MMU. Boot is ok,
> and some LTP tests are passed (short tests of mm).

This may confuse. Not "some are passed, some are not",
but "I executed a subset and it is ok" ;)
