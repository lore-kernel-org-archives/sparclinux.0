From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 25 Nov 2013 19:26:34 +0000
Subject: Re: [PATCH 2/2] sparc64: Implement HAVE_CONTEXT_TRACKING
Message-Id: <27281385407594@web28m.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <149311379160131@web12j.yandex.ru>
In-Reply-To: <149311379160131@web12j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

15.11.2013, 03:00, "David Miller" <davem@davemloft.net>:
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Sat, 14 Sep 2013 16:02:11 +0400
>
>> =9AMark the places when the system are in user or are in kernel.
>> =9AThis is used to make full dynticks system (tickless) --
>> =9ACONFIG_NO_HZ_FULL dependence.
>>
>> =9ASigned-off-by: Kirill Tkhai <tkhai@yandex.ru>
>
> Applied, although:
>
>> =9A-void do_fpe_common(struct pt_regs *regs)
>> =9A+static void do_fpe_common(struct pt_regs *regs)
>
> I had to thus remove the extern declaration of do_fpe_common from
> arch/sparc/kernel/entry.h otherwise a warning is issued and the code
> under arch/sparc builds -Werror and thus the build broke.

I did not add context_tracking.h include to kgdb_64.c, and this gives
the build error:

https://lkml.org/lkml/2013/11/23/200

I sent the fix to lkml. But I'm not sure, is it the right destination?
