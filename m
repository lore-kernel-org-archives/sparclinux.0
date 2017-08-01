From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 01 Aug 2017 20:58:29 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <20170801205829.GA7496@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzkUqWsHgw8eNHF4E_wi5a6d=hJnmEtm5omsw42tHAw+Q@mail.gmail.com>
 <20170731.145151.571917275997786929.davem@davemloft.net>
 <CADxRZqz+oQn8=Q3RDtfko9ctP1RE41XnsVP3H8RXJuE9m=VPLw@mail.gmail.com>
 <20170731.150632.885106324164202893.davem@davemloft.net>
 <22912.11736.664315.645426@gargle.gargle.HOWL>
In-Reply-To: <22912.11736.664315.645426@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpelinux@gmail.com>
Cc: David Miller <davem@davemloft.net>, matorola@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mikael.

I think this translates to the following code
from linux/uaccess.h

first part is the inlined _copy_from_user()

> 
> (gdb) x/10i do_sys_poll+0x80-16
>    0x516ed0 <do_sys_poll+112>:  brz  %o0, 0x5170fc <do_sys_poll+668>
if (unlikely(res))

>    0x516ed4 <do_sys_poll+116>:  mov  %o0, %o2
>    0x516ed8 <do_sys_poll+120>:  sub  %i4, %o0, %i4
>    0x516edc <do_sys_poll+124>:  clr  %o1
>    0x516ee0 <do_sys_poll+128>:  call  0x7570b8 <memset>
>    0x516ee4 <do_sys_poll+132>:  add  %l3, %i4, %o0
memset(to + (n - res), 0, res);


and this part is from the inlined copy_from_user()

>    0x516ee8 <do_sys_poll+136>:  b  %xcc, 0x5170b0 <do_sys_poll+592>
jump to end of function

>    0x516eec <do_sys_poll+140>:  mov  -14, %l7
>    0x516ef0 <do_sys_poll+144>:  mov  %l2, %o0
>    0x516ef4 <do_sys_poll+148>:  movleu  %xcc, %l0, %o0
} else if (!__builtin_constant_p(n))
                copy_user_overflow(sz, n);

Where we in the generic implementation now uses the return value
of raw_copy_from_user() which we did not do before said patch.

So I suspect that what we see here is that:
1) with the patch from Al we start to use the return value of raw_copy_from_user
2) The return value is wrong in the sparc implmentation so boom
3) We only trigger this on old HW because the return value is correct in some,
but not all of the implemantions of raw_copy_from_user.
Davem fixed this is a series of patches that requires some sparc
assembler knowledge to dechifer.

The return value was fixed in ee841d0aff649164080e445e84885015958d8ff4
for the Ultra III as used by SUN Blade 2500.
And if I am right then this fix fails with the paramters used 
in our case with strace.

Mikael - could you try to edit U3patch.S like this:

Change the following lines:

cheetah_patch_copyops:
        ULTRA3_DO_PATCH(memcpy, U3memcpy)
        ULTRA3_DO_PATCH(___copy_from_user, U3copy_from_user)
        ULTRA3_DO_PATCH(___copy_to_user, U3copy_to_user)
        retl

To:
cheetah_patch_copyops:
        ULTRA3_DO_PATCH(memcpy, GENmemcpy)
        ULTRA3_DO_PATCH(raw_copy_from_user, GENcopy_from_user)
        ULTRA3_DO_PATCH(raw_copy_to_user, GENcopy_to_user)
        retl

In other words, so we use the generic versions which I assume
is OK on Ultra III, but slower.

	Sam
