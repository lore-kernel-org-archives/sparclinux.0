From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 07 Mar 2014 13:41:33 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <20140307134133.GE8637@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <359241392801938@web24j.yandex.ru>
 <530D9D1C.1060905@oracle.com>
 <39171393599083@web13h.yandex.ru>
 <20140304.141003.1969905483115684548.davem@davemloft.net>
In-Reply-To: <20140304.141003.1969905483115684548.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: tkhai@yandex.ru, allen.pais@oracle.com, linux-rt-users@vger.kernel.org, sparclinux@vger.kernel.org

* David Miller | 2014-03-04 14:10:03 [-0500]:

>> This should be fixed like that's done for 8250
>> [patch drivers-serial-cleanup-locking-for-rt.patch]
>
>Like the patch below?

The patch looks good.

>Is this transformation legitimate outside of the -rt tree?  I wish the com=
mit
>messages for the 8250 change was more verbose, explaining exactly why this
>is needed.

Looking at it, it looks like the transformation is legitimate in
vanila, too.

In -RT the spin_lock_irqsave() does not spin but sleep if the lock is
taken. Before that, local_irq_save() is invoked which disables
interrupts even on -RT. That is why you might_sleep() triggers a warning
here.
In the ->sysrq and oops_in_progress case it is save to trylock the lock
i.e. this is what we do now anyway except for ->sysrq where we assume
that the lock is already taken.

The spin_lock_irqsave() grabs the lock and disables the interrupts on
vanila (the same behavior) and on -RT it won't disable interrupts.

>And if it's needed, all the sparc serial/console drivers need this too.

Let me forward the 8250 to GregKH and see how he reacts. Would be nice
if it is another patch that gets removed from that queue=E2=80=A6

Sebastian
