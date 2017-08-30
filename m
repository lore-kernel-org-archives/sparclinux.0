From: David Miller <davem@davemloft.net>
Date: Wed, 30 Aug 2017 01:08:44 +0000
Subject: Re: [PATCH v7 04/11] sparc64: simplify vmemmap_populate
Message-Id: <20170829.180844.1866158985287686267.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1503972142-289376-1-git-send-email-pasha.tatashin@oracle.com>
 <1503972142-289376-5-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1503972142-289376-5-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 28 Aug 2017 22:02:15 -0400

> Remove duplicating code by using common functions
> vmemmap_pud_populate and vmemmap_pgd_populate.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>

Acked-by: David S. Miller <davem@davemloft.net>
