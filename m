From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 01 Jun 2012 23:29:08 +0000
Subject: Re: [UPDATED PATCH 21/27] sparc32, smpboot: Use generic SMP booting infrastructure
Message-Id: <4FC94D74.70208@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120601.135612.699120609738854050.davem@davemloft.net> <20120601185448.GA19148@merkur.ravnborg.org> <4FC94693.5050707@linux.vnet.ibm.com> <20120601.185341.1462375672682064314.davem@davemloft.net>
In-Reply-To: <20120601.185341.1462375672682064314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sam@ravnborg.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, vapier@gentoo.org, konrad@gaisler.com, tkhai@yandex.ru, sparclinux@vger.kernel.org

On 06/02/2012 04:23 AM, David Miller wrote:

> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> Date: Sat, 02 Jun 2012 04:17:47 +0530
> 
>>
>> Convert sparc32 to use the generic framework to boot secondary CPUs.
>>
>> Notes:
>> While removing the call to cpu_idle(), we can also remove the call to
>> cpu_panic() because we are calling BUG() in the generic code anyway.
>>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> 
> Almost there, but not quite yet.
> 
> You can't get rid of the cpu_panic invocations, those have to be there
> after the *_callin calls to catch if they accidently return.
> 


Oh.. ok..

So can I do something like the following, or do you want me to specifically
add call cpu_panic and nop after every *_callin?

diff --git a/arch/sparc/kernel/trampoline_32.S b/arch/sparc/kernel/trampoline_32.S
index 7364ddc..9b2b81d 100644
--- a/arch/sparc/kernel/trampoline_32.S
+++ b/arch/sparc/kernel/trampoline_32.S
@@ -82,15 +82,12 @@ cpu3_startup:
        call    smp4m_callin
         nop
 
-       b,a     smp_do_cpu_idle
+       b,a     do_panic
 
        .text
        .align  4
 
-smp_do_cpu_idle:
-       call    cpu_idle
-        mov    0, %o0
-
+do_panic:
        call    cpu_panic
         nop
 
@@ -147,7 +144,7 @@ sun4d_cpu_startup:
        call    smp4d_callin
         nop
 
-       b,a     smp_do_cpu_idle
+       b,a     do_panic
 
 #ifdef CONFIG_SPARC_LEON
 
@@ -206,6 +203,6 @@ leon_smp_cpu_startup:
        call    leon_callin
         nop
 
-       b,a     smp_do_cpu_idle
+       b,a     do_panic

