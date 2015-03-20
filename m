From: David Ahern <david.ahern@oracle.com>
Date: Fri, 20 Mar 2015 02:55:27 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <550B8C1F.3080508@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/19/15 7:56 PM, David Miller wrote:
> Applied, but two questions:
>
> 1) Why didn't you have to deal with the overflow event
>     latching issues I address in sparc_vt_write_pmc()?

I saw the note. I need to understand why you wrote that. Relevant 
sections of the PRM for the T4 and the M7 have the same wording, so I 
was surprised to read that. Perhaps a h/w (or h/w revision) quirk?

It was not needed for the M7 -- bare metal or LDOM -- so I opted to go 
with the purist approach based on the PRM. As I get time and access to 
hardware I will take a look at the T4.

>
> 2) How simple is it to hook up a similar set of support
>     for sparc-m6?  It seems like the only PMU type string
>     we won't match after this.

Ditto. Time and H/W access.


