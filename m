From: Robert Reif <reif@earthlink.net>
Date: Mon, 01 Dec 2008 12:41:07 +0000
Subject: Re: sparc next boot failure
Message-Id: <4933DB63.5030206@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49334590.8010703@earthlink.net>
In-Reply-To: <49334590.8010703@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:
> On Sun, Nov 30, 2008 at 09:01:52PM -0500, Robert Reif wrote:
>   
>> Current sparc next fails to boot (hangs at Booting Linux...).
>>
>> I bisected it down to this:
>>
>> 21cb8a43216e0595b466e903e0f2a7ae615d9e11 is first bad commit
>> commit 21cb8a43216e0595b466e903e0f2a7ae615d9e11
>> Author: Sam Ravnborg <sam@ravnborg.org>
>> Date:   Sat Nov 29 21:52:12 2008 -0800
>>
>>    sparc: refactor Makefile
>>    
>>    The btfixup step needs knowledge of all the .o files,
>>    but there is no need to pass them in independent variables.
>>    Simplify it to use only two variables.
>>    
>>    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>>    Signed-off-by: David S. Miller <davem@davemloft.net>
>>
>> :040000 040000 d5815835afa54122531d5bc8060f3831b145a1a4 
>> c8aad1a3c22a8243c5dd0ab2c528198d7d23af3c M arch
>>     
>
> Hi Robert.
>
> Can you try to add the following patch on top of
> the " sparc: refactor Makefile" patch.
>
> This was the only difference I could see in my
> limited testing here.
>
> 	Sam
>
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index 04ea968..da82ba6 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -44,6 +44,8 @@ ifdef CONFIG_KALLSYMS
>  kallsyms.o := .tmp_kallsyms2.o
>  endif
>  
> +export  kallsyms.o
> +
>  # Default target
>  all: zImage
>  
>
>   
I hand applied it to yesterdays sparc-next and it seems to have fixed it.

I'll do some more testing tonight when I have the time.


