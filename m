From: Heitzso <heitzso@bellsouth.net>
Date: Mon, 25 Apr 2005 10:09:26 +0000
Subject: Re: [PATCH 2.6] Fix mxcc warning
Message-Id: <426CC1D6.7070302@bellsouth.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1109917519.17038.87.camel@localhost.localdomain>
In-Reply-To: <1109917519.17038.87.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I apologize for asking a silly question, but is this series
of patches noted on this list being applied to the
main 2.6.X kernel series or just to a separate patch set?

BTW, anytime someone believes a kernel may have a small
chance of running ROSS HyperSparc SMP I'll be glad to
compile and test.

Thanks

> On Fri, 04 Mar 2005 00:25:19 -0600
> "Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:
> 
> 
>>Peter Jones uncovered this one while we were debugging the framebuffer
>>issues. There are some references to -1 in the mxcc asm code, which
>>should be 0xffffffff.
>>
>>This patch gets rid of the -1s.
>>
>>Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>
> 
> 
> Applied, thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

