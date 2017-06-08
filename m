From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 08 Jun 2017 08:01:59 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <CAK8P3a1WfU9V1k2r=TfJSVRTymuD8n2hkJDr6u1KcmC_scAZMA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <87a85v7to2.fsf@concordia.ellerman.id.au> <CAMuHMdU1kne4tKRfyx0hr1LXh_c75bYMs0b=vncHqrhB69jqYg@mail.gmail.com>
 <877f0z6oig.fsf@concordia.ellerman.id.au> <28d6c874-4653-b15d-39b7-57a032abc9c6@oracle.com>
In-Reply-To: <28d6c874-4653-b15d-39b7-57a032abc9c6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thu, Jun 8, 2017 at 1:07 AM, Babu Moger <babu.moger@oracle.com> wrote:
>
> On 5/29/2017 9:56 PM, Michael Ellerman wrote:
>>
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>
>>> Hi Michael,
>>>
>>> On Mon, May 29, 2017 at 2:07 PM, Michael Ellerman <mpe@ellerman.id.au>
>>> wrote:
>>>>
>>>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>>>>
>>>>> On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com>
>>>>> wrote:

>>>
>>> So far we tried always doing that, but a few checks for the semi-existing
>>> Kconfig symbol crept in in generic code. Those could be replaced by the
>>> __*__
>>> variants, but consistently having the Kconfig symbols would be useful
>>> anyway
>>> (e.g. to avoid building the broken-on-big-endian ISDN drivers).
>>
>> Ah OK, the original mail was citing C code, but yeah I guess it would be
>> handy in Makefiles etc.
>
>
> Thanks for all the responses.  I see couple of options here.
>
> 1. Fix the c code in include/asm-generic/qrwlock.h using ifdef
> __BIG_ENDIAN__
>     This will fix the issue for us.
>
> 2. Define CPU_BIG_ENDIAN for all the missing fixed endian architectures.
> Because the problem is only for fixed big endian archs.
>
> I prefer the option 1.  What do you guys think ?

I would prefer option 2. If we leave out CONFIG_CPU_LITTLE_ENDIAN,
then the patch becomes much easier than what we had discussed earlier,
and we just need to patch a few Kconfig files to add

config CPU_BIG_ENDIAN
       def_bool y

I would also suggest adding a sanity check like

diff --git a/include/linux/byteorder/big_endian.h
b/include/linux/byteorder/big_endian.h
index 392041475c72..18a1ab5b0260 100644
--- a/include/linux/byteorder/big_endian.h
+++ b/include/linux/byteorder/big_endian.h
@@ -3,5 +3,9 @@

 #include <uapi/linux/byteorder/big_endian.h>

+#ifndef CONFIG_CPU_BIG_ENDIAN
+#warning inconsistent configuration, need CONFIG_CPU_BIG_ENDIAN
+#endif
+
 #include <linux/byteorder/generic.h>
 #endif /* _LINUX_BYTEORDER_BIG_ENDIAN_H */
diff --git a/include/linux/byteorder/little_endian.h
b/include/linux/byteorder/little_endian.h
index 08057377aa23..ba910bb9aad0 100644
--- a/include/linux/byteorder/little_endian.h
+++ b/include/linux/byteorder/little_endian.h
@@ -3,5 +3,9 @@

 #include <uapi/linux/byteorder/little_endian.h>

+#ifdef CONFIG_CPU_BIG_ENDIAN
+#warning inconsistent configuration, CONFIG_CPU_BIG_ENDIAN is set
+#endif
+
 #include <linux/byteorder/generic.h>
 #endif /* _LINUX_BYTEORDER_LITTLE_ENDIAN_H */

Fixing xtensa properly might still be tricky, but with that change, at least
we detect when things go wrong in this area.

        Arnd
