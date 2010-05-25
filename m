From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 25 May 2010 05:11:11 +0000
Subject: Re: GR-LEON4-ITX
Message-Id: <4BFB5BEF.70009@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTiku3COSiJ8kJcOuzykS-gVWvHrC_tlCxydQmaV7@mail.gmail.com>
In-Reply-To: <AANLkTiku3COSiJ8kJcOuzykS-gVWvHrC_tlCxydQmaV7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Paul,

The easiest way to get Linux running on the GR-LEON4-ITX board
is to use the kernel that is delivered with the board. It is 
based on 2.6.21 and contains all our drivers and boot loader 
(this kernel is also available from our webpage).

The mainline kernel does work on LEON3/4 (including SMP) but
we have not yet made available an updated distribution with surrounding
infrastructure (e.g. boot loader, root file systems, OpenFirmware tree generation, etc). 

Hopefully it will not be too long until we release an updated version based 
on the latest kernel. All tough it will take some time to get all drivers
from the 2.6.21 version into the mainline kernel.

Link to the board for anyone interested in getting a new SPARC V8 with lots of on chip
devices:
http://www.gaisler.com/cms/index.php?option=com_content&task=view&id39&Itemid#2

Best regards,
Kristoffer Glembo
Aeroflex Gaisler


Paul Thomas wrote:
> Hello,
> 
> I'm interested in the getting a GR-LEON4-ITX development board, and I
> wanted to know if the mainline kernel would support it? I saw the
> leon3 patches, and when I look at xconfig I see the SPARC_LEON & GRETH
> config options so it looks like it's close. Is anyone using the
> mainline or sparc tree with the GR-LEON4-ITX development board?
> 
> thanks,
> Paul
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

