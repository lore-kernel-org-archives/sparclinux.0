From: Will Deacon <will@kernel.org>
Date: Mon, 13 Jan 2020 16:40:29 +0000
Subject: Re: [RFC PATCH v3 00/12] Unify SMP stop generic logic to common code
Message-Id: <20200113164029.GE4458@willie-the-truck>
List-Id: <sparclinux.vger.kernel.org>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
In-Reply-To: <20191219121905.26905-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, mingo@redhat.com, x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com, linux@armlinux.org.uk, davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org

On Thu, Dec 19, 2019 at 12:18:53PM +0000, Cristian Marussi wrote:
> the logic underlying SMP stop and kexec crash procedures, beside containing
> some arch-specific bits, is mostly generic and common across all archs:
> despite this fact, such logic is now scattered across all architectures and
> on some of them is flawed, in such a way that, under some specific
> conditions, you can end up with a CPU left still running after a panic and
> possibly lost across a subsequent kexec crash reboot. [1]

Is this still the case even after 20bb759a66be ("panic: ensure preemption is
disabled during panic()")?

Will
