From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 25 Nov 2016 21:00:18 +0000
Subject: Re: [patch] sparc: indent an if statement
Message-Id: <20161125210018.GB27864@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20161125110250.GC5938@mwanda>
In-Reply-To: <20161125110250.GC5938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Hi Dan.

On Fri, Nov 25, 2016 at 02:02:50PM +0300, Dan Carpenter wrote:
> The code works fine, but my static checker complains when we don't
> indent our if statements.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
> index 6d8dc2a..43f7d99 100644
> --- a/arch/sparc/prom/ranges.c
> +++ b/arch/sparc/prom/ranges.c
> @@ -43,7 +43,7 @@ static void prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
>  			if (ranges1[rng1c].ot_parent_space = ranges2[rng2c].ot_child_space &&
>  			   ranges1[rng1c].ot_parent_base >= ranges2[rng2c].ot_child_base &&
>  			   ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size - ranges1[rng1c].ot_parent_base > 0U)
> -			break;
> +				break;
>  		if (rng2c = nranges2) /* oops */
>  			prom_printf("adjust_ranges: Could not find matching bus type...\n");
>  		else if (ranges1[rng1c].ot_parent_base + ranges1[rng1c].or_size > ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size)

This is one ugly looking function....
If we are anyway fixing indent thus increasign readability,
then how about doing just a little more.
Like this untested patch.

I do not claim it is readable, but it is an improvement.

	Sam

diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index 6d8dc2a..271d62d 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -37,19 +37,25 @@ static void prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
 			       struct linux_prom_ranges *ranges2, int nranges2)
 {
 	int rng1c, rng2c;
+	struct linux_prom_ranges **rng1;
+	struct linux_prom_ranges **rng2;
 
 	for (rng1c = 0; rng1c < nranges1; rng1c++) {
-		for (rng2c = 0; rng2c < nranges2; rng2c++)
-			if (ranges1[rng1c].ot_parent_space = ranges2[rng2c].ot_child_space &&
-			   ranges1[rng1c].ot_parent_base >= ranges2[rng2c].ot_child_base &&
-			   ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size - ranges1[rng1c].ot_parent_base > 0U)
-			break;
+		rng1 = &ranges1[rng1c];
+		rng2 = &ranges2[0];
+		for (rng2c = 0; rng2c < nranges2; rng2c++) {
+			rng2 = &ranges2[rng2c];
+			if (rng1->ot_parent_space = rng2->ot_child_space &&
+			    rng1->ot_parent_base >= rng2->ot_child_base &&
+			    rng2->ot_child_base + rng2->or_size - rng1->ot_parent_base > 0U)
+				break;
+		}
 		if (rng2c = nranges2) /* oops */
 			prom_printf("adjust_ranges: Could not find matching bus type...\n");
-		else if (ranges1[rng1c].ot_parent_base + ranges1[rng1c].or_size > ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size)
-			ranges1[rng1c].or_size = ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size - ranges1[rng1c].ot_parent_base;
-		ranges1[rng1c].ot_parent_space = ranges2[rng2c].ot_parent_space;
-		ranges1[rng1c].ot_parent_base += ranges2[rng2c].ot_parent_base;
+		else if (rng1->ot_parent_base + rng1->or_size > rng2->ot_child_base + rng2->or_size)
+			rng1->or_size = rng2->ot_child_base + rng2->or_size - rng1->ot_parent_base;
+		rng1->ot_parent_space = rng2->ot_parent_space;
+		rng1->ot_parent_base += rng2->ot_parent_base;
 	}
 }
 
