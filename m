From: Markus Dahms <mad@automagically.de>
Date: Mon, 20 Aug 2007 13:19:00 +0000
Subject: Re: possible endless loop in PROM initialization
Message-Id: <20070820131900.GA12305@vimes.madsworld.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820075949.GA5927@vimes.madsworld.lan> <20070820.010622.41634915.davem@davemloft.net> <20070820105320.GB4911@vimes.madsworld.lan> <46C97E7F.3010604@netunix.com>
In-Reply-To: <46C97E7F.3010604@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Newport <crn@netunix.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

>> | ok devalias scsi /iommu/sbus/espdma/esp
>> | scsi isn't unique
> Non-unique devalias entries are NASTY. Get rid of them, for example
> your second definition of scsi could be changed to scsidisk.

Yes, it is nasty and I don't really want to use it. But it is possible
and IMHO Linux should handle it one way or the other.

Originally I tried to workaround an Oops in esp on the Classic X which
I connected to some broken PROM entries. The PROM booted from SCSI disk
(using another device path as the scsi aliases are broken or so), but
Linux crashes on loading the SCSI driver. As already said now I use the
"recommended workaround": patching the Classic X to be a Classic.

Markus

