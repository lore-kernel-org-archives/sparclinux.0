From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 07 Sep 2019 19:49:53 +0000
Subject: Re: [PATCH 2/2] ipc: fix sparc64 ipc() wrapper
Message-Id: <CAK8P3a3KkH3MeU4H0SJmrs-jQ9ZA5HksG2uGDfe-=NTXh1UeHQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190905152155.1392871-1-arnd@arndb.de>
 <20190905152155.1392871-2-arnd@arndb.de>
In-Reply-To: <20190905152155.1392871-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, Manfred Spraul <manfred@colorfullife.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, "# 3.4.x" <stable@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, sparclinux <sparclinux@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Anatolij Gustschin <agust@denx.de>

On Thu, Sep 5, 2019 at 5:24 PM Arnd Bergmann <arnd@arndb.de> wrote:

> diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
> index ccc88926bc00..5ad0494df367 100644
> --- a/arch/sparc/kernel/sys_sparc_64.c
> +++ b/arch/sparc/kernel/sys_sparc_64.c
> @@ -340,21 +340,21 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call, int, first, unsigned long, second
>         if (call <= SEMTIMEDOP) {
>                 switch (call) {
>                 case SEMOP:
> -                       err = sys_semtimedop(first, ptr,
> -                                            (unsigned int)second, NULL);
> +                       err = ksys_semtimedop(first, ptr,
> +                                             (unsigned int)second, NULL);
>                         goto out;

The zero-day bot found a link error in sparc64 allnoconfig:

   arch/sparc/kernel/sys_sparc_64.o: In function `__se_sys_sparc_ipc':
>> sys_sparc_64.c:(.text+0x724): undefined reference to `ksys_semtimedop'
>> sys_sparc_64.c:(.text+0x76c): undefined reference to `ksys_old_msgctl'
>> sys_sparc_64.c:(.text+0x7a8): undefined reference to `ksys_semget'
>> sys_sparc_64.c:(.text+0x7c8): undefined reference to `ksys_old_semctl'
>> sys_sparc_64.c:(.text+0x7e4): undefined reference to `ksys_msgsnd'
>> sys_sparc_64.c:(.text+0x7fc): undefined reference to `ksys_shmget'
>> sys_sparc_64.c:(.text+0x808): undefined reference to `ksys_shmdt'
   sys_sparc_64.c:(.text+0x828): undefined reference to `ksys_semtimedop'
>> sys_sparc_64.c:(.text+0x844): undefined reference to `ksys_old_shmctl'
>> sys_sparc_64.c:(.text+0x858): undefined reference to `ksys_msgget'
>> sys_sparc_64.c:(.text+0x86c): undefined reference to `ksys_msgrcv'

I've added this hunk to my patch and plan to send both fixes to Linus
in the next few days, after I get a positive report from the bot as well:

--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -336,6 +336,9 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call,
int, first, unsigned long, second
 {
        long err;

+       if (!IS_ENABLED(CONFIG_SYSVIPC))
+               return -ENOSYS;
+
        /* No need for backward compatibility. We can start fresh... */

        if (call <= SEMTIMEDOP) {
                switch (call) {
