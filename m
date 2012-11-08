From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 08 Nov 2012 16:33:48 +0000
Subject: Re: [PATCH] arch/sparc: additional len check in loop for prom_getbootargs
Message-Id: <20121108163348.GA7729@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <509B29F3.2040006@asianux.com>
In-Reply-To: <509B29F3.2040006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Cheng.
On Thu, Nov 08, 2012 at 11:41:39AM +0800, Chen Gang wrote:
> 
>   when cp >= barg_buf + BARG_LEN-2, it only break internel loop (while)
>   but outside loop (for) still has effect, and "*cp++ = ' '" repeating
>   so need additional checking for it.
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

I wonder how you found this bug?!?!
Anyway please consider this alternative fix:

diff --git a/arch/sparc/prom/bootstr_32.c b/arch/sparc/prom/bootstr_32.c
index f5ec32e..4ce602f 100644
--- a/arch/sparc/prom/bootstr_32.c
+++ b/arch/sparc/prom/bootstr_32.c
@@ -31,14 +31,10 @@ prom_getbootargs(void)
 			arg = (*(romvec->pv_v0bootargs))->argv[iter];
 			if (arg = NULL)
 				break;
-			while(*arg != 0) {
-				/* Leave place for space and null. */
-				if(cp >= barg_buf + BARG_LEN-2){
-					/* We might issue a warning here. */
-					break;
-				}
+			while (*arg != 0 && cp < (barg_buf + BARG_LEN - 2))
 				*cp++ = *arg++;
-			}
+
+			/* Append trailing space + null */
 			*cp++ = ' ';
 		}
 		*cp = 0;


Adding the conditional inside the while loop makes
the logic simpler. And the patch actually deletes more lines than it adds.
And please take care to follow coding style too. In particular spaces around operators.

The old code does not follow coding style - but this is no excuse.

Note - the above is not even build tested!

If you use the above code-snippet you can add my:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
