From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 13 Jan 2020 17:05:43 +0000
Subject: Re: [RFC PATCH v3 00/12] Unify SMP stop generic logic to common code
Message-Id: <7937f12d-8aba-733a-c313-f446857a1447@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
 <20200113164029.GE4458@willie-the-truck>
In-Reply-To: <20200113164029.GE4458@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, mingo@redhat.com, x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com, linux@armlinux.org.uk, davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org

Hi Will

On 13/01/2020 16:40, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 12:18:53PM +0000, Cristian Marussi wrote:
>> the logic underlying SMP stop and kexec crash procedures, beside containing
>> some arch-specific bits, is mostly generic and common across all archs:
>> despite this fact, such logic is now scattered across all architectures and
>> on some of them is flawed, in such a way that, under some specific
>> conditions, you can end up with a CPU left still running after a panic and
>> possibly lost across a subsequent kexec crash reboot. [1]
> 
> Is this still the case even after 20bb759a66be ("panic: ensure preemption is
> disabled during panic()")?
> 

v3 is based on 5.5-rc2 which seems to include 20bb759a66be, and when I tested before
re-posting a few weeks ago it was still failing as usual, i.e. kernel still alive after panic.
[but please be aware that to reproduce it, you need to have only one core online and another one
 panicing while starting up (while still marked offline)]

Thanks

Cristian
