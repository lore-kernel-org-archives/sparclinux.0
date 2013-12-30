From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 30 Dec 2013 12:42:47 +0000
Subject: Re: [PATCH 0/3]  PREEMPT_RT support for Sparc64
Message-Id: <135961388407367@web19g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1387166853-10782-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1387166853-10782-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Allen Pais <allen.pais@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>

16.12.2013, 08:08, "Allen Pais" <allen.pais@oracle.com>:
> PREEMPT_RT support for Sparc64.
> I have tested it on UltraSparc T4 (Niagara4).
>
> Allen Pais (3):
> =9A=9Asparc64: use generic rwsem spinlocks rt
> =9A=9Asparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
> =9A=9Asparc64: convert ctx_alloc_lock raw_spinlock_t
>
> =9Aarch/sparc/Kconfig =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A=9A| =9A=9A=9A7 +++----
> =9Aarch/sparc/include/asm/mmu_64.h =9A=9A=9A=9A=9A=9A=9A=9A| =9A=9A=9A2 +-
> =9Aarch/sparc/include/asm/mmu_context_64.h | =9A=9A10 +++++-----
> =9Aarch/sparc/kernel/smp_64.c =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A| =
=9A=9A=9A4 ++--
> =9Aarch/sparc/mm/init_64.c =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A| =9A=9A14 +++++++-------
> =9Aarch/sparc/mm/tsb.c =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A=9A| =9A=9A20 ++++++++++----------
> =9A6 files changed, 28 insertions(+), 29 deletions(-)

Works good on my 16 CPU sun4u.

Tested-by: Kirill Tkhai <tkhai@yandex.ru>
