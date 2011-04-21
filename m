From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 23:46:21 +0000
Subject: Re: [PATCH 0/3] sparc32: boot_cpu_id patches
Message-Id: <20110421.164621.115925761.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB03CF5.9060308@gaisler.com>
In-Reply-To: <4DB03CF5.9060308@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 21 Apr 2011 16:19:33 +0200

> The LEON patches in this series must be applied after the genirq
> patches [2..7] previously sent.
> 
> It adds support for LEON to boot on a CPU other than CPU0 on
> single-processor linux kernels. I have tried to clean up the
> boot_cpu_id initialization and move it to the DATA section and at the
> same time use the value to determine if it is the first CPU booting in
> the LEON case.

All applied to sparc-next-2.6
