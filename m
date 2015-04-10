From: chris hyser <chris.hyser@oracle.com>
Date: Fri, 10 Apr 2015 15:27:23 +0000
Subject: Re: [PATCH v3] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <5527EBDB.2000701@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
In-Reply-To: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/9/2015 7:06 PM, David Miller wrote:
> How will this work on T3, T2, and T1 which all neither have the
> "socket" mdesc nodes nor level 3 caches?

The patch only works for sun4v and is only called in that path. If this is broken for older architectures it will 
require a completely different solution. I do not believe there is sufficient info in the openboot device tree and even 
if there was that would be insufficient for sun4v as it is never updated in the presence of dynamic addition/removal of 
processors as the machine description table is. That said, this patch will likely need refinement when someone tries to 
get that working again. I've tested adding and removing CPUs on a few older kernels and it's broke though the code 
suggests it worked at some point in the past. It is on my list of things to look at, but no where near the top.

-chrish

