From: Markus Dahms <mad@automagically.de>
Date: Mon, 20 Aug 2007 10:53:20 +0000
Subject: Re: possible endless loop in PROM initialization
Message-Id: <20070820105320.GB4911@vimes.madsworld.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820075949.GA5927@vimes.madsworld.lan> <20070820.010622.41634915.davem@davemloft.net>
In-Reply-To: <20070820.010622.41634915.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hello again,

David Miller wrote:
> When we boot the firmware provides a vector of function
> pointers, and this is prom_nodeops.  So prom_nodeops->no_nextprop()
> is a routine inside the PROM.

Thanks. So there is no real chance to fix it but to override this
function?
The strange thing is that the PROM prompt handles it correctly:

| ok devalias scsi /iommu/sbus/espdma/esp
| scsi isn't unique
| ok cd /aliases
| ok .attributes
| scsi                     /iommu/sbus/espdma/esp
| screen                   /iommu@0,10000000/sbus@0,10001000/cgthree@3,0
| net-g                    net:,SUNXT_KERNEL.SUN4M
| ttyb                     /obio/zs@0,100000:b
| ttya                     /obio/zs@0,100000:a
| keyboard!                /obio/zs@0,0:forcemode
| keyboard                 /obio/zs@0,0
| floppy                   /obio/SUNW,fdtwo
| scsi                     /iommu/sbus/espdma@4,8400000/esp@4,8800000
| net-aui                  /iommu/sbus/ledma@4,8400010:aui/le@4,8c00000
| net-tpe                  /iommu/sbus/ledma@4,8400010:tpe/le@4,8c00000
| [...]
| name                     aliases

Linux PROM initialization goes this way:

| scsi
| screen
| net-g
| ttyb
| ttya
| keyboard!
| keyboard
| floppy
| scsi
| screen
| net-g
[...]

As I'm not sure anymore whether the device tree (show-devs) or the aliases
(devalias) are broken on the Classic X (I "upgraded" mine to a Classic by
changing some NVRAM bytes) this may be a non-issue. But it is still an
endless loop where it don't has to be.

Markus

