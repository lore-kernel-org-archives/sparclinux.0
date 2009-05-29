From: Robert Reif <reif@earthlink.net>
Date: Fri, 29 May 2009 00:52:30 +0000
Subject: Re: sparc32 boot problem (SCSI?)
Message-Id: <4A1F31CE.8020308@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1608E3.6040009@earthlink.net>
In-Reply-To: <4A1608E3.6040009@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Robert Reif wrote:
> I bisected it down to this but it makes no sense.
>
> f894e74dc1983062d30d4e1b79bdb90b8a847f52 is first bad commit
> commit f894e74dc1983062d30d4e1b79bdb90b8a847f52
> Author: Jaswinder Singh Rajput <jaswinder@kernel.org>
> Date:   Fri Apr 3 01:42:50 2009 +0530
>
>    [SCSI] qlogicpti: use request_firmware
>      Firmware blob is little endian
>      Thanks to Stephen Rothwell for fixing typos
>      Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
>    Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
Compiling a kernel without this module produces a working system.
