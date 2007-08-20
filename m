From: Chris Newport <crn@netunix.com>
Date: Mon, 20 Aug 2007 11:43:59 +0000
Subject: Re: possible endless loop in PROM initialization
Message-Id: <46C97E7F.3010604@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820075949.GA5927@vimes.madsworld.lan> <20070820.010622.41634915.davem@davemloft.net> <20070820105320.GB4911@vimes.madsworld.lan>
In-Reply-To: <20070820105320.GB4911@vimes.madsworld.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Markus Dahms <mad@automagically.de>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Markus Dahms wrote:

>Hello again,
>
>David Miller wrote:
>  
>
>>When we boot the firmware provides a vector of function
>>pointers, and this is prom_nodeops.  So prom_nodeops->no_nextprop()
>>is a routine inside the PROM.
>>    
>>
>
>Thanks. So there is no real chance to fix it but to override this
>function?
>The strange thing is that the PROM prompt handles it correctly:
>
>| ok devalias scsi /iommu/sbus/espdma/esp
>| scsi isn't unique
>  
>
Non-unique devalias entries are NASTY. Get rid of them, for example
your second definition of scsi could be changed to scsidisk.
You should also check that any nvramrc entries do not cause conflicts,
it is common for nvramrc entries to refer to devalias entries, so you 
may need to also change an nvramrc entry to match any devalias change.

You can disable the use of nvramrc from the OBP prompt with
setenv if the entry isnon-essential, they are most commonly used
where there is a mirrored root disk.


