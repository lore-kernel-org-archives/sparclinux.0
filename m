From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 19 May 2017 16:35:09 +0000
Subject: Re: [PATCH 1/6] kernel/locking: Fix compile error with qrwlock.c
Message-Id: <d8a2b187-615f-f07f-aa31-5f68dab84e56@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
 <1495154170-854693-2-git-send-email-babu.moger@oracle.com>
 <20170518.222753.1822313785663789393.davem@davemloft.net>
In-Reply-To: <20170518.222753.1822313785663789393.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


On 5/18/2017 9:27 PM, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Thu, 18 May 2017 18:36:05 -0600
>
>> Seeing this error on SPARC while compiling qrwlock.c.
>>
>>    CC      kernel/locking/qrwlock.o
>> In file included from ./include/asm-generic/qrwlock_types.h:5,
>>                   from ./arch/sparc/include/asm/qrwlock.h:4,
>>                   from kernel/locking/qrwlock.c:24:
>> ./arch/sparc/include/asm/spinlock_types.h:5:3: error:
>>          #error "please don't include this file directly"
>>
>> Re-arrange the includes in qrwlock_types.h and also include spinlock.h
>> in qrwlock.c to fix it. This should also help other architectures when
>> queued rwlock is enabled.
>>
>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>> Reviewed-by: H=E5kon Bugge <haakon.bugge@oracle.com>
>> Reviewed-by: Jane Chu <jane.chu@oracle.com>
>> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
>> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
> I think you can simply remove the:
>
> #ifndef __LINUX_SPINLOCK_TYPES_H
> # error "please don't include this file directly"
> #endif
>
> stanza from the sparc header file instead.  Other architectures
> don't use this guard.

Sure. I can remove this for SPARC.  Will make this as a separate patch.
But, there are still some architectures use this gaurd.

arch/xtensa/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/arm/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/powerpc/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/metag/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/hexagon/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/alpha/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/sh/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/mn10300/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/ia64/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/blackfin/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/m32r/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/s390/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/arm64/include/asm/spinlock_types.h:#if=20
!defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
arch/tile/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H
arch/mips/include/asm/spinlock_types.h:#ifndef __LINUX_SPINLOCK_TYPES_H

I think we need  still need this patch as it re-arrages headers=20
properly. Will send  v2 series soon.

