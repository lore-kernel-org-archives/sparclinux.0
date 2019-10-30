From: David Miller <davem@davemloft.net>
Date: Wed, 30 Oct 2019 19:33:24 +0000
Subject: Re: [PATCH 05/12] sparc: Replace cpu_up/down with device_online/offline
Message-Id: <20191030.123324.2200344682917452634.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20191030153837.18107-1-qais.yousef@arm.com>
        <20191030153837.18107-6-qais.yousef@arm.com>
In-Reply-To: <20191030153837.18107-6-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qais.yousef@arm.com
Cc: tglx@linutronix.de, gregkh@linuxfoundation.org, bhelgaas@google.com, rafael.j.wysocki@intel.com, sakari.ailus@linux.intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>
Date: Wed, 30 Oct 2019 15:38:30 +0000

> The core device API performs extra housekeeping bits that are missing
> from directly calling cpu_up/down.
> 
> See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> serialization during LPM") for an example description of what might go
> wrong.
> 
> This also prepares to make cpu_up/down a private interface for anything
> but the cpu subsystem.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
