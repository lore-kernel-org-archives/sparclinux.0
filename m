From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 13 Nov 2012 05:29:55 +0000
Subject: Re: [PATCH] arch/sparc: additional len check in loop for prom_getbootargs
Message-Id: <50A1DAD3.40305@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
References: <509B29F3.2040006@asianux.com>
In-Reply-To: <509B29F3.2040006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

于 2012年11月13日 13:06, David Miller 写道:
> From: Chen Gang <gang.chen@asianux.com>
> Date: Tue, 13 Nov 2012 12:46:17 +0800
> 
>> 1) although I agree with what you said.
>>
>> 2) but for the patch code:
>>    after "*cp++ = ' ';", also need "break checking" for "for (; ;)" outside of "while()"
>>
>> 3) please check, and still it will be better to notice coding style, too.
> 
> Why is every single one of your replies a set of 3 bullet points?  You
> aren't giving a PowerPoint presentation.
> 
> Just talk and discuss things normally, using sentences and paragraphs
> for your structure.
> 
> Everything you say and do looks very unnatural, awkward, and forced.
> 
> 

 Excuse me,, my English is not quite well, just as you said (I need improving)


 after "*cp++ = ' ';" at line 42, also need "break checking" for "for (; ;)" outside of "while()"

 the reply from sam not check it, (the patch what I sent check it).

 this is the original source code of function prom_getbootargs in arch/sparc/prom/bootstr_32.c.
------------------------------------------------------------------------------------------------
 27         case PROM_V0:
 28                 cp = barg_buf;
 29                 /* Start from 1 and go over fd(0,0,0)kernel */
 30                 for(iter = 1; iter < 8; iter++) {
 31                         arg = (*(romvec->pv_v0bootargs))->argv[iter];
 32                         if (arg = NULL)
 33                                 break;
 34                         while(*arg != 0) {
 35                                 /* Leave place for space and null. */
 36                                 if(cp >= barg_buf + BARG_LEN-2){
 37                                         /* We might issue a warning here. */
 38                                         break;
 39                                 }
 40                                 *cp++ = *arg++;
 41                         }
 42                         *cp++ = ' ';
 43                 }
 44                 *cp = 0;
 45                 break;
---------------------------------------------------------------------------------------------------


this is the original reply from sam:
--------------------------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------------




-- 
Chen Gang

Asianux Corporation
