From: Rob Herring <rob.herring@calxeda.com>
Date: Tue, 10 Jul 2012 15:00:41 +0000
Subject: Re: bisected regression since 3.5-rc5 - hang on boot on some sparc64 machines
Message-Id: <4FFC4399.3050407@calxeda.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1207091627480.17307@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1207091627480.17307@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Linux Kernel list <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 07/10/2012 06:09 AM, Meelis Roos wrote:
> A regression since 3.5-rc5 stops Sun Fire V100 and Sun Netra X1 sparc64 
> machines from booting, hanging after enabling serial console. Several 
> different other sparc64 systems work fine with 3.5-rc6. prtconf and full 
> dmesg below.
> 
> Bisecting leads to
> 107a84e61cdd3406c842a0e4be7efffd3a05dba6 is the first bad commit
> commit 107a84e61cdd3406c842a0e4be7efffd3a05dba6
> Author: Thierry Reding <thierry.reding@avionic-design.de>
> Date:   Thu Jun 14 09:12:35 2012 +0200
> 
>     of: match by compatible property first
>     
>     When matching devices against an OF device ID table, the first string of
>     the compatible property that is listed in the table should match,
>     regardless of its position in the table.
>     
>     Cc: Grant Likely <grant.likely@secretlab.ca>
>     Cc: Rob Herring <rob.herring@calxeda.com>
>     Cc: devicetree-discuss@lists.ozlabs.org
>     Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>     Signed-off-by: Rob Herring <rob.herring@calxeda.com>

The problem is match combinations of compatible plus name and/or type
fail to match correctly. I have a fix for this, but given how late it is
for 3.5 I think it is best to revert this for now. There could be other
cases that rely on the current although wrong behavior. I will post an
updated version for 3.6.

Linus, Please revert 107a84e61cdd3406c842a0e4be7efffd3a05dba6.

Rob
