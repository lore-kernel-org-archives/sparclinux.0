From: David Miller <davem@davemloft.net>
Date: Thu, 10 Aug 2017 05:22:54 +0000
Subject: Re: [PATCH] sunvdc: prevent sunvdc panic when mpgroup disk added to guest domain
Message-Id: <20170809.222254.2158088121874749981.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Quigley <Jim.Quigley@oracle.com>
Date: Fri, 21 Jul 2017 09:20:15 -0400

> Using mpgroup to define multiple paths for a virtual disk causes multiple
> virtual-device-port ports to be created for that virtual device.
> Each virtual-device-port port then gets a vdisk created for it by the Linux
> sunvdc driver. As mpgroup is not supported by the Linux sunvdc driver it
> cannot handle multiple ports for a single vdisk, leading to a kernel panic
> at startup.
> 
> This fix prevents more than one vdisk per virtual-device-port being created
> until full virtual disk multipathing (mpgroup) support is implemented.
> 
> Signed-off-by: Jim Quigley <Jim.Quigley@oracle.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Reviewed-by: Aaron Young <aaron.young@oracle.com>

Applied, thank you.
