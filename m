From: David Miller <davem@davemloft.net>
Date: Wed, 15 Aug 2012 23:43:31 +0000
Subject: Re: [PATCH] silo: Don't touch %tick_cmpr on sun4v cpus.
Message-Id: <20120815.164331.1874494086894024620.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120815.011416.353619816610212386.davem@davemloft.net>
In-Reply-To: <20120815.011416.353619816610212386.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 15 Aug 2012 01:14:16 -0700 (PDT)

> 
> This generates an illegal instruction exception.

Unfortunately, after some more testing, this needs a follow-on fix,
included below and also committed to SILO git.

Sorry for the confusion.

==========
silo: Don't assume P1275 OBP means sun4u.

It could also mean 'sun4v'.

Code this defensively, so that if (for whatever reason)
we can't get at the 'compatible' property in the root
OBP device node we'll still default to sun4u as previous.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 second/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/second/misc.c b/second/misc.c
index d6bcdb1..d789723 100644
--- a/second/misc.c
+++ b/second/misc.c
@@ -501,7 +501,7 @@ enum arch silo_get_architecture(void)
         if ((i = prom_searchsiblings(i, "MicroSPARC-IIep")) != 0) {
             return sun4p;
         }
-        return sun4u;
+	buffer[4] = 'u';
     }
     i = prom_getproperty (prom_root_node, "compatability", buffer, 8);
 
-- 
1.7.11.2

