From: Bob Picco <bpicco@meloft.net>
Date: Thu, 25 Sep 2014 19:52:38 +0000
Subject: Re: [PATCH V3] sparc64: sparse irq
Message-Id: <20140925195238.GG4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Thu Sep 25 2014, 03:28:29PM EDT]
> 
> Ok Bob, I think I've resolved everything, and I made some minor
> adjustments to your patch.  The final version is below and works
> well for me.
> 
> The changes I made were roughly:
> 
> 1) Add a helper test function sun4v_cookie_only_virqs()
> 
> 2) Put a big comment above that function explaining the version
>    behaviors.  Adjust the commit log message to match.
> 
> 3) Don't bark in the kernel log if the negoatiation fails.  But do
>    print an informative message about what style of IRQs we are going
>    to use.
> 
> 4) Minor indentation fixes here and there.
> 
> Let me know if this works for you:
Looks good to me. I also learned what caused me much pain.

thanx!
