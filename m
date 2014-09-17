From: David Miller <davem@davemloft.net>
Date: Wed, 17 Sep 2014 00:55:46 +0000
Subject: Re: [PATCH V2] sparc64: find_node adjustment
Message-Id: <20140916.205546.1331887791745762310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410874095-11814-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410874095-11814-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 09:28:15 -0400

> From: bob picco <bpicco@meloft.net>
> 
> We have seen an issue with guest boot into LDOM that causes early boot failures
> because of no matching rules for node identitity of the memory. I analyzed this
> on my T4 and concluded there might not be a solution. I saw the issue in
> mainline too when booting into the control/primary domain - with guests
> configured.  Note, this could be a firmware bug on some older machines.
> 
> I'll provide a full explanation of the issues below. Should we not find a
> matching BEST latency group for a real address (RA) then we will assume node 0.
> On the T4-2 here with the information provided I can't see an alternative.
> 
> Technically the LDOM shown below should match the MBLOCK to the
> favorable latency group. However other factors must be considered too. Were
> the memory controllers configured "fine" grained interleave or "coarse"
> grain interleaved -  T4. Also should a "group" MD node be considered a NUMA
> node?
> 
> There has to be at least one Machine Description (MD) "group" and hence one
> NUMA node. The group can have one or more latency groups (lg) - more than one
> memory controller. The current code chooses the smallest latency as the most
> favorable per group. The latency and lg information is in MLGROUP below.
> MBLOCK is the base and size of the RAs for the machine as fetched from OBP
> /memory "available" property. My machine has one MBLOCK but more would be
> possible - with holes?
 ...
> Signed-off-by: Bob Picco <bob.picco@oracle.com>
> ---
> V2: remove Oracle only accessible URL.

Applied.
