From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 13 Nov 2012 03:25:37 +0000
Subject: Re: [PATCH] arch/sparc: additional len check in loop for prom_getbootargs
Message-Id: <50A1BDB1.5050003@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
References: <509B29F3.2040006@asianux.com>
In-Reply-To: <509B29F3.2040006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

于 2012年11月09日 00:33, Sam Ravnborg 写道:
> Hi Cheng.
> On Thu, Nov 08, 2012 at 11:41:39AM +0800, Chen Gang wrote:
>>
>>   when cp >= barg_buf + BARG_LEN-2, it only break internel loop (while)
>>   but outside loop (for) still has effect, and "*cp++ = ' '" repeating
>>   so need additional checking for it.
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> 
> I wonder how you found this bug?!?!

  I only find it through "code review".

    A) I grep all "strcpy" in kernel wide (about 2943 lines)

    B) I check them one by one.
         i)   when I check strcpy, also reading all relative source code.
         ii)  my goal is finding issues.
         iii) if I think it is valuable to continue reading, I will do.

    C) when find arch/sparc, I find this bug (although it is not relative with strcpy).


    It seems just starting (I have only finished checking 10 lines strcpy of 2943 lines),


> Anyway please consider this alternative fix:
> 
> diff --git a/arch/sparc/prom/bootstr_32.c b/arch/sparc/prom/bootstr_32.c
> index f5ec32e..4ce602f 100644
> --- a/arch/sparc/prom/bootstr_32.c
> +++ b/arch/sparc/prom/bootstr_32.c
> @@ -31,14 +31,10 @@ prom_getbootargs(void)
>  			arg = (*(romvec->pv_v0bootargs))->argv[iter];
>  			if (arg = NULL)
>  				break;
> -			while(*arg != 0) {
> -				/* Leave place for space and null. */
> -				if(cp >= barg_buf + BARG_LEN-2){
> -					/* We might issue a warning here. */
> -					break;
> -				}
> +			while (*arg != 0 && cp < (barg_buf + BARG_LEN - 2))
>  				*cp++ = *arg++;
> -			}
> +
> +			/* Append trailing space + null */
>  			*cp++ = ' ';
>  		}
>  		*cp = 0;
> 
> 
> Adding the conditional inside the while loop makes
> the logic simpler. And the patch actually deletes more lines than it adds.
> And please take care to follow coding style too. In particular spaces around operators.
> 
> The old code does not follow coding style - but this is no excuse.
> 

  I agree with the contents above.



> Note - the above is not even build tested!
> 

  A) I think, it will be better to give a test (although it seems obviously)
  B) but sorry for I have no relative environments now.
     i)   if testing is necessary;
     ii)    also if you have no environments, either.
     iii)       I should try. (please tell me)


> If you use the above code-snippet you can add my:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 

  I think it is necessary, you can do it, automatically.
  if truly need I do, please tell me.



-- 
Chen Gang

Asianux Corporation
