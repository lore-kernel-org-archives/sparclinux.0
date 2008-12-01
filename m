From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 01 Dec 2008 05:50:17 +0000
Subject: Re: sparc next boot failure
Message-Id: <20081201055017.GA21782@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <49334590.8010703@earthlink.net>
In-Reply-To: <49334590.8010703@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 30, 2008 at 09:01:52PM -0500, Robert Reif wrote:
> Current sparc next fails to boot (hangs at Booting Linux...).
> 
> I bisected it down to this:
> 
> 21cb8a43216e0595b466e903e0f2a7ae615d9e11 is first bad commit
> commit 21cb8a43216e0595b466e903e0f2a7ae615d9e11
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Sat Nov 29 21:52:12 2008 -0800
> 
>    sparc: refactor Makefile
>    
>    The btfixup step needs knowledge of all the .o files,
>    but there is no need to pass them in independent variables.
>    Simplify it to use only two variables.
>    
>    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>    Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> :040000 040000 d5815835afa54122531d5bc8060f3831b145a1a4 
> c8aad1a3c22a8243c5dd0ab2c528198d7d23af3c M arch

Hi Robert.

Thanks for testing and bisecting!

Can I ask you to send me the output of make V=1 for
your kernel before and after the above patch is applied.
It's only the last few lines that are of interest (from btfixup
and onwards).
I hope from that to say what is causing the boot regression.

	Sam
