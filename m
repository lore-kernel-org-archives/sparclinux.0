From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 02 Feb 2011 09:34:55 +0000
Subject: Re: [PATCH] sparc32: unaligned memory access (MNA) trap handler bug
Message-Id: <4D49253F.8060300@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1296583423-5469-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296583423-5469-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Sam Ravnborg <sam@ravnborg.org>
>Date: Tue, 1 Feb 2011 20:59:26 +0100
>
>  
>
>>On Tue, Feb 01, 2011 at 07:03:43PM +0100, Daniel Hellstrom wrote:
>>    
>>
>>>Since the merge process of the sparc and sparc64 the sparc32
>>>MNA trap handler does not emulate stores to unaligned addresses
>>>correctly. MNA operation from both from kernel and user space
>>>are affected.
>>>      
>>>
>>Well spotted!
>>    
>>
>
>Indeed.
>  
>
Thanks, we have seen this problem pop up now and then since nov/dec but 
unable to trigger it stable. Debugging such a problem often requires a 
quite long time and since I can not work fulltime with Linux it took 
some time before I could fully focus on it. Of course at first I thought 
if was a LEON problem, then a GRETH network driver problem, then SMP 
related... Last week I spent a lot time tracing, and thanks to a great 
HW team here at Gaisler that made me a system with better hardware 
debugging support and the excellent GRMON I was able to find it at last.

I really hope that the sparc community can take benefit of the time we 
invested in this. Now that we are more synced with the official kernel 
and hopefully SMP will work better, I think it will be much easier for 
us to spot and fix generic problems as they appear in the future. Thanks!

>  
>
>>This bug was actually introduced by:
>>f0e98c387e61de00646be31fab4c2fa0224e1efb "[SPARC]: Fix link errors with gcc-4.3"
>>    
>>
>
>I'll make a note of this in the commit message.
>
>  
>
>>A better way to do so is to add:
>>
>>Cc: <stable@kernel.org>
>>
>>Then the stable team(s) will all be notified when this patch is applied
>>by Linus to mainline.
>>    
>>
>
>I'll take care of the -stable submission.
>  
>
Good, thanks, that was my intention but didn't know there was a 
procedure like this. Will stick to that in the future if more problems 
like this arise.

>I wish binutils wouldn't accept %1 as a register, nobody sane uses that
>format for register specifications and when it does happen (like here)
>it's a typo and a bug.
>  
>
I agree.

>Thanks guys, I'll apply this and queue it up for -stable!
>  
>
nice.

