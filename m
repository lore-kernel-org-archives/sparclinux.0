From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2012 17:35:13 +0000
Subject: Re: [PATCH 1/1] sparc: task_cpu() for stopper thread on sparc32 returns 0
Message-Id: <20120419.133513.1487729675877616836.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1334827362-3434-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1334827362-3434-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 19 Apr 2012 11:22:42 +0200

> The stopper thread for CPU > 0 (at least in sparc32)
> has on initialization task_cpu() set to zero even
> for CPUs > 0. The patch explicitly checks weather the
> CPU is allowed to run on the cpu that task_cpu()
> return or changes the return cpu.
> 
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>

Posting a patch to generic code like this only to the Sparc
list isn't going to drive us forward to a solution and will
not involve the people who need to help you look into this
problem.

Therefore you need to post this with at least linux-kernel
and the scheduler maintainer's CC:'d.
