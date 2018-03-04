From: Helge Deller <deller@gmx.de>
Date: Sun, 04 Mar 2018 20:45:54 +0000
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to compat_time.h
Message-Id: <e417db45-d400-3513-3897-7aefa9889711@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, acme@kernel.org, benh@kernel.crashing.org, borntraeger@de.ibm.com, catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com, hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net, paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org, rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com, sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org, sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, will.deacon@arm.com, x86@kernel.org

On 16.01.2018 03:18, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
> 
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

For parisc:

Acked-by: Helge Deller <deller@gmx.de> # parisc
