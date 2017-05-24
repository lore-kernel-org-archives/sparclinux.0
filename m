From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 24 May 2017 14:37:42 +0000
Subject: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_BIG_ENDIAN
Message-Id: <2d9a8af4-7745-8688-6c4a-a11c8d6561b2@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495575958-1022566-1-git-send-email-babu.moger@oracle.com>
 <1495575958-1022566-4-git-send-email-babu.moger@oracle.com>
 <CAMuHMdV0fRdcbDWfafT0_cFSWikfgHghCJ+VkropPW_1wC7hRg@mail.gmail.com>
In-Reply-To: <CAMuHMdV0fRdcbDWfafT0_cFSWikfgHghCJ+VkropPW_1wC7hRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


On 5/24/2017 4:48 AM, Geert Uytterhoeven wrote:
> On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com> wrot=
e:
>> Found this problem while enabling queued rwlock on SPARC.
>> The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
>> specific byte in qrwlock structure. Without this parameter,
>> we clear the wrong byte. Here is the code.
>>
>> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>>   {
>>          return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>>   }
>>
>> Define CPU_BIG_ENDIAN for SPARC to fix it.
>>
>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>> Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> Reviewed-by: Jane Chu <jane.chu@oracle.com>
>> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
>> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
>> ---
>>   arch/sparc/Kconfig |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 908f019..2f58c16 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -92,6 +92,10 @@ config ARCH_DEFCONFIG
>>   config ARCH_PROC_KCORE_TEXT
>>          def_bool y
>>
>> +config CPU_BIG_ENDIAN
>> +       bool
>> +       default y if SPARC
> def_bool y?

Ok.  Sure.  Will change it. Thanks

> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                  -- Linus Torvalds

