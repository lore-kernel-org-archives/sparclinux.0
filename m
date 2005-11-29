From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 29 Nov 2005 21:46:57 +0000
Subject: Re: Bad pte in exit_mmap, 2.6.15-rc3
Message-Id: <20051129.134657.120175360.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0511291602270.20932@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0511291602270.20932@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 29 Nov 2005 16:05:03 +0200 (EET)

> Testbooted 2.6.15-rc3 on my U5. All services started fine and then it 
> started flooding this.
> 
> This is just FYI - I will be away from that machine for 3 next days and 
> can't test any patches this time.

This will fix it, thanks for the report:

diff --git a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
index d9396c1..580b63d 100644
--- a/arch/sparc64/mm/generic.c
+++ b/arch/sparc64/mm/generic.c
@@ -77,6 +77,7 @@ static inline void io_remap_pte_range(st
 			BUG_ON(!pte_none(*pte));
 			set_pte_at(mm, address, pte, entry);
 			address += PAGE_SIZE;
+			pte_val(entry) += PAGE_SIZE;
 			pte++;
 		} while (address < curend);
 	} while (address < end);
