From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 30 Mar 2011 09:46:02 +0000
Subject: Re: [PATCH 1/2 v2] sparc32,leon: APBUART driver must use archdata
Message-Id: <4D92FBDA.8060005@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1300345617-24602-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300345617-24602-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


David Miller wrote:

>Please make it explicit and clear in the future when you are posting
>patches against Sam's genirq work.
>
>Otherwise I spend a lot of time trying to figure out why your patches
>don't apply to me tree.
>  
>
Ok, sorry.

The APBUART patches can be applied independent of Sam's patches.

They are neccessary after Sam's patches in order to boot Linux on LEON. 
But are also valid before Sam's patches.

Thanks,
Daniel

