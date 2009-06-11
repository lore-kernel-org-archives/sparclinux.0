From: David Miller <davem@davemloft.net>
Date: Thu, 11 Jun 2009 10:27:11 +0000
Subject: Re: sparc32 boot problem (SCSI?)
Message-Id: <20090611.032711.03972738.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1608E3.6040009@earthlink.net>
In-Reply-To: <4A1608E3.6040009@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Thu, 28 May 2009 20:52:30 -0400

> Robert Reif wrote:
>> I bisected it down to this but it makes no sense.
>>
>> f894e74dc1983062d30d4e1b79bdb90b8a847f52 is first bad commit
>> commit f894e74dc1983062d30d4e1b79bdb90b8a847f52
>> Author: Jaswinder Singh Rajput <jaswinder@kernel.org>
>> Date:   Fri Apr 3 01:42:50 2009 +0530
>>
>>    [SCSI] qlogicpti: use request_firmware
>>      Firmware blob is little endian
>>      Thanks to Stephen Rothwell for fixing typos
>>      Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
>>    Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>>
> Compiling a kernel without this module produces a working system.

Strange bug indeed.

Did you have this built statically into the kernel or modular?

If statically, the change may have taken your image over the limit for
bootable image size on sparc32.

If modular, that's very mysterious.  The probe code of this driver
should not even execute without an actual qlogicpti card in your
machine, and that's the only thing really modified here.
