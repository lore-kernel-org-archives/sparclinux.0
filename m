From: Chris Torek <chris.torek@windriver.com>
Date: Mon, 16 Mar 2009 18:00:40 +0000
Subject: Re: question on sparc64 switch_to macro
Message-Id: <200903161800.n2GI0en02924@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200903141853.n2EIrqn13598@elf.torek.net>
In-Reply-To: <200903141853.n2EIrqn13598@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>It's a 2 minute hack, just test this patch below.

The report: works great (well, after the needed dain-bramaging to
fit it back into the older kernel :-) ).  Makes kgdbts solid.

[patch snipped]

Chris
